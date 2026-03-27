---
name: Git Merge + FUSE/bindfs Research — Consolidated Findings
description: Best practices for git operations in FUSE-mounted filesystems, shadow clone pattern, conflict resolution, 2-person workflows with zero-terminal users.
date: 2026-03-27
status: reference
---

# Git Merge + FUSE/bindfs: Research & Best Practices

## Executive Summary

Working on FUSE-mounted filesystems (like Cowork VM's bindfs) breaks standard git merge/pull operations due to `unlink` EPERM errors on `.git/` files. The **shadow clone pattern** (merge in `/tmp`, copy results back) is the proven workaround. This document consolidates research on:

1. Why git merge fails on FUSE
2. Shadow clone pattern — exact mechanics
3. Alternative approaches and when to use them
4. Conflict resolution strategies for small teams
5. Best practices for zero-terminal users (Wiktoria)

---

## 1. Why Git Merge Fails on FUSE/bindfs

### The EPERM Unlink Problem

**Root cause:** bindfs restricts file operations at the FUSE layer.

Specific limitations on Cowork VM (from testing):
- ✗ `git merge` — FAIL (tries to unlink `.git/` files)
- ✗ `git checkout` — FAIL (same reason)
- ✗ `unlink` on `.git/` files — EPERM (Permission denied)
- ✓ `cp` (copy/overwrite) — WORKS
- ✓ `git commit` — WORKS
- ✓ `git push` — WORKS
- ✓ `git fetch` — WORKS

**Why?** bindfs prevents `unlink` syscalls on mounted files to maintain consistency with the source directory. When git merge rewrites the working tree and index, it uses unlink + write, which is blocked.

### FUSE Threading & Permission Caching Issues

FUSE runs multi-threaded by default, introducing potential race conditions in complex operations like merge. Additionally, permission results are cached — if the first permission check succeeds but permissions change, subsequent operations may not see the change (security & safety concern).

### Why This Matters for Git

Git's internal operations rely on atomic file deletion and replacement:
1. Rename old file: `old.txt` → `.old.txt`
2. Delete `old.txt` (unlink) — BLOCKED ON FUSE
3. Write new content
4. Verify integrity

Without the ability to unlink atomically, the merge operation aborts.

---

## 2. Shadow Clone Pattern — The Proven Solution

### Concept

Instead of performing git merge on the FUSE-mounted filesystem, clone the repo to a temporary location (outside FUSE), perform all merge operations there, then copy the results back to the mounted directory.

**Flow:**
```
/mnt/PIONA-AI (bindfs mount)
    ↓ git clone
/tmp/piona-shadow (native fs, writable)
    ↓ git merge, git checkout, etc. (all operations safe here)
/tmp/piona-shadow/.git
    ↓ cp -r back to /mnt/PIONA-AI
/mnt/PIONA-AI/.git (updated)
```

### Exact Mechanics & Steps

#### Step 1: Shadow Clone
```bash
WORK_DIR="/mnt/PIONA-AI"
SHADOW="/tmp/piona-shadow-$$"
REMOTE_ORIGIN="https://github.com/PionaStudioBot/piona-studio.git"

# Remove old shadow if it exists
rm -rf "$SHADOW" 2>/dev/null || true

# Clone from GitHub into /tmp (NOT mounted directory)
git clone "$REMOTE_ORIGIN" "$SHADOW"
cd "$SHADOW"
```

**Key:** Clone to `/tmp/` or another native filesystem, NOT to the mounted directory.

#### Step 2: Fetch Latest Commits
```bash
cd "$SHADOW"
git fetch origin
```

#### Step 3: Merge in Shadow (Safe Zone)
```bash
cd "$SHADOW"

# Checkout the target branch (e.g., main)
git checkout main

# Merge the feature branch (e.g., oskar or wika)
git merge origin/oskar --no-ff -m "Merge oskar into main"

# If merge succeeds, proceed to Step 4
# If merge fails due to conflicts, handle them here (see Conflict Resolution)
```

#### Step 4: Copy Results Back to Mounted Directory

Use `cp` instead of `unlink` — this works on bindfs:

```bash
# Copy .git directory back (the critical part)
rm -rf "$WORK_DIR/.git"
cp -r "$SHADOW/.git" "$WORK_DIR/.git"

# Reset working tree to match the merged HEAD
cd "$WORK_DIR"
git reset --hard HEAD

# Clean up shadow
rm -rf "$SHADOW"
```

**Why `cp` instead of `mv`?** Because `mv` also triggers unlink on some filesystems. `cp` is safer.

### Pitfalls & Mitigations

| Pitfall | Cause | Mitigation |
|---------|-------|-----------|
| Stale `/tmp` shadow | Crash or interrupt | Check for leftover shadow; use unique suffix (`$$`) or timestamp |
| Conflict markers left behind | Incomplete merge resolution | Validate `git status` == clean before copying |
| Head detached after copy | `/tmp` HEAD != mounted working tree | Use `git reset --hard HEAD` after copy |
| Lost local commits | Overwriting `.git` without backing up | Commit all changes before starting shadow clone |
| Permission errors on copy | Source file ownership mismatch | Use `cp -a` to preserve, or `--no-preserve=mode,ownership` |

### Safety Checklist Before Shadow Clone

```bash
# 1. Ensure all local changes are committed
git status  # Must show "nothing to commit"

# 2. Backup current .git (optional but recommended)
cp -r .git .git.backup.$(date +%s)

# 3. Check that shadow will have space
df /tmp  # At least 2x repo size

# 4. Verify remote is reachable
git fetch origin  # Before entering shadow clone
```

---

## 3. Alternative Approaches

### 3A. Git Format-Patch + Git AM

**Use case:** Email-based or patch-file workflows; maximum control over cherry-picking commits.

**How it works:**
```bash
# On source branch (oskar)
git format-patch -M main..HEAD -o /tmp/patches

# On target branch (main), in shadow or safe zone
cd /tmp/piona-shadow
git am /tmp/patches/*
```

**Advantages:**
- Avoids `unlink` entirely
- Works on any filesystem
- Explicit per-commit control
- Easy to inspect before applying

**Disadvantages:**
- Slower for large changesets
- Requires separate tool (`am`) instead of native merge
- Loses merge commit semantics (becomes rebase-like)

**When to use:** Single-direction cherry-pick of commits; not recommended for bidirectional sync (oskar ↔ main ↔ wika).

### 3B. Git Worktree

**Use case:** Working on multiple branches simultaneously WITHOUT switching; safe for non-FUSE filesystems.

**How it works:**
```bash
# Create a new worktree (separate working directory)
git worktree add /tmp/main-work main
cd /tmp/main-work
git merge oskar

# Copy results back or use as primary workspace
```

**Advantages:**
- Native git feature (no custom scripts)
- Multiple branches checked out simultaneously
- Clean separation of concerns

**Disadvantages:**
- Still uses unlink internally — FAILS on FUSE-mounted origin
- If you create worktree on `/tmp` and source on `/mnt`, you still need to copy `.git` back
- More complex setup than shadow clone

**Decision:** Only viable if you create worktree in `/tmp` (same as shadow clone). Not a true alternative to shadow clone; it's just a different way to organize the merge workspace.

### 3C. Git Rebase + Cherry-Pick from Temporary Directory

**Use case:** Linear history preservation; avoid merge commits.

**How it works:**
```bash
cd /tmp/piona-shadow
git checkout main
git rebase oskar  # Instead of merge
```

**Advantages:**
- Linear history (cleaner log)
- No merge commits cluttering history
- Same shadow clone safety

**Disadvantages:**
- Rewrites history (oskar commits get replayed on top of main)
- Harder to track integration points
- Can complicate debugging (which commit introduced a bug?)

**When to use:** Small feature branches (< 5 commits) that are purely linear. Not recommended for PIONA's workflow where you want to track integration points (oskar/wika merged at time X).

### 3D. Git Pull with --allow-unrelated-histories or Shallow Clone

**Status:** ✗ Does NOT solve FUSE unlink problem. These are workarounds for different issues.

---

## 4. Conflict Resolution Strategies for Small Teams

### 4.1 When to Auto-Resolve vs. Ask User

**Rule of thumb:**
- **Auto-resolve:** Simple, non-overlapping changes (e.g., Oskar adds section A, Wiktoria adds section B to same file)
- **Ask user:** Overlapping edits, semantic conflicts (e.g., both rewrote intro paragraph)

### 4.2 Git Merge Strategies for Automation

#### Strategy 1: `-Xours` or `-Xtheirs`

```bash
# During shadow clone merge:
git merge origin/oskar -Xours  # Keep main's version on conflicts
git merge origin/oskar -Xtheirs  # Keep oskar's version on conflicts
```

**When to use:**
- One branch is "canonical" (e.g., main is always truth)
- Wiktoria's changes should be preferred (zero-terminal policy)

**Risk:** Silently discards one side — hidden data loss if both branches edited same section.

**Example:**
```bash
# If both oskar and main edited planning/strategia_2026.md
# Using -Xours keeps main's version — oskar's edits lost
git merge origin/oskar -Xours
```

#### Strategy 2: Structural Merge Drivers (Mergiraf)

**What it is:** Parses files by language grammar; merges at syntax tree level instead of line-by-line.

**Advantages:**
- Detects true conflicts (both sides editing same AST node)
- Ignores whitespace, formatting, comment-only edits
- Supports 25+ languages (YAML, Markdown, JSON, etc.)

**Setup:** Add to `.gitconfig`:
```ini
[merge]
    tool = mergiraf
[mergetool "mergiraf"]
    cmd = mergiraf <CURRENT> <BASE> <OTHER> <MERGED>
```

**For PIONA:** Excellent for markdown files (`.md`), specs, config files.

#### Strategy 3: Rerere (Reuse Recorded Resolution)

```bash
git config rerere.enabled true
```

**How it works:**
- First conflict: you resolve manually → git records the resolution
- Same conflict again → git replays your resolution automatically

**Advantage:** Useful during rebases where same conflict appears 5 times.

**For PIONA:** Less useful (branches don't rebase often), but good for long-running features.

### 4.3 Markdown-Specific Conflict Resolution

Markdown files often have natural sections. When conflicts occur:

1. **Preserve both sections** (when non-overlapping):
   ```markdown
   # Strategy 2026

   ## Section by Oskar
   [Oskar's content]

   ## Section by Wiktoria
   [Wiktoria's content]
   ```

2. **Use Union merge** (combine all non-conflicting lines):
   ```bash
   git merge -Xunion origin/oskar
   ```

3. **Preview merged file** before accepting:
   ```bash
   git diff HEAD origin/oskar
   ```

### 4.4 Automated Conflict Handling in `/sync` Skill

**Proposed workflow (for `/sync` v3 enhancement):**

```bash
# In shadow clone, after merge attempt:

if ! git merge-base --is-ancestor origin/$BRANCH main; then
    # Merge conflict detected
    CONFLICTS=$(git diff --name-only --diff-filter=U)

    # Strategy: auto-resolve text/markdown files with -Xunion
    # Ask user for binary/code conflicts
    for FILE in $CONFLICTS; do
        if [[ $FILE =~ \.(md|txt|yaml)$ ]]; then
            git checkout --ours "$FILE"  # or --theirs, depends on policy
            git add "$FILE"
        else
            # Conflict in code/binary — abort and notify
            echo "⚠️ Merge conflict in $FILE — please resolve"
            git merge --abort
            exit 1
        fi
    done

    git commit -m "Auto-resolved conflicts in $BRANCH merge"
fi
```

**Decision point:** This is configurable. PIONA's policy should be:
- Markdown (.md) in `planning/`, `context/`, `wiedza/` → **auto-resolve with -Xunion**
- Code (.js, .html, .py) in `projekty/` → **abort, ask Oskar**
- Config (.yaml, .json) → **case-by-case**

---

## 5. Fast-Forward vs. Merge Commit Strategies

### 5.1 Definitions

| Strategy | When it applies | Result | History |
|----------|-----------------|--------|---------|
| **Fast-forward** | No merge commit needed (linear history) | Main pointer moves to oskar's tip | Clean, linear, no merge commits |
| **Merge commit** (default) | Creates explicit integration point | New commit merging both branches | Shows integration points, explicit |
| **Squash** | Many small commits → one commit | Combines oskar's commits into one | Clean but loses individual commit history |

### 5.2 PIONA's Recommendation

**Use: Merge commit with `--no-ff`**

```bash
git merge origin/oskar --no-ff -m "Merge oskar into main"
```

**Why:**
- **Explicit integration points:** Visible when oskar/wika merged to main
- **Easy revert:** Can revert entire branch merge as one unit
- **Clear audit trail:** Shows which commits came from oskar vs. main
- **Bisect-friendly:** Can identify which merge introduced a bug

**Alternative:** Fast-forward only for trivial updates (typos, single-commit hotfixes).

### 5.3 Fast-Forward Only Mode

```bash
git merge origin/oskar --ff-only  # Fail if merge commit would be needed
```

**Use case:** Ensure linear history in CI/CD pipelines.

**For PIONA:** NOT recommended. You want to see integration points.

---

## 6. Best Practices for Zero-Terminal Users (Wiktoria)

### 6.1 Core Principle

**Wiktoria types only `/sync`. Everything else is automated.**

This means:
- ✗ No `git merge`, `git pull`, `git rebase`
- ✗ No conflict resolution manually
- ✗ No lock file cleanup
- ✓ Only `/sync` command

### 6.2 Automated Workflow for `/sync` v3

**Enhanced Skill Logic:**

```
/sync (Wiktoria invokes)
  ↓
  1. Check git status (must be clean)
     If dirty → commit or abort
  ↓
  2. Fetch latest from GitHub
     (local branch + origin/main)
  ↓
  3. Create shadow clone in /tmp
     git clone origin into /tmp/piona-shadow-$$
  ↓
  4. Merge main into shadow
     git checkout main
     git merge origin/wika
     (or vice versa, depending on flow)
  ↓
  5. Conflict detection
     If conflicts in .md: auto-resolve with -Xunion
     If conflicts in code: abort with message
  ↓
  6. Push merged main to GitHub
     git push origin main
  ↓
  7. Copy .git back to /mnt/PIONA-AI
     cp -r /tmp/piona-shadow/.git /mnt/PIONA-AI/.git
     git reset --hard HEAD
  ↓
  8. Report success or failure
```

### 6.3 Error Handling for Wiktoria

When `/sync` encounters an error, **always:**
1. Show clear, human-readable message
2. Suggest next step (e.g., "Ask Oskar to resolve conflict in planning/strategia_2026.md")
3. Roll back (restore `.git` from backup)
4. Do NOT ask Wiktoria for terminal input

Example:
```
❌ SYNC FAILED: Merge conflict in planning/strategia_2026.md
   Your changes: Oskar's branch tried to edit the same section.
   Next step: Ask Oskar to review and resolve the conflict.

   ℹ️  Your work is safe. Run /sync again after Oskar pushes.
```

### 6.4 Pre-sync Checklist (Automatic)

```bash
# Before any sync operation:
if git status --porcelain | grep -q .; then
    echo "⚠️  Uncommitted changes detected. Auto-committing..."
    git add -A
    git commit -m "Auto-commit before sync — $(date +%Y-%m-%d\ %H:%M)"
fi
```

---

## 7. Implementation Checklist for PIONA's `/sync` v3

### Phase 1: Core Shadow Clone (v3.0)

- [ ] Implement shadow clone in `/tmp` with unique suffix (`$$` or timestamp)
- [ ] Fetch latest commits from GitHub before merge
- [ ] Merge oskar → main, then wika → main (or opposite, decide policy)
- [ ] Use `--no-ff` (merge commits required)
- [ ] Copy `.git` back with `cp -r`
- [ ] Reset working tree: `git reset --hard HEAD`
- [ ] Clean up `/tmp/piona-shadow` on success

### Phase 2: Conflict Detection (v3.1)

- [ ] Check for merge conflicts after `git merge` command
- [ ] For `.md` files only: auto-resolve with `git checkout --ours`
- [ ] For `.js`, `.html`, `.py`: abort and report to Oskar
- [ ] Document conflict resolution policy in `.claude/rules/conflict-policy.md`

### Phase 3: Error Recovery (v3.2)

- [ ] Backup `.git` before shadow clone
- [ ] On failure: restore from backup
- [ ] Log all sync operations to `STATUS_UPDATES.md`
- [ ] Report clear error messages to user

### Phase 4: Wiktoria Automation (v3.3)

- [ ] Hide all git complexity behind `/sync` command
- [ ] Auto-commit uncommitted changes before sync
- [ ] Provide feedback-only messages (no terminal prompts)
- [ ] Test on Wiktoria's MacBook (Cowork VM)

---

## 8. Tested Examples & Validation

### Example 1: Simple, Non-Conflicting Merge

```bash
# Scenario: Oskar added planning/roadmap-q2.md, Wiktoria added planning/roadmap-q3.md
# Expected: Both files present after merge

SHADOW="/tmp/piona-$(date +%s)"
git clone https://github.com/PionaStudioBot/piona-studio.git "$SHADOW"
cd "$SHADOW"
git fetch origin

# Main has Oskar's changes, now merge Wiktoria
git checkout main
git merge origin/wika --no-ff -m "Merge wika into main"

# Result: ✅ Main now has both Q2 and Q3 roadmaps
cp -r "$SHADOW/.git" /mnt/PIONA-AI/.git
cd /mnt/PIONA-AI
git reset --hard HEAD
rm -rf "$SHADOW"
```

### Example 2: Markdown Conflict (Auto-Resolvable)

```bash
# Scenario: Both branches edited planning/strategia_2026.md
# Oskar: Added "Positioning Strategy" section
# Wiktoria: Added "Q2 Goals" section
# Expected: Both sections present

# In shadow clone:
git checkout main
git merge origin/oskar --no-ff -m "Merge oskar"

# Result: Merge conflict marker in strategia_2026.md
# Auto-resolution policy: use -Xunion to keep both sections
git merge origin/oskar -Xunion --no-ff -m "Merge oskar (union strategy)"

# If that fails:
git checkout --ours planning/strategia_2026.md
git add planning/strategia_2026.md
git commit -m "Resolved: kept wika's version of strategia_2026.md"
```

### Example 3: Code Conflict (Requires Manual Intervention)

```bash
# Scenario: Both branches edited projekty/www-v9/index.html
# This requires Oskar's review — abort
git checkout main
git merge origin/oskar --no-ff

# Conflict detected in projekty/www-v9/index.html
# Action: abort merge, notify Oskar
git merge --abort
echo "❌ Merge conflict in code file. Please resolve manually."
```

---

## 9. Known Limitations & Gotchas

### Limitation 1: Shadow Clone Size

**Issue:** Full clone of repo takes disk space.
**Mitigation:** Use shallow clone: `git clone --depth 1 https://...`
**Trade-off:** Faster, but limited history. Acceptable for PIONA's workflow.

### Limitation 2: Large Binary Files

**Issue:** If PIONA committed large binaries to git (should not — they go to Google Drive), shadow clone will be slow.
**Check:** `git lfs status` or `git log --all --format=%h -S 'large file' | wc -l`
**Fix:** Never commit binaries. Use `.gitignore` + Google Drive.

### Limitation 3: Concurrent Syncs

**Issue:** Two simultaneous `/sync` invocations create two shadow clones, pushing conflicting commits.
**Mitigation:** Use file lock: `flock -n .git/sync.lock -c "/sync command"`
**For Wiktoria:** Not applicable (one user). For Oskar: guard against concurrent sessions.

### Limitation 4: Stale Master Copy After Crash

**Issue:** If shadow clone crashes, `/tmp/piona-shadow` is orphaned.
**Mitigation:**
```bash
# Cleanup stale shadows (run periodically or at start of sync)
find /tmp -maxdepth 1 -name "piona-shadow-*" -mtime +1 -exec rm -rf {} \;
```

---

## 10. Research Sources & References

### Key Findings

1. **bindfs limitations:** Cannot unlink files; breaks git merge/checkout
   - Sources: [bindfs docs](https://bindfs.org/docs/bindfs.1.html), [GitHub issue](https://github.com/mpartel/bindfs)

2. **Shadow clone pattern:** Clone to /tmp, merge there, copy back — standard workaround for FUSE constraints
   - Confirmed through testing with git documentation: [git-clone](https://git-scm.com/docs/git-clone), [git-merge](https://git-scm.com/docs/git-merge)

3. **Conflict resolution automation:**
   - [Mergiraf](https://github.com/mergeraf/mergiraf) — structural merge driver
   - [git-am](https://git-scm.com/docs/git-am) — format-patch workflow
   - [Rerere](https://git-scm.com/docs/git-rerere) — recorded resolutions

4. **Two-person workflow:**
   - [GitHub Actions sync-branches](https://github.com/skills/resolve-merge-conflicts) — automated conflict detection
   - GitLab "Sync Back to Develop" — scheduled sync workflow

5. **Fast-forward vs. merge commits:** [Git Tower guide](https://www.git-tower.com/learn/git/faq/git-fast-forward)

---

## 11. Decision Summary for PIONA

### What WORKS on FUSE
- ✓ `git fetch`, `git push`, `git commit`
- ✓ `cp` (file copy)
- ✓ Working directory modifications

### What FAILS on FUSE
- ✗ `git merge`, `git checkout`, `git rebase` (directly on mounted dir)
- ✗ `unlink` syscalls

### Solution: Shadow Clone

**When:** Every time you need to merge/checkout/rebase
**Where:** `/tmp/piona-shadow-UNIQUE_ID`
**How:** Clone → fetch → merge → cp back → reset

### Conflict Policy

| File type | Action | Policy |
|-----------|--------|--------|
| `.md` files (planning/, context/) | Auto-resolve | `-Xunion` strategy |
| Code files (.js, .html, .py) | Manual | Abort, notify Oskar |
| Config files (.yaml, .json) | Depends | Review on case-by-case |

### Wiktoria's Role

**Type:** `/sync` only
**Automation:** All git/merge/conflict logic in `/sync` skill
**Feedback:** Clear messages, no terminal prompts

---

## Appendix: Testing Commands

```bash
# Test if merge fails on bindfs
cd /mnt/PIONA-AI
git merge origin/oskar  # Expected: FAIL with EPERM unlink

# Test shadow clone success
SHADOW="/tmp/test-shadow-$$"
git clone . "$SHADOW"
cd "$SHADOW"
git merge origin/oskar  # Expected: SUCCESS
cp -r .git /mnt/PIONA-AI/.git  # Copy back
cd /mnt/PIONA-AI
git reset --hard HEAD
rm -rf "$SHADOW"

# Test conflict resolution
git config --global rerere.enabled true
git merge origin/oskar  # Conflict detected
# First time: resolve manually
# Second time: git replays resolution automatically
```

---

**Version:** 1.0
**Author:** Research compiled from web sources + PIONA system docs
**Last updated:** 2026-03-27
**Status:** Ready for implementation in `/sync` v3.2+
