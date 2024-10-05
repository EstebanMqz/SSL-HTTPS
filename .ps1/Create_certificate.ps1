<#
With PKI module a self-signed .pfx certificate is created with a randomly generated password for HTTPS testing/development envs with specified DNS stored in the current user's store. 
#>


#PS built-in PKI module.
Import-Module -Name PKI
# Create self-signed certificate for HTTPS  
$cert = New-SelfSignedCertificate -DnsName $env:COMPUTERNAME -CertStoreLocation "cert:\CurrentUser\My" -KeyUsage DigitalSignature -Type CodeSigningCert
# Randomly generated password. 
$PASSWORD = [Convert]::ToBase64String((1..16 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 }))
# Export to .pfx file in parent dir.
Export-PfxCertificate -cert $cert.PSPath -FilePath (Join-Path (Split-Path $PSScriptRoot -Parent) "Certificate.pfx") -Password (ConvertTo-SecureString -String "$PASSWORD" -Force -AsPlainText)
#Success msg
Write-Host "Certificate created successfully. Password: $PASSWORD" -ForegroundColor Green
# Save the password to a file in parent dir.
$parentDir = Split-Path $PSScriptRoot -Parent
$passwordFilePath = Join-Path $parentDir "password.txt"
Set-Content -Path $passwordFilePath -Value $PASSWORD
# Encrypt password.txt with GPG

# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You need to run this script as an Administrator."
    Break
}
# Check if gpg is installed
if (!(Get-Command -Name gpg -ErrorAction SilentlyContinue)) {
    Write-Host "Installing gpg package..."
    choco install gpg -y
}

& gpg --encrypt --recipient 'emarquez1895@gmail.com' $passwordFilePath
# Delete password .txt file
Remove-Item -Path $passwordFilePath