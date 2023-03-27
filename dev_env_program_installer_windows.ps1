<#
References:
- Check whether running as admin: https://stackoverflow.com/a/29129883

#>
Set-ExecutionPolicy Bypass -Scope Process -Force; 
$ErrorActionPreference = "Stop"

$packageList = @{
    "7zip.install" = ""
    "powershell-core" = ""
    "winscp.install" = ""
    "docker-desktop" = ""
    "nodejs.install" = ""
    wsl2 = ""
    golang = ""
    python = ""
    sysinternals = ""
    curl = ""
    wget = ""
    winpcap = ""
    wireshark = ""
    vagrant = ""
    virtualbox = ""
    foxitreader = ""
    openssh = ""
    vlc = ""
    git = ""
    vim = ""
    openssl = ""
    vscode = ""
    googlechrome = ""
    postman = ""
    sqlitebrowser = ""
    firefox = ""
}

function failIfNotAdministrator() {
    $elevated = ([Security.Principal.WindowsPrincipal] `
                [Security.Principal.WindowsIdentity]::GetCurrent()
                ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (!$elevated) {
        Write-Error "This script needs to be run as administrator."
    }
}

function installChoco() {
    # Install Choco
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

#### MAIN ####

failIfNotAdministrator
installChoco

$packageList.Keys | ForEach-Object { 
    $packageName = $_
    $packageVersion = $packageList.Item($packageName)    
    $chocoCmd = "choco install -y $packageName"

    if ($packageVersion.Trim()) {
        $chocoCmd += " --version=$packageVersion"
    }
    Write-Host $chocoCmd
    Invoke-Expression $chocoCmd
}