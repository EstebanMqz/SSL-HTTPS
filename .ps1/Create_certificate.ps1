<#
Creates a self-signed .pfx certificate with a random password for HTTPS testing/development environments using the PKI module with specified DNS. It's stored in the current user's store. 

.DESCRIPTION
This script imports the PKI module and uses it to create a self-signed certificate with the specified DNS name. The certificate is stored in the current user's certificate store and is used for code signing purposes. The script also generates a random password and exports the certificate to a .pfx file.

.PARAMETER DnsName
The DNS name to be used for the self-signed certificate.

.EXAMPLE
Create-Certificate -DnsName "localhost"

This example creates a self-signed certificate with the DNS name "localhost" and exports it to a .pfx file.

.INPUTS
None.

.OUTPUTS
None.

.NOTES
- This script requires the PKI module to be installed.
- The exported .pfx file is saved to "C:\Windows\IdentityCRL\Certificate.pfx".
- The password for the .pfx file is randomly generated and stored in the $PASSWORD variable.
#>

# Import required module
Import-Module -Name PKI

# Create self-signed certificate for HTTPS Testing/Development envs. 
$cert = New-SelfSignedCertificate -DnsName $env:COMPUTERNAME -CertStoreLocation "cert:\CurrentUser\My" -KeyUsage DigitalSignature -Type CodeSigningCert

# Randomly generated password. 
$PASSWORD = [Convert]::ToBase64String((1..16 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 }))

# Export to .pfx file 
Export-PfxCertificate -cert $cert.PSPath -FilePath "C:\Windows\IdentityCRL\Certificate.pfx" -Password (ConvertTo-SecureString -String "$PASSWORD" -Force -AsPlainText)
