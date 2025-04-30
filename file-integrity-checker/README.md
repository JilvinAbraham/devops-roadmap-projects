# File Integrity Checker

A tool to verify the integrity of log files and detect tampering using SHA-256 hashing.

## Features

- Monitor single log files or entire directories of log files
- Uses SHA-256 cryptographic hashing for integrity verification
- Stores file hashes securely in a JSON file
- Provides clear visual feedback about file changes
- Supports re-initialization of file integrity monitoring

## Installation

1. Clone this repository
2. Install the required dependencies:
   ```bash
   pip install -r requirements.txt
   ```

## Usage

### Initializing File Integrity Monitoring

To initialize or re-initialize the integrity monitoring for log files:

```bash
python file_integrity_checker.py /path/to/logs --init
```

### Verifying File Integrity

To verify the integrity of log files:

```bash
python file_integrity_checker.py /path/to/logs
```

### Examples

1. Initialize monitoring for a single log file:
   ```bash
   python file_integrity_checker.py /var/log/app.log --init
   ```

2. Initialize monitoring for a directory of log files:
   ```bash
   python file_integrity_checker.py /var/log/ --init
   ```

3. Verify integrity of all log files in a directory:
   ```bash
   python file_integrity_checker.py /var/log/
   ```

## Output

- Green text indicates successful verification or initialization
- Yellow text indicates warnings (e.g., files not found in hash database)
- Red text indicates detected changes or tampering

## Security Notes

- The hash file (`.file_hashes.json`) should be stored in a secure location
- Consider implementing additional security measures for the hash file
- Regular verification is recommended to detect unauthorized changes

## License

MIT License 