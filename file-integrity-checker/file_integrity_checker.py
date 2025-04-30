#!/usr/bin/env python3

import os
import json
import hashlib
import argparse
from pathlib import Path
from datetime import datetime
from colorama import init, Fore, Style

# Initialize colorama
init()

class FileIntegrityChecker:
    def __init__(self, hash_file=".file_hashes.json"):
        self.hash_file = hash_file
        self.hashes = self._load_hashes()

    def _load_hashes(self):
        """Load existing hashes from the hash file."""
        if os.path.exists(self.hash_file):
            with open(self.hash_file, 'r') as f:
                return json.load(f)
        return {}

    def _save_hashes(self):
        """Save current hashes to the hash file."""
        with open(self.hash_file, 'w') as f:
            json.dump(self.hashes, f, indent=4)

    def _compute_hash(self, file_path):
        """Compute SHA-256 hash of a file."""
        sha256_hash = hashlib.sha256()
        with open(file_path, "rb") as f:
            for byte_block in iter(lambda: f.read(4096), b""):
                sha256_hash.update(byte_block)
        return sha256_hash.hexdigest()

    def initialize(self, path, pattern="*"):
        """Initialize or re-initialize file hashes."""
        path = Path(path)
        if path.is_file():
            files = [path]
        else:
            files = list(path.rglob(pattern))  # Process all files by default

        for file in files:
            if file.is_file():  # Only process files, not directories
                file_path = str(file)
                self.hashes[file_path] = {
                    'hash': self._compute_hash(file_path),
                    'timestamp': datetime.now().isoformat()
                }
                print(f"{Fore.GREEN}Initialized hash for: {file_path}{Style.RESET_ALL}")

        self._save_hashes()
        print(f"\n{Fore.GREEN}Successfully initialized {len(files)} files.{Style.RESET_ALL}")

    def verify(self, path, pattern="*"):
        """Verify file integrity against stored hashes."""
        path = Path(path)
        if path.is_file():
            files = [path]
        else:
            files = list(path.rglob(pattern))

        changes_found = False
        for file in files:
            if not file.is_file():  # Skip directories
                continue
                
            file_path = str(file)
            if file_path not in self.hashes:
                print(f"{Fore.YELLOW}Warning: {file_path} not found in hash database.{Style.RESET_ALL}")
                continue

            current_hash = self._compute_hash(file_path)
            if current_hash != self.hashes[file_path]['hash']:
                print(f"{Fore.RED}ALERT: File {file_path} has been modified!{Style.RESET_ALL}")
                print(f"  Original hash: {self.hashes[file_path]['hash']}")
                print(f"  Current hash:  {current_hash}")
                changes_found = True
            else:
                print(f"{Fore.GREEN}Verified: {file_path} is unchanged.{Style.RESET_ALL}")

        if not changes_found:
            print(f"\n{Fore.GREEN}All files verified successfully. No changes detected.{Style.RESET_ALL}")

def main():
    parser = argparse.ArgumentParser(description='File Integrity Checker')
    parser.add_argument('path', help='Path to file or directory to monitor')
    parser.add_argument('--init', action='store_true', help='Initialize or re-initialize file hashes')
    parser.add_argument('--pattern', default='*', help='File pattern to match (e.g., *.log, *.txt). Default is all files (*)')
    
    args = parser.parse_args()
    
    checker = FileIntegrityChecker()
    
    if args.init:
        checker.initialize(args.path, args.pattern)
    else:
        checker.verify(args.path, args.pattern)

if __name__ == '__main__':
    main() 