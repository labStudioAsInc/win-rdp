param(
    [string]$TgToken,
    [string]$TgChatId,
    [string]$CfDomain
)

Start-Process -FilePath "cloudflared" -ArgumentList "login" -RedirectStandardError "C:\cloudflared.txt"
Start-Sleep -s 10
Get-Content C:\cloudflared.txt | foreach {
    $URLString = ((Select-String '(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})' -Input $_).Matches.Value)
    if($URLString) {
        & "$PSScriptRoot/../send_telegram.ps1" $TgToken $TgChatId ($URLString -split "https://")[1]
        break
    }
}
& cloudflared --hostname $CfDomain --url rdp://localhost:3389