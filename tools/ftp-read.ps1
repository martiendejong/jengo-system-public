param([string]$Path)
$user = 'u63291p434771'
$pass = [string]'?:jO8;TrSFQAtsD3c' + [char]96 + 'IMt{'
$base = 'ftp://artrevisionist.com'
if (-not $Path.StartsWith('/')) { $Path = '/' + $Path }
$uri = $base + $Path
$req = [System.Net.FtpWebRequest]::Create($uri)
$req.Method = [System.Net.WebRequestMethods+Ftp]::DownloadFile
$req.Credentials = New-Object System.Net.NetworkCredential($user, $pass)
$req.EnableSsl = $false
try {
    $resp = $req.GetResponse()
    $stream = $resp.GetResponseStream()
    $reader = New-Object System.IO.StreamReader($stream)
    Write-Output $reader.ReadToEnd()
    $reader.Close(); $resp.Close()
} catch {
    Write-Host "Error: $($_.Exception.Message)"
}
