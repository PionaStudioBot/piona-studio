---
name: Conflict Resolution Policy for PIONA Studio
description: Defines which merge conflicts auto-resolve, which require manual intervention, and decision criteria.
date: 2026-03-27
status: active
---

# Merge Conflict Resolution Policy

## Overview

When `/sync` merges branches (oskar → main, wika → main), git merge may detect conflicts when both branches edited the same file. This policy defines:

1. Which conflicts **auto-resolve** (Markdown, config files)
2. Which conflicts **abort & notify** (Code, binaries)
3. How to handle edge cases

**Principle:** Preserve data integrity. Never silently discard code changes. Markdown sections can be combined.

---

## Conflict Categories & Decisions

### Category 1: Markdown Files (Auto-Resolve)

**Files:** `*.md` in `context/`, `planning/`, `wiedza/`, `procesy/`, `klienci/`

**Examples:**
- `planning/strategia_2026.md`
- `context/o_nas.md`
- `planning/plan_bloga.md`
- `procesy/system_pozyskiwania_klienta.md`

**Strategy:** `-Xunion` — keep both sides' content when they don't overlap completely

```bash
git merge origin/branch -Xunion --no-ff \
  -m "Merge branch (union strategy on markdown)"
```

**Why:** Markdown files often have natural sections. If Oskar adds "Q2 Goals" section and Wiktoria adds "Positioning Strategy" section to same file, both should be preserved.

**Risk:** Low. Markdown is structured. Worst case: two sections are in order, which is mostly fine.

**Example:**
```markdown
# Original file
## Section by Oskar
[Content A]

## Section by Wiktoria
[Content B]
```

Result after `-Xunion` merge: Both sections preserved. ✅

---

### Category 2: Code Files (Abort & Notify)

**Files:** `*.js`, `*.html`, `*.css`, `*.py` in `projekty/` and `klienci/*/projekty/`

**Examples:**
- `projekty/www-v9/index.html`
- `projekty/www-v9/styles.css`
- `narzedzia/scripts/sync.sh`

**Strategy:** **ABORT merge. Notify Oskar.**

```bash
if git diff --name-only --diff-filter=U | grep -E '\.(js|html|css|py|sh)$'; then
    git merge --abort
    notify "⚠️  Code conflict in: $(git diff --name-only --diff-filter=U)"
    exit 1
fi
```

**Why:**
- Code requires semantic understanding (what does this function do?)
- Auto-resolving could break functionality
- Two developers both editing same function = high risk

**Example (BAD):**
```html
<!-- Both tried to edit the same component -->
<<<<<<< HEAD (main)
<button onclick="submitForm()">Submit</button>
=======
<button onclick="validateFirst()">Submit</button>
>>>>>>> oskar

<!-- Auto-merge could pick wrong one, breaking UX -->
```

---

### Category 3: Config Files (Case-by-Case)

**Files:** `.yaml`, `.json`, `.toml`, `.env` (if tracked)

**Examples:**
- `.cursorrules` (JSON/YAML)
- `PROJECT.json` (if exists)
- `.gitignore` (if modified)

**Strategy:**
1. Try `-Xunion` first (often safe for configs)
2. If both branches added different settings to same section → manually review
3. If one branch added, other deleted → abort (conflict of intent)

```bash
# Attempt union merge
if git merge origin/branch -Xunion --no-ff 2>/dev/null; then
    # Success — validate config syntax
    if ! validate_yaml .cursorrules; then
        git merge --abort
        notify "⚠️  Config syntax error after merge"
        exit 1
    fi
else
    # Union failed — requires manual review
    git merge --abort
    notify "⚠️  Config conflict in: $(git diff --name-only --diff-filter=U)"
    exit 1
fi
```

**Example (OK):**
```yaml
# main added
brand_colors:
  primary: blue

# oskar added (different section)
brand_colors:
  secondary: green

# After -Xunion merge: both present ✅
brand_colors:
  primary: blue
  secondary: green
```

**Example (NOT OK):**
```yaml
# main has
retry_policy: exponential

# oskar has
retry_policy: linear

# -Xunion fails — conflicting values for same key ❌
```

---

### Category 4: Binary Files & Large Assets

**Files:** `.png`, `.jpg`, `.gif`, `.pdf`, `.woff2`, `.mp4` (in Git — should NOT be)

**Strategy:** **Never commit binaries to git.**

**If encountered:** Abort merge and notify Oskar to migrate to Google Drive.

```bash
if git diff --name-only --diff-filter=U | grep -E '\.(png|jpg|pdf|woff2|mp4)$'; then
    git merge --abort
    notify "⚠️  Binary file conflict detected. These should be in Google Drive, not Git."
    notify "   See: .claude/rules/file-routing.md"
    exit 1
fi
```

---

## Decision Tree

```
Merge detected conflict in FILE
  │
  ├─ FILE matches *.md?
  │   └─ YES → Use -Xunion strategy → CONTINUE
  │
  ├─ FILE matches *.js/*.html/*.css/*.py/.sh?
  │   └─ YES → ABORT + NOTIFY (code conflict)
  │
  ├─ FILE matches *.yaml/*.json/*.toml?
  │   └─ YES → Try -Xunion, validate syntax, NOTIFY if fails
  │
  ├─ FILE matches binary (*.png/*.pdf)?
  │   └─ YES → ABORT + NOTIFY (should be in Google Drive)
  │
  └─ Unknown file type?
      └─ YES → ABORT + NOTIFY (manual review needed)
```

---

## Implementation in `/sync` Skill

### Pseudo-code

```bash
#!/bin/bash

# Step 1: Create shadow clone, perform merge
cd "$SHADOW"
if ! git merge origin/$SOURCE_BRANCH --no-ff 2>&1 | grep -q "CONFLICT"; then
    # No conflicts — proceed
    exit 0
fi

# Step 2: Detect conflict files
CONFLICT_FILES=$(git diff --name-only --diff-filter=U)

# Step 3: Categorize and resolve
AUTO_RESOLVE_FILES=""
CODE_CONFLICT_FILES=""
CONFIG_CONFLICT_FILES=""

for FILE in $CONFLICT_FILES; do
    case "$FILE" in
        *.md)
            AUTO_RESOLVE_FILES="$AUTO_RESOLVE_FILES $FILE"
            ;;
        *.js|*.html|*.css|*.py|*.sh)
            CODE_CONFLICT_FILES="$CODE_CONFLICT_FILES $FILE"
            ;;
        *.yaml|*.json|*.toml|.cursorrules)
            CONFIG_CONFLICT_FILES="$CONFIG_CONFLICT_FILES $FILE"
            ;;
        *.png|*.jpg|*.pdf|*.woff2|*.mp4)
            notify "❌ Binary files must be in Google Drive, not Git"
            git merge --abort
            exit 1
            ;;
        *)
            notify "⚠️  Unknown conflict type: $FILE"
            git merge --abort
            exit 1
            ;;
    esac
done

# Step 4: Auto-resolve markdown with -Xunion
if [ -n "$AUTO_RESOLVE_FILES" ]; then
    git merge --abort
    # Re-do merge with -Xunion strategy
    if ! git merge origin/$SOURCE_BRANCH -Xunion --no-ff; then
        notify "⚠️  Even union merge failed. Manual review needed."
        exit 1
    fi
fi

# Step 5: Report code/config conflicts
if [ -n "$CODE_CONFLICT_FILES" ]; then
    notify "❌ MERGE BLOCKED: Code conflict in:"
    for F in $CODE_CONFLICT_FILES; do echo "   - $F"; done
    git merge --abort
    exit 1
fi

if [ -n "$CONFIG_CONFLICT_FILES" ]; then
    notify "⚠️  Config conflicts (manual review):"
    for F in $CONFIG_CONFLICT_FILES; do echo "   - $F"; done
    git merge --abort
    exit 1
fi

# Step 6: If we got here, merge succeeded
exit 0
```

---

## User Experience (Oskar i Wiktoria)

### Success Case (brak konfliktów)

```
You: /sync
↓
✅ SYNC ZAKOŃCZONY — 27.03.2026 14:30
   Branch:          oskar
   Lokalne zmiany:  3 pliki
   Push branch:     ✓
   Merge do main:   ✓ bez konfliktów
   Push main:       ✓ GitHub
   Sync lokalny:    2 pliki zaktualizowane
```

### Konflikt Markdown — AI Synthesis

```
You: /sync
↓
Sync runs...
⚠ Plik planning/strategia_2026.md ma konflikt.

Oskar zmienił: dodał sekcję "Cele Q2 — lead generation"
Wiktoria zmieniła: zaktualizowała sekcję "Budżet marketingowy"

Proponuję zsyntezowaną wersję:
[pokazuje połączoną treść z obu zmian]

Zatwierdzasz? (tak/nie/edytuj)
↓
You: tak
↓
✅ SYNC ZAKOŃCZONY
   Konflikty: 1 plik rozwiązany przez AI (strategia_2026.md)
```

### Konflikt Kodu — Wymaga decyzji użytkownika

```
You: /sync
↓
❌ Konflikt w kodzie: projekty/www-v9/index.html

Wersja A (oskar): <button onclick="submitForm()">Submit</button>
Wersja B (main):  <button onclick="validateFirst()">Submit</button>

Którą wersję wybrać? (A / B / AI zaproponuje merge)
↓
You: B
↓
✅ Rozwiązano, kontynuuję sync...
```

---

## Special Cases & Edge Cases

### Edge Case 1: Both Branches Deleted Same File

**Git status:** File marked as "deleted by both"

**Decision:** This is NOT a conflict in git's sense — both sides agree. Continue merge.

```bash
# Git automatically resolves this
git add .  # Accept both deletions
git commit -m "Both branches deleted file"
```

---

### Edge Case 2: One Branch Deleted, Other Modified File

**Conflict:** "deleted by us" vs "modified by them"

**Decision:**
- If Wiktoria (main) deleted and Oskar modified → **Keep Wiktoria's intent** (deleted)
- Use `git rm` to confirm deletion

```bash
git rm $FILE  # Remove it completely
git add $FILE
git commit -m "Deleted $FILE per main branch"
```

---

### Edge Case 3: Same .md File, Both Added Identical Section

**Conflict:** Lines are identical but diff shows conflict due to context

**Decision:** Use `-Xunion` or manually accept (both sides are the same anyway)

```bash
git checkout --ours $FILE  # Or --theirs (same content)
git add $FILE
git commit -m "Resolved identical changes"
```

---

### Edge Case 4: Very Long .md File with Many Edits

**Risk:** `-Xunion` might not work if both branches edited overlapping regions

**Decision:**
- If `-Xunion` fails → abort and notify
- Oskar manually reviews and re-commits

```bash
if ! git merge origin/oskar -Xunion --no-ff; then
    notify "⚠️  Union merge failed on $FILE (too many overlapping changes)"
    notify "   Oskar: please manually review and push"
    git merge --abort
    exit 1
fi
```

---

## Testing Conflict Scenarios

### Test 1: Markdown Conflict (Should Auto-Resolve)

```bash
# Setup
git checkout -b test-md
echo "## Section A" >> planning/strategia_2026.md
git commit -am "Add Section A"
git checkout main
echo "## Section B" >> planning/strategia_2026.md
git commit -am "Add Section B"

# Test
git merge test-md -Xunion --no-ff

# Expected: ✅ Merge succeeds, both sections present
git log --oneline  # Shows merge commit
cat planning/strategia_2026.md  # Shows both sections
```

### Test 2: Code Conflict (Should Abort)

```bash
# Setup
git checkout -b test-code
echo "console.log('version A');" > projekty/www-v9/app.js
git commit -am "Version A"
git checkout main
echo "console.log('version B');" > projekty/www-v9/app.js
git commit -am "Version B"

# Test (in shadow clone)
git merge test-code --no-ff

# Expected: ❌ Conflict detected
git diff --name-only --diff-filter=U  # Shows *.js file
# Script should abort and notify
```

---

## Escalation & Override

### When Oskar Wants to Force a Merge

```bash
# If `/sync` aborts due to code conflict, but Oskar decides to force:
git merge origin/oskar -Xtheirs --no-ff -m "Force merge (Oskar approved)"
# Oskar manually reviews and pushes

# This is intentional override, not automatic
```

### When Policy Needs Updating

Use `/feedback` skill to record new conflict scenarios:

```
/feedback
→ New scenario: What if both branches edited .cursorrules?
→ Decision: Abort and notify (config integrity)
→ Update conflict-policy.md
```

---

## FAQ

**Q: Why not always use `-Xours` or `-Xtheirs`?**
A: That silently discards one side's changes. We prefer explicit. Markdown can combine; code cannot.

**Q: What if a .md file has truly conflicting edits?**
A: `-Xunion` keeps both sections. Might result in redundancy, but no data loss. Better than silent loss.

**Q: Can we auto-resolve .json files?**
A: Risky (breaking syntax). Only if we add JSON-aware merge driver (Mergiraf). For now: abort.

**Q: What about .gitignore conflicts?**
A: Rare, but if it happens: use `-Xunion`. Ignore rules should combine, not override.

---

## Policy Version History

| Version | Date | Change |
|---------|------|--------|
| 2.0 | 2026-03-27 | AI-Assisted Conflict Resolution + UX update |
| 1.0 | 2026-03-27 | Initial policy based on research |

---

**Status:** Zaimplementowane w `/sync` v4
**Owner:** Oskar (policy), Claude Cowork (implementation)
