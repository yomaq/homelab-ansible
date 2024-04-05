# Install OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Start the SSH service
Start-Service sshd

# Set the SSH service to start automatically
Set-Service -Name sshd -StartupType 'Automatic'

# Disable password authentication
$sshdConfigPath = "C:\ProgramData\ssh\sshd_config"
$sshdConfigContent = Get-Content -Path $sshdConfigPath
$sshdConfigContent = $sshdConfigContent -replace '^#?PasswordAuthentication yes', 'PasswordAuthentication no'
$sshdConfigContent | Set-Content -Path $sshdConfigPath

# Enable key-based authentication
$sshdConfigContent = $sshdConfigContent -replace '^#?PubkeyAuthentication no', 'PubkeyAuthentication yes'
$sshdConfigContent | Set-Content -Path $sshdConfigPath

# Restart the SSH service to apply changes
Restart-Service sshd

# Check if the administrators_authorized_keys file exists, create it if not
$adminKeyPath = "C:\ProgramData\ssh\administrators_authorized_keys"
if (-not (Test-Path $adminKeyPath)) {
    New-Item -Path $adminKeyPath -ItemType File
}

# Add the first approved SSH key to the administrators_authorized_keys file
$adminKeyContent1 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6+Z..." # Replace with your actual first SSH public key
Add-Content -Path $adminKeyPath -Value $adminKeyContent1

# Add the second approved SSH key to the administrators_authorized_keys file
$adminKeyContent2 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6+Z..." # Replace with your actual second SSH public key
Add-Content -Path $adminKeyPath -Value $adminKeyContent2

# Ensure the administrators_authorized_keys file is only accessible by the Administrators group
$acl = Get-Acl -Path $adminKeyPath
$acl.SetAccessRuleProtection($true, $false)
$administratorsGroup = [System.Security.Principal.NTAccount]"Administrators"
$acl.SetOwner($administratorsGroup)
Set-Acl -Path $adminKeyPath -AclObject $acl

Write-Host "OpenSSH Server installed and configured successfully with two SSH keys."




# Install Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Wait for Chocolatey to finish installing
Start-Sleep -Seconds 10

# Install Tailscale using Chocolatey
choco install tailscale -y
