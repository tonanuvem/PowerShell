# https://blog.netwrix.com/2018/04/18/how-to-manage-file-system-acls-with-powershell-scripts/

# Set Variable ::
#Set Key="chave-fiap.pem"
$KEY = ".\chave-fiap.pem"

# Remove Inheritance ::
#Cmd /c Icacls %Key% /c /t /Inheritance:d
$acl = Get-Acl $KEY
$acl.SetAccessRuleProtection($true,$false)
$acl | Set-Acl $KEY


# Set Ownership to Owner ::
#Cmd /c Icacls %Key% /c /t /Grant %UserName%:F
$acl = Get-Acl $KEY
$object = New-Object System.Security.Principal.Ntaccount("$env:username")
$acl.SetOwner($object)
$acl | Set-Acl $KEY

# Remove All Users, except for Owner ::
Cmd /c Icacls $KEY /c /t /Remove Administrator "Authenticated Users" BUILTIN\Administrators BUILTIN Everyone System Users

# Verify ::
Cmd /c Icacls $KEY
