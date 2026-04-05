# jengo-ouroboros-update.ps1
# Ouroboros niveau 3 - Canon confidence updater
#
# Gebruik:
#   .\jengo-ouroboros-update.ps1 -Claim "meer parameters leidt tot betere AI" -Verdict CONTRADICTED
#   .\jengo-ouroboros-update.ps1 -Claim "architectuur bepaalt efficientie" -Verdict CONFIRMED -Bron "Raichle 2001"
#   .\jengo-ouroboros-update.ps1 -ListCanon

param(
    [string]$Claim   = "",
    [ValidateSet("CONFIRMED","CONTRADICTED")]
    [string]$Verdict = "",
    [string]$Bron    = "handmatig",
    [switch]$ListCanon
)

$canonPath = "$PSScriptRoot\jengo-scientific-canon.json"
$logPath   = "$PSScriptRoot\jengo-ouroboros-log.jsonl"

if (-not (Test-Path $canonPath)) {
    Write-Host "FOUT: Canon niet gevonden op $canonPath" -ForegroundColor Red
    exit 1
}

$canon = Get-Content $canonPath -Raw -Encoding UTF8 | ConvertFrom-Json

# LIST MODE
if ($ListCanon) {
    Write-Host ""
    Write-Host "  JENGO SCIENTIFIC CANON - confidence overzicht" -ForegroundColor Cyan
    Write-Host "  -----------------------------------------------" -ForegroundColor DarkGray
    foreach ($entry in $canon.canon) {
        $conf = [math]::Round($entry.confidence * 100, 0)
        $bar  = ""
        $blocks = [math]::Floor($conf / 5)
        for ($i = 0; $i -lt $blocks; $i++) { $bar += "#" }
        if ($conf -ge 90) { $color = "Green" } elseif ($conf -ge 75) { $color = "Yellow" } else { $color = "Red" }
        Write-Host ("  {0,-18} {1,-3}% {2}" -f $entry.id, $conf, $bar) -ForegroundColor $color
        Write-Host ("    {0}" -f $entry.naam) -ForegroundColor DarkGray
    }
    Write-Host ""
    exit 0
}

if (-not $Claim -or -not $Verdict) {
    Write-Host "Gebruik: .\jengo-ouroboros-update.ps1 -Claim '<tekst>' -Verdict CONFIRMED|CONTRADICTED" -ForegroundColor Yellow
    Write-Host "         .\jengo-ouroboros-update.ps1 -ListCanon" -ForegroundColor Yellow
    exit 1
}

# MATCH CLAIM TEGEN CANON
function Get-MatchScore($text, $entry) {
    $score   = 0.0
    $textLow = $text.ToLower()

    foreach ($trigger in $entry.blacklist_triggers) {
        if ($textLow.Contains($trigger.ToLower())) { $score += 0.6 }
    }

    foreach ($kw in $entry.contradiction_keywords) {
        if ($textLow.Contains($kw.ToLower())) { $score += 0.3 }
    }

    $nameWords = $entry.naam.ToLower() -split '\s+' | Where-Object { $_.Length -gt 4 }
    foreach ($w in $nameWords) {
        if ($textLow.Contains($w)) { $score += 0.15 }
    }

    return [math]::Min(1.0, $score)
}

$matches = @()
foreach ($entry in $canon.canon) {
    $score = Get-MatchScore $Claim $entry
    if ($score -gt 0.2) {
        $matches += [PSCustomObject]@{ entry = $entry; score = $score }
    }
}

$matches = $matches | Sort-Object score -Descending

if (-not $matches) {
    Write-Host ""
    Write-Host "  Geen Canon-entry gevonden voor: '$Claim'" -ForegroundColor Yellow
    Write-Host "  Tip: gebruik -ListCanon om bestaande entries te zien" -ForegroundColor DarkGray
    Write-Host ""
    exit 0
}

# UPDATE CONFIDENCE
if ($Verdict -eq "CONFIRMED") { $delta = 0.02 } else { $delta = -0.05 }

$updates = @()

Write-Host ""
Write-Host "  OUROBOROS UPDATE - $Verdict" -ForegroundColor Cyan
Write-Host "  ----------------------------" -ForegroundColor DarkGray

foreach ($m in $matches | Select-Object -First 3) {
    $entry   = $m.entry
    $oldConf = $entry.confidence
    $newConf = [math]::Round([math]::Max(0.10, [math]::Min(0.99, $oldConf + $delta)), 3)

    $entry.confidence = $newConf

    if ($delta -gt 0) { $direction = "+" ; $color = "Green" } else { $direction = "-" ; $color = "Red" }

    Write-Host ("  {0}  {1}" -f $entry.id, $entry.naam) -ForegroundColor White
    Write-Host ("    confidence: {0}% {1} {2}%  (delta: {3})" -f ([math]::Round($oldConf*100,0)), $direction, ([math]::Round($newConf*100,0)), $delta) -ForegroundColor $color
    Write-Host ""

    $updates += [PSCustomObject]@{
        canon_id    = $entry.id
        old_conf    = $oldConf
        new_conf    = $newConf
        delta       = $delta
        match_score = $m.score
    }
}

# OPSLAAN
$canon | ConvertTo-Json -Depth 10 | Set-Content $canonPath -Encoding UTF8

# LOG ENTRY
$logEntry = [PSCustomObject]@{
    timestamp = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
    claim     = $Claim
    verdict   = $Verdict
    bron      = $Bron
    updates   = $updates
} | ConvertTo-Json -Compress

Add-Content $logPath $logEntry -Encoding UTF8

Write-Host "  Canon bijgewerkt: $canonPath" -ForegroundColor DarkGray
Write-Host "  Log: $logPath" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  Ouroboros: plafond van deze sessie = vloer van de volgende." -ForegroundColor DarkGray
Write-Host ""
