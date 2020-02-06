<#
.SYNOPSIS
This script will saturate a specified number of CPU cores to 100% utilization.
.PARAMETER <Cores>
.EXAMPLE
.\Invoke-CPUStressTest.ps1 -Cores 4
This will execute the script against 4 cores. In this case, it may be a 2-core CPU with hyper-threading enabled.
#>

[cmdletbinding()]
param(
[parameter(mandatory=$true)]
[int]$Cores
)

$Log = "CPUStressTest.ps1.log"
$StartDate = Get-Date
Write-Output "============= CPU Stress Test Started: $StartDate ============="
Write-Output "Started By: $env:username"
Write-Warning "This script will potentially saturate CPU utilization!"
$Prompt = Read-Host "Are you sure you want to proceed? (Y/N)"

if ($Cores -eq '') {
	$Cores = 4
}
if ($Prompt -eq 'Y')
{
	Write-Warning "To cancel execution of all jobs, close the PowerShell Host Window."
	Write-Output "Hyper Core Count: $NumHyperCores"

foreach ($loopnumber in 1..$NumHyperCores){
    Start-Job -ScriptBlock{
    $result = 1
        foreach ($number in 1..2147483647){
            $result = $result * $number
        }# end foreach
    }# end Start-Job
}# end foreach

Wait-Job *
Clear-Host
Receive-Job *
Remove-Job *
}# end if

else{
	Write-Output "Cancelled!"
}

$EndDate = Get-Date
Write-Output "============= CPU Stress Test Complete: $EndDate ============="
