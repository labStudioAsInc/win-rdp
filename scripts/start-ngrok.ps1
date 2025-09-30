param(
    [string]$NgrokAuthToken,
    [string]$NgrokRegion,
    [string]$TgToken,
    [string]$TgChatId
)

& ngrok authtoken $NgrokAuthToken
Start-Process -FilePath "ngrok" -ArgumentList "tcp 3389 --region $NgrokRegion"
Start-Sleep -s 30
$Response = ConvertFrom-Json(Invoke-WebRequest -Uri "http://127.0.0.1:4040/api/tunnels")
Start-Sleep -s 1
$URLString = $Response.tunnels.public_url
if($URLString) {
    & "$PSScriptRoot/../send_telegram.ps1" $TgToken $TgChatId ($URLString -split "tcp://")[1]
}
Start-Sleep -s 21600