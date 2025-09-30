param(
    [string]$token,
    [string]$chat_id,
    [string]$message
)

$uri = "https://api.telegram.org/bot$token/sendMessage"
$body = @{
    chat_id = $chat_id
    text = $message
}

Invoke-RestMethod -Uri $uri -Method Post -Body $body