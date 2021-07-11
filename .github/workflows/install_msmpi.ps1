function test() {
    Write-Host "Hello, World!"
    Write-Host "Hello, Github actions!"
    Write-Host "Hello, OneFLOW-CFD!"
}

function MyGetFileName( $filePath ) {
    $file_name_complete = [System.IO.Path]::GetFileName("$filePath")
    $file_name_complete
    #Write-Host "fileNameFull :" $file_name_complete    
}

function MyDownloadFile( $fullFilePath ) {
    $my_filename = MyGetFileName("$fullFilePath")
    $my_location = Get-Location
    $my_local_filename = "$my_location" + "/" + $my_filename
    
    $my_client = new-object System.Net.WebClient
    $my_client.DownloadFile( $fullFilePath, $my_local_filename )    
}

function InstallMSMPI() {
}

function main() {
    #test
	Write-Host "------------------------"
	Write-Host "main : $Env:test"
	Write-Host "++++++++++++++++++++++++"
	$Env:test = " bbb "
	Write-Host "**********************"
	Write-Host "main : Env:test"
	Write-Host "main : $Env:test"
	Write-Host "xxxxxxxxxxxxxxxxxxxxxxx"
	$Env:mypath = $Env:path
    #InstallMSMPI
}

main