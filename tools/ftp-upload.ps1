param([string]$LocalFile, [string]$RemotePath)
$user = 'u63291p434771'
$pass = [string]'?:jO8;TrSFQAtsD3c' + [char]96 + 'IMt{'
if (-not $RemotePath.StartsWith('/')) { $RemotePath = '/' + $RemotePath }
$uri = 'ftp://artrevisionist.com/domains/artrevisionist.com/public_html' + $RemotePath
$req = [System.Net.FtpWebRequest]::Create($uri)
$req.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
$req.Credentials = New-Object System.Net.NetworkCredential($user, $pass)
$req.EnableSsl = $false
$req.UsePassive = $true
$fileContent = [System.IO.File]::ReadAllBytes($LocalFile)
$req.ContentLength = $fileContent.Length
try {
    $stream = $req.GetRequestStream()
    $stream.Write($fileContent, 0, $fileContent.Length)
    $stream.Close()
    $resp = $req.GetResponse()
    Write-Host "Uploaded: $RemotePath ($($resp.StatusDescription))"
    $resp.Close()
} catch {
    Write-Host "Error: $($_.Exception.Message)"
}

