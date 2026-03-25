#!/usr/bin/env python3
"""
PIONA Studio — Backup System v2.0
Git versioning + Selective ZIP archive + Google Drive sync + rotation + integrity checks
"""

import os
import sys
from typing import Optional
import shutil
import zipfile
import hashlib
import subprocess
import logging
from datetime import datetime
from pathlib import Path

# --- CONFIGURATION ---
# Auto-detect project root by finding .cursorrules
def find_project_root():
    """Find PIONA Studio root by locating .cursorrules marker file."""
    current = Path(__file__).resolve().parent
    while current != current.parent:  # Stop at filesystem root
        if (current / ".cursorrules").exists():
            return current
        current = current.parent
    raise FileNotFoundError("Could not find .cursorrules — not in PIONA Studio folder!")

PROJECT_DIR = find_project_root()
LOCAL_BACKUP_DIR = PROJECT_DIR / "Backup" / "Archives"
LOG_FILE = PROJECT_DIR / "Backup" / "backup.log"

# Google Drive
DRIVE_BASE_PATH = Path.home() / "Library" / "CloudStorage" / "GoogleDrive-kontakt.piona@gmail.com"
DRIVE_BACKUP_SUBDIR = "Mój dysk/PIONA_System_Backups"
DRIVE_FULL_PATH = DRIVE_BASE_PATH / DRIVE_BACKUP_SUBDIR

# Retention
MAX_LOCAL_BACKUPS = 7
MAX_DRIVE_BACKUPS = 5

# Directories to include in the backup (relative to PROJECT_DIR)
DIRS_TO_ARCHIVE = [
    "07_Projekty_Aktywne",  # www-v9 i inne aktywne projekty
    "00_Strategia_2026",
    "01_Procesy_Wewnetrzne",
    "02_Ofertowanie",
    "03_Rozwoj_i_Trendy",
    "04_SEO_i_WWW",
    "05_Baza_Wiedzy",
    "06_Dane_i_Assety",  # Brand Assets znajduje się tutaj
    "08_Skrypty_i_Narzedzia",  # scripts znajduje się tutaj
]

# Individual files from root to include
FILES_TO_ARCHIVE = [
    ".cursorrules",
    "SESSION.md",
    "CLAUDE.md",
    "MASTERPLAN.md",
    "STATUS_UPDATES.md",
    ".gitignore",
]

# Patterns to always exclude (even within included dirs)
EXCLUDE_PATTERNS = [
    ".git",
    ".DS_Store",
    "node_modules",
    "__pycache__",
    "*.pyc",
    "pdf_venv",
    "Backup/Archives",
]

# --- LOGGING SETUP ---
def setup_logging():
    """Configure dual logging: file + console."""
    LOG_FILE.parent.mkdir(parents=True, exist_ok=True)
    
    logger = logging.getLogger("piona_backup")
    logger.setLevel(logging.INFO)
    
    # File handler (append, with timestamps)
    fh = logging.FileHandler(LOG_FILE, encoding="utf-8")
    fh.setFormatter(logging.Formatter("%(asctime)s [%(levelname)s] %(message)s", datefmt="%Y-%m-%d %H:%M:%S"))
    logger.addHandler(fh)
    
    # Console handler
    ch = logging.StreamHandler(sys.stdout)
    ch.setFormatter(logging.Formatter("%(message)s"))
    logger.addHandler(ch)
    
    return logger

log = setup_logging()

# --- SHARED TIMESTAMP ---
BACKUP_TIMESTAMP = datetime.now()
TIMESTAMP_STR = BACKUP_TIMESTAMP.strftime("%Y%m%d_%H%M%S")
TIMESTAMP_HUMAN = BACKUP_TIMESTAMP.strftime("%Y-%m-%d %H:%M:%S")


