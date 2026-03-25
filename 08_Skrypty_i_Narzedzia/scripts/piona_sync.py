#!/usr/bin/env python3
"""PIONA Studio — Synchronizacja Git v3.1"""

import sys
import subprocess
from pathlib import Path
from datetime import datetime
from typing import Tuple

class C:
    G = "\033[0;32m"; Y = "\033[1;33m"; R = "\033[0;31m"
    B = "\033[0;34m"; BOLD = "\033[1m"; NC = "\033[0m"

PROJECT_DIR = None

def find_root():
    cur = Path(__file__).resolve().parent
    while cur != cur.parent:
        if (cur / ".cursorrules").exists(): return cur
        cur = cur.parent
    raise FileNotFoundError("Nie znalazłem .cursorrules")

def git(args, timeout=120):
    try:
        r = subprocess.run(["git"]+args, cwd=PROJECT_DIR,
            capture_output=True, text=True, timeout=timeout)
        return r.returncode, r.stdout.strip(), r.stderr.strip()
    except subprocess.TimeoutExpired:
        return -1, "", f"Timeout ({timeout}s) — sprawdź internet"
    except Exception as e:
        return -1, "", str(e)

def step(n, title):
    print(f"\n{C.B}[{n}/4] {title}...{C.NC}")

def check_local():
    code, out, err = git(["status", "--porcelain"])
    if code != 0:
        print(f"  {C.R}✗ {err}{C.NC}"); return False, {}
    lines = [l for l in out.split("\n") if l.strip()]
    if not lines:
        print(f"  {C.G}✓ Brak lokalnych zmian{C.NC}"); return False, {}
    added    = sum(1 for l in lines if l.startswith("??"))
    modified = sum(1 for l in lines if l.startswith(" M") or l.startswith("M "))
    deleted  = sum(1 for l in lines if l.startswith(" D") or l.startswith("D "))
    print(f"  {C.G}+ Nowe:          {added}{C.NC}")
    print(f"  {C.Y}~ Zmodyfikowane: {modified}{C.NC}")
    print(f"  {C.R}- Usunięte:      {deleted}{C.NC}\n")
    for l in lines[:15]:
        s,f = l[:2],l[3:]
        if s=="??": print(f"  {C.G}+ {f}{C.NC}")
        elif s in [" M","M ","MM"]: print(f"  {C.Y}~ {f}{C.NC}")
        elif s in [" D","D "]: print(f"  {C.R}- {f}{C.NC}")
        else: print(f"  {s} {f}")
    if len(lines)>15: print(f"  ... i {len(lines)-15} więcej")
    return True, {"lines": lines, "added": added, "modified": modified, "deleted": deleted}

def fetch():
    code, _, err = git(["fetch", "origin", "main"])
    if code != 0:
        if "could not resolve host" in err.lower():
            print(f"  {C.Y}⚠ Brak internetu — tryb offline{C.NC}"); return True, False
        print(f"  {C.R}✗ Fetch error: {err}{C.NC}"); return False, False
    _, local, _  = git(["rev-parse", "main"])
    _, remote, _ = git(["rev-parse", "origin/main"])
    has_new = local != remote
    if has_new:
        print(f"  {C.G}Nowe zmiany od zespołu:{C.NC}")
        _, log, _ = git(["log", "--oneline", "main..origin/main"])
        for l in log.split("\n"):
            if l.strip(): print(f"  {C.G}→ {l}{C.NC}")
    else:
        print(f"  {C.G}✓ Brak nowych zmian od zespołu{C.NC}")
    return True, has_new

def merge(has_local):
    stashed = False
    if has_local:
        code, _, _ = git(["stash", "push", "-m", f"Auto-stash {datetime.now().strftime('%H:%M')}"])
        if code == 0:
            stashed = True
            print(f"  {C.B}📦 Schowałem lokalne zmiany tymczasowo{C.NC}")
    code, _, err = git(["merge", "origin/main", "--no-edit"])
    if code != 0:
        print(f"  {C.R}⚠ KONFLIKT przy łączeniu zmian!{C.NC}")
        _, files, _ = git(["diff", "--name-only", "--diff-filter=U"])
        for f in files.split("\n"):
            if f.strip(): print(f"  {C.R}✗ {f}{C.NC}")
        print(f"\n  {C.Y}Rozwiąż konflikty i uruchom SYNC ponownie.{C.NC}")
        if stashed: git(["stash", "pop"])
        return False
    print(f"  {C.G}✓ Zmiany zespołu połączone{C.NC}")
    if stashed:
        code, _, _ = git(["stash", "pop"])
        if code == 0: print(f"  {C.G}✓ Lokalne zmiany przywrócone{C.NC}")
    return True

