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
    mkdir mpi_dir
    cd mpi_dir
    # install MPI SDK and Runtime
    Write-Host "Installing Microsoft MPI SDK..."
    $download_url = "https://download.microsoft.com/download/A/E/0/AE002626-9D9D-448D-8197-1EA510E297CE/"
    $msmpisdk_filename = "msmpisdk.msi"
    $msmpisdk_webfilename = $download_url + $msmpisdk_filename

    MyDownloadFile( $msmpisdk_webfilename )
    
    Start-Process -FilePath msiexec.exe -ArgumentList "/quiet /qn /i msmpisdk.msi" -Wait
    Write-Host "Microsoft MPI SDK installation complete"
    
    Write-Host "Installing Microsoft MPI Runtime..."
    $msmpisetup_filename = "msmpisetup.exe"
    $msmpisetup_webfilename = $download_url + $msmpisetup_filename
    
    MyDownloadFile( $msmpisetup_webfilename )
    
    Start-Process -FilePath MSMpiSetup.exe -ArgumentList -unattend -Wait
    Write-Host "Microsoft MPI Runtime installation complete..."
    
    $msmpi_bin_path = "C:/Program Files/Microsoft MPI/Bin"
    $msmpi_sdk_path = "C:/Program Files (x86)/Microsoft SDKs/MPI"
    
    $Env:Path = $Env:Path + ";$msmpi_bin_path"
	
	#[environment]::SetEnvironmentvariable("path", $Env:Path, "User")
	#$a3 = [environment]::GetEnvironmentvariable("path", "User")
	
	[environment]::SetEnvironmentvariable("path", $Env:Path, [System.EnvironmentVariableTarget]::Machine)
	$a3 = [environment]::GetEnvironmentvariable("path", [System.EnvironmentVariableTarget]::Machine)
	
	Write-Host "the path is = $a3"
	
    Write-Host "ls $msmpi_sdk_path"
    ls $msmpi_sdk_path
    Write-Host "ls $msmpi_sdk_path"
    ls $msmpi_bin_path
    
    Write-Host "mpiexec"
    mpiexec	
}

function main() {
    #test
    InstallMSMPI
}

main