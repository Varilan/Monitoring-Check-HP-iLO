<#


 __      __        _ _                _____           _     _    _ 
 \ \    / /       (_) |              / ____|         | |   | |  | |
  \ \  / /_ _ _ __ _| | __ _ _ __   | |  __ _ __ ___ | |__ | |__| |
   \ \/ / _` | '__| | |/ _` | '_ \  | | |_ | '_ ` _ \| '_ \|  __  |
    \  / (_| | |  | | | (_| | | | | | |__| | | | | | | |_) | |  | |
     \/ \__,_|_|  |_|_|\__,_|_| |_|  \_____|_| |_| |_|_.__/|_|  |_|
                                                                   
                                                                   

Version: 1.0
Autor: Varilan GmbH

Powershell script to query the iLO Health Summary
#>

param (
    [string]$ILO_IP, # iLO IP
    [string]$ILO_USER, # iLO User
    [string]$ILO_PASS # iLO Passwort
)

$HPEILOCMDLET_PATH = "C:\Program Files (x86)\Hewlett Packard Enterprise\PowerShell\Modules\HPEiLOCmdlets\HPEiLOCmdlets.psd1";

#---------------------------------------------------------------------------------

Import-Module $HPEILOCMDLET_PATH;

$errorarray = @();
$connection = Connect-HPEiLO $ILO_IP -Username $ILO_USER -Password $ILO_PASS -DisableCertificateAuthentication;
$data = Get-HPEiLOHealthSummary -Connection $connection;

if ($data.BatteryStatus -ne "OK") {
    $errorarray += "Battery Status = " + $data.BatteryStatus;
} 
if ($data.BIOSHardwareStatus -ne "OK") {
    $errorarray += "Bios Hardware Status = " + $data.BIOSHardwareStatus;
}
if ($data.FanStatus -ne "OK") {
    $errorarray += "Fan Status = " + $data.FanStatus;
}
if ($data.FanRedundancy -ne "Redundant") {
    $errorarray += "Fan Redundancy = " + $data.FanRedundancy;
}
if ($data.MemoryStatus -ne "OK") {
    $errorarray += "Memory Status = " + $data.MemoryStatus;
}
if ($data.NetworkStatus -ne "OK") {
    $errorarray += "Network Status = " + $data.NetworkStatus;
}
if ($data.PowerSuppliesStatus -ne "OK") {
    $errorarray += "Power Supplies Status = " + $data.PowerSuppliesStatus;
}
if ($data.PowerSuppliesRedundancy -ne "Redundant") {
    $errorarray += "Power Supplies Redundancy = " + $data.PowerSuppliesRedundancy;
}
if ($data.PowerSuppliesMismatch -ne "No") {
    $errorarray += "Power Supplies Mismatch = " + $data.PowerSuppliesMismatch;
}
if ($data.ProcessorStatus -ne "OK") {
    $errorarray += "Processor Status = " + $data.ProcessorStatus;
}
if ($data.StorageStatus -ne "OK") {
    $errorarray += "Storage Status = " + $data.StorageStatus;
}
if ($data.TemperatureStatus -ne "OK") {
    $errorarray += "Temperature Status = " + $data.TemperatureStatus;
}

$errorstring = $errorarray -join " | ";
if ($errorstring) {
    Write-Host "CRITICAL:" $errorstring;
    exit(2);
} else {
    Write-Host "OK: all ok";
    exit(0);
}
