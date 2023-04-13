# Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

# $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; Remove-Item .\AzureCLI.msi

$dotnetUrl = "https://download.visualstudio.microsoft.com/download/pr/8bcb6974-4e80-4a4f-8d0b-04d1f830a963/086a9c2d8f559a97de7c98b75e083b55/dotnet-runtime-5.0.11-win-x64.exe"

$dotnetInstaller = "$env:TEMP\dotnet-runtime.exe"

Invoke-WebRequest $dotnetUrl -OutFile $dotnetInstaller

Start-Process $dotnetInstaller -ArgumentList '/install /quiet /norestart' -Wait