def should_exclude(rel_path: str) -> bool:
    """Check if a relative path matches any exclude pattern."""
    parts = Path(rel_path).parts
    for pattern in EXCLUDE_PATTERNS:
        if pattern.startswith("*"):
            # Wildcard extension match
            ext = pattern[1:]
            if rel_path.endswith(ext):
                return True
        elif pattern in parts or rel_path == pattern or rel_path.startswith(pattern + os.sep):
            return True
    return False


def run_git_backup():
    """Stage and commit all tracked changes to Git."""
    log.info("--- Git Versioning ---")
    try:
        subprocess.run(["git", "add", "."], cwd=PROJECT_DIR, check=True, capture_output=True)
        
        status = subprocess.run(
            ["git", "status", "--porcelain"],
            cwd=PROJECT_DIR, capture_output=True, text=True
        ).stdout.strip()
        
        if not status:
            log.info("No changes to commit in Git.")
            return
        
        changed_count = len(status.splitlines())
        commit_msg = f"Session Backup [{TIMESTAMP_HUMAN}]"
        subprocess.run(["git", "commit", "-m", commit_msg], cwd=PROJECT_DIR, check=True, capture_output=True)
        log.info(f"Git commit successful: {commit_msg} ({changed_count} files)")
        
    except subprocess.CalledProcessError as e:
        log.error(f"Git backup failed: {e}")
        if e.stderr:
            log.error(f"  stderr: {e.stderr.decode() if isinstance(e.stderr, bytes) else e.stderr}")


def create_zip_archive() -> Optional[Path]:
    """Create a selective ZIP archive of key project directories."""
    log.info("--- Creating Selective ZIP Archive ---")
    zip_name = f"piona_backup_{TIMESTAMP_STR}.zip"
    zip_path = LOCAL_BACKUP_DIR / zip_name
    LOCAL_BACKUP_DIR.mkdir(parents=True, exist_ok=True)

    file_count = 0
    total_size = 0

    with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED, compresslevel=6) as zipf:
        # Archive selected directories
        for dir_name in DIRS_TO_ARCHIVE:
            dir_path = PROJECT_DIR / dir_name
            if not dir_path.exists():
                log.warning(f"  Directory not found, skipping: {dir_name}")
                continue
            
            for root, dirs, files in os.walk(dir_path):
                rel_root = os.path.relpath(root, PROJECT_DIR)
                
                if should_exclude(rel_root):
                    dirs.clear()  # Don't descend
                    continue
                
                # Filter subdirectories in-place
                dirs[:] = [d for d in dirs if not should_exclude(os.path.join(rel_root, d))]
                
                for file in files:
                    file_path = Path(root) / file
                    rel_path = os.path.relpath(file_path, PROJECT_DIR)
                    
                    if should_exclude(rel_path) or file == ".DS_Store":
                        continue
                    
                    zipf.write(file_path, rel_path)
                    file_count += 1
                    total_size += file_path.stat().st_size

        # Archive individual root files
        for file_name in FILES_TO_ARCHIVE:
            file_path = PROJECT_DIR / file_name
            if file_path.exists():
                zipf.write(file_path, file_name)
                file_count += 1
                total_size += file_path.stat().st_size

    # Verify ZIP integrity
    log.info("  Verifying archive integrity...")
    try:
        with zipfile.ZipFile(zip_path, 'r') as zipf:
            bad_file = zipf.testzip()
            if bad_file:
                log.error(f"  ❌ ZIP CORRUPTION detected in: {bad_file}")
                zip_path.unlink()
                return None
    except zipfile.BadZipFile:
        log.error("  ❌ Created ZIP is invalid/corrupt!")
        zip_path.unlink()
        return None

    zip_size_mb = zip_path.stat().st_size / (1024 * 1024)
    source_size_mb = total_size / (1024 * 1024)
    log.info(f"  ✅ Archive OK: {zip_name}")
    log.info(f"     {file_count} files | {source_size_mb:.1f} MB source → {zip_size_mb:.1f} MB compressed")
    return zip_path


def sync_to_google_drive(zip_path: Path) -> bool:
    """Copy the archive to Google Drive with size verification."""
    log.info("--- Syncing to Google Drive ---")
    
    if not DRIVE_BASE_PATH.exists():
        log.warning(f"Google Drive not found at: {DRIVE_BASE_PATH}")
        log.warning("Skipping cloud sync. Please ensure Google Drive app is running.")
        return False

    try:
        DRIVE_FULL_PATH.mkdir(parents=True, exist_ok=True)
        dest_path = DRIVE_FULL_PATH / zip_path.name
        
        shutil.copy2(zip_path, dest_path)
        
        # Verify: compare file sizes
        source_size = zip_path.stat().st_size
        dest_size = dest_path.stat().st_size
        
        if source_size != dest_size:
            log.error(f"  ❌ Size mismatch! Source: {source_size} bytes, Drive: {dest_size} bytes")
            return False
        
        size_mb = source_size / (1024 * 1024)
        log.info(f"  ✅ Copied to Google Drive ({size_mb:.1f} MB): {dest_path.name}")
        return True
        
    except PermissionError:
        log.error("  ❌ Permission denied writing to Google Drive.")
        return False
    except OSError as e:
        log.error(f"  ❌ Error syncing to Google Drive: {e}")
        return False


def rotate_backups():
    """Clean up old backups both locally and on Google Drive."""
    log.info("--- Rotating old backups ---")
    
    # Local rotation
    _rotate_dir(LOCAL_BACKUP_DIR, MAX_LOCAL_BACKUPS, "local")
    
    # Google Drive rotation
    if DRIVE_FULL_PATH.exists():
        _rotate_dir(DRIVE_FULL_PATH, MAX_DRIVE_BACKUPS, "Google Drive")


def _rotate_dir(directory: Path, keep: int, label: str):
    """Remove oldest ZIP backups from a directory, keeping the N most recent."""
    if not directory.exists():
        return
    
    backups = sorted(
        [f for f in directory.iterdir() if f.suffix == ".zip" and f.name.startswith("piona_backup")],
        key=lambda f: f.stat().st_mtime
    )
    
    if len(backups) > keep:
        to_delete = backups[:-keep]
        for b in to_delete:
            size_mb = b.stat().st_size / (1024 * 1024)
            b.unlink()
            log.info(f"  Deleted {label}: {b.name} ({size_mb:.1f} MB)")
    else:
        log.info(f"  {label}: {len(backups)}/{keep} slots used, no cleanup needed.")


def print_summary(zip_path: Optional[Path], drive_ok: bool):
    """Print final backup summary."""
    log.info("=" * 50)
    log.info("  BACKUP SUMMARY")
    log.info("=" * 50)
    log.info(f"  Timestamp:    {TIMESTAMP_HUMAN}")
    log.info(f"  Git:          ✅ committed")
    
    if zip_path:
        size_mb = zip_path.stat().st_size / (1024 * 1024)
        log.info(f"  ZIP Archive:  ✅ {zip_path.name} ({size_mb:.1f} MB)")
    else:
        log.info(f"  ZIP Archive:  ❌ failed")
    
    log.info(f"  Google Drive: {'✅ synced' if drive_ok else '⚠️  not synced'}")
    log.info("=" * 50)


# --- MAIN ---
if __name__ == "__main__":
    log.info("\n" + "=" * 50)
    log.info("  PIONA BACKUP v2.0")
    log.info("=" * 50)
    log.info(f"  Project: {PROJECT_DIR}")
    log.info(f"  Started: {TIMESTAMP_HUMAN}")
    log.info("")
    
    run_git_backup()
    zip_path = create_zip_archive()
    
    drive_ok = False
    if zip_path:
        drive_ok = sync_to_google_drive(zip_path)
    
    rotate_backups()
    print_summary(zip_path, drive_ok)
