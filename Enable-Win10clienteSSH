# https://code.visualstudio.com/docs/remote/troubleshooting#_installing-a-supported-ssh-client

# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# OPCIONAL: Install the OpenSSH Server
#Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Verificar instalação 
Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'
