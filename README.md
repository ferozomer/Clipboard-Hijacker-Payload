# Clipboard Hijacker Payload

A PowerShell-based clipboard monitoring script that logs clipboard changes locally and sends the clipboard data to a specified server endpoint for further processing.

## Features

- Monitors the clipboard for changes.
- Logs clipboard content locally with timestamps.
- Sends clipboard data to a server endpoint using HTTP POST requests.
- Tracks and prevents duplicate logs for unchanged clipboard content.
- Provides robust error handling and logging.

## Requirements

- Windows operating system.
- PowerShell (version 5.0 or higher).
- Server endpoint capable of receiving HTTP POST requests.

## Installation

1. Clone the repository or download the script file `ClipboardMonitor.ps1`.
2. Ensure PowerShell is installed on your system.
3. Modify the configuration variables in the script:
   - Replace `<YourServerIP>` in `$webhook_url` with the IP or domain of your server.
   - Set a valid file path for the `$log_file` variable to store clipboard logs.

## Usage

1. Open PowerShell as an administrator.
2. Run the script:
   ```powershell
   PowerShell -ExecutionPolicy Bypass -File .\ClipboardMonitor.ps1

## NOTE: This software is intended solely for educational purposes only