def auto_commit_msg(status_out):
    lines = [l for l in status_out.split("\n") if l.strip()]
    added    = [l[3:] for l in lines if l.startswith("??")]
    modified = [l[3:] for l in lines if l.startswith(" M") or l.startswith("M ")]
    deleted  = [l[3:] for l in lines if l.startswith(" D") or l.startswith("D ")]
    all_files = added + modified + deleted
    folders = list(dict.fromkeys(
        Path(f).parts[0] if len(Path(f).parts) > 1 else f
        for f in all_files
    ))[:3]
    parts = []
    if added:    parts.append(f"{len(added)} nowych")
    if modified: parts.append(f"{len(modified)} zmienionych")
    if deleted:  parts.append(f"{len(deleted)} usuniętych")
    ts = datetime.now().strftime("%d.%m %H:%M")
    areas = " · ".join(folders)
    return f"Aktualizacja {ts} — {', '.join(parts)} [{areas}]"

def commit():
    code, out, _ = git(["status", "--porcelain"])
    if code != 0 or not out.strip():
        print(f"  {C.G}✓ Brak zmian do zapisania{C.NC}"); return True, False
    _, author, _ = git(["config", "user.name"])
    if not author: author = "PIONA"
    msg = f"[{author}] {auto_commit_msg(out)}"
    git(["add", "-A"])
    code, _, err = git(["commit", "-m", msg])
    if code != 0:
        print(f"  {C.R}✗ Commit error: {err}{C.NC}"); return False, False
    print(f"  {C.G}✓ Zapisano: {msg}{C.NC}"); return True, True

def push():
    code, _, err = git(["push", "origin", "main"], timeout=120)
    if code != 0:
        if "could not resolve host" in err.lower() or "Timeout" in err:
            print(f"  {C.Y}⚠ {err} — zmiany zapisane lokalnie{C.NC}")
        else:
            print(f"  {C.R}✗ Push error: {err}{C.NC}")
        return False
    print(f"  {C.G}✓ Wysłano na GitHub{C.NC}"); return True

def main():
    global PROJECT_DIR
    print(f"\n{C.BOLD}╔══════════════════════════════════════╗{C.NC}")
    print(f"{C.BOLD}║      PIONA Studio — SYNC (v3.1)      ║{C.NC}")
    print(f"{C.BOLD}╚══════════════════════════════════════╝{C.NC}\n")
    try:
        PROJECT_DIR = find_root()
    except FileNotFoundError as e:
        print(f"{C.R}BŁĄD: {e}{C.NC}"); return 1

    step(1, "Sprawdzam lokalne zmiany")
    has_local, details = check_local()

    step(2, "Pobieram zmiany zespołu")
    ok, has_new = fetch()
    if not ok: return 1

    if has_new:
        step(3, "Łączę zmiany zespołu")
        if not merge(has_local): return 1

    step(3, "Zapisuję twoje zmiany")
    ok, committed = commit()
    if not ok: return 1

    step(4, "Wysyłam na GitHub")
    if committed or has_new:
        push()
    else:
        print(f"  {C.G}✓ Nic do wysłania — wszystko zsynchronizowane{C.NC}")

    print(f"\n{C.BOLD}══════════════════════════════════════{C.NC}")
    print(f"{C.G}✓ SYNC ZAKOŃCZONY{C.NC}")
    print(f"  Czas:    {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"  Pobrano: {'zmiany zespołu' if has_new else 'brak nowych'}")
    print(f"  Wysłano: {'twoje zmiany' if committed else 'brak zmian'}")
    print(f"{C.BOLD}══════════════════════════════════════{C.NC}\n")
    return 0

if __name__ == "__main__":
    try: sys.exit(main())
    except KeyboardInterrupt: print(f"\n{C.Y}Przerwano.{C.NC}"); sys.exit(130)
    except Exception as e: print(f"\n{C.R}Błąd: {e}{C.NC}"); sys.exit(1)

