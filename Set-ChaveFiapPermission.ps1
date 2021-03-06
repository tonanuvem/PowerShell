# https://blog.netwrix.com/2018/04/18/how-to-manage-file-system-acls-with-powershell-scripts/
# https://superuser.com/questions/1296024/windows-ssh-permissions-for-private-key-are-too-open
# https://blue42.net/windows/changing-ntfs-security-permissions-using-powershell/
# https://superuser.com/questions/1524970/removing-users-via-powershell-with-multiple-domains

# Set Variable ::
$KEY = ".\chave-fiap.pem"

Write-Output "============= Permissoes iniciais ============="
Get-Acl $KEY | Format-List

# Remove Inheritance ::
$acl = Get-Acl $KEY
$acl.SetAccessRuleProtection($true,$false)
$acl | Set-Acl $KEY


# Set Ownership to Owner ::
$acl = Get-Acl $KEY
$object = New-Object System.Security.Principal.Ntaccount("$env:username")
$acl.SetOwner($object)
$acl | Set-Acl $KEY

# Remove All Users, except for Owner ::
<#
#OPCAO 1:
$acl = Get-Acl $KEY
foreach($user in $acl.Access.IdentityReference.Value )
{
  Write-Host "  ==  Removendo $user ==  " -ForegroundColor Yellow
  $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($user,"FullControl","Allow")
  #$acl.RemoveAccessRule($AccessRule)
  $acl | Set-Acl $KEY
}
#>
#OPCAO 2:
# get explicit permissions
$acl = Get-Acl $KEY
$acl.Access |
  Where-Object { $_.isInherited -eq $false } |
  # ...and remove them
  ForEach-Object { $acl.RemoveAccessRuleAll($_) } 
# set new permissions
$acl | Set-Acl $KEY 
#

# Deixar a permissão somente para o proprio usuario
$acl = Get-Acl $KEY
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$env:username","FullControl","Allow")
$acl.AddAccessRule($AccessRule)
$acl | Set-Acl $KEY


Write-Output "============= Permissoes configuradas  ============="
Get-Acl $KEY | Format-List
