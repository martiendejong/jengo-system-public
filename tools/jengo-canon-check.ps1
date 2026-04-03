$json  = Get-Content 'C:\scripts\tools\jengo-scientific-canon.json' -Raw | ConvertFrom-Json
$entry = $json.canon[0]
Write-Host "ID: $($entry.id)"
Write-Host "Blacklist triggers:"
$entry.blacklist_triggers | ForEach-Object { Write-Host "  - $_" }
Write-Host "Contradiction keywords:"
$entry.contradiction_keywords | ForEach-Object { Write-Host "  - $_" }
