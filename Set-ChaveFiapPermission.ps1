:: # Set Variable ::
Set Key="chave-fiap.pem"

:: # Remove Inheritance ::
Cmd /c Icacls %Key% /c /t /Inheritance:d

:: # Set Ownership to Owner ::
Cmd /c Icacls %Key% /c /t /Grant %UserName%:F

:: # Remove All Users, except for Owner ::
Cmd /c Icacls %Key% /c /t /Remove Administrator "Authenticated Users" BUILTIN\Administrators BUILTIN Everyone System Users

:: # Verify ::
Cmd /c Icacls %Key%
