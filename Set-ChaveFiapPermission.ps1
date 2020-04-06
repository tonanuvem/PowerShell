# https://blog.netwrix.com/2018/04/18/how-to-manage-file-system-acls-with-powershell-scripts/
# https://superuser.com/questions/1296024/windows-ssh-permissions-for-private-key-are-too-open

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
#Cmd /c Icacls $KEY /c /t /Remove Administrator "Authenticated Users" BUILTIN\Administrators BUILTIN Everyone System Users
$acl = Get-Acl $KEY
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrator","FullControl","Allow")
$acl.RemoveAccessRule($AccessRule)
$acl | Set-Acl $KEY
$acl = Get-Acl $KEY
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Authenticated Users","FullControl","Allow")
$acl.RemoveAccessRule($AccessRule)
$acl | Set-Acl $KEY
$acl = Get-Acl $KEY
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\Administrators","FullControl","Allow")
$acl.RemoveAccessRule($AccessRule)
$acl | Set-Acl $KEY
$acl = Get-Acl $KEY
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN","FullControl","Allow")
$acl.RemoveAccessRule($AccessRule)
$acl | Set-Acl $KEY
$acl = Get-Acl $KEY
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone","FullControl","Allow")
$acl.RemoveAccessRule($AccessRule)
$acl | Set-Acl $KEY
$acl = Get-Acl $KEY
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("System","FullControl","Allow")
$acl.RemoveAccessRule($AccessRule)
$acl | Set-Acl $KEY
$acl = Get-Acl $KEY
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Users","FullControl","Allow")
$acl.RemoveAccessRule($AccessRule)
$acl | Set-Acl $KEY

# Verify ::
Cmd /c Icacls $KEY
