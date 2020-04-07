# https://blog.netwrix.com/2018/04/18/how-to-manage-file-system-acls-with-powershell-scripts/
# https://superuser.com/questions/1296024/windows-ssh-permissions-for-private-key-are-too-open
# https://blue42.net/windows/changing-ntfs-security-permissions-using-powershell/
# https://superuser.com/questions/1524970/removing-users-via-powershell-with-multiple-domains

# Set Variable ::
#Set Key="chave-fiap.pem"
#$KEY = ".\chave-fiap.pem"
$KEY = ".\dinamica.xlsx.zip"

Write-Output "============= Permissoes iniciais ============="
# Verify ::
# Cmd /c Icacls $KEY
Get-Acl $KEY | Format-List

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

Write-Output "============= Permissoes sem Herança e ajustado o Ownership ============="
# Verify ::
# Cmd /c Icacls $KEY
Get-Acl $KEY | Format-List

# Remove All Users, except for Owner ::
#Cmd /c Icacls $KEY /c /t /Remove Administrator "Authenticated Users" BUILTIN\Administrators BUILTIN Everyone System Users
$acl = Get-Acl $KEY
foreach($user in $acl.Access.IdentityReference.Value )
{
  Write-Host "  ==  Removendo $user ==  " -ForegroundColor Yellow
  $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($user,"FullControl","Allow")
  #$acl.RemoveAccessRule($AccessRule)
  $acl | Set-Acl $KEY
}

Write-Output "============= Permissoes removidas ============="
# Verify ::
# Cmd /c Icacls $KEY
Get-Acl $KEY | Format-List

# Deixar a permissão somente para o proprio usuario
acl = Get-Acl $KEY
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$env:username","FullControl","Allow")
$acl.AddAccessRule($AccessRule)
$acl | Set-Acl $KEY


Write-Output "============= Permissoes somente para o proprio usuario  ============="
# Verify ::
# Cmd /c Icacls $KEY
Get-Acl $KEY | Format-List
