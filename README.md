<p align="center">
  <a href="https://varilan.de" target="_blank"><img src="https://varilan.de/wp-content/uploads/2023/06/Varilan-Color-Logo-h150.png"></a>
</p>

# Monitoring / Nagios check for the HPE iLO Health Summary
This monitoring check get the iLO health over Powershell and checks the parameters.


## Requirements

 1. Reacable HPE iLO Webinterface
 2. Powershell HPEiLOCmdlets

Howto install the official HPEiLOCmdlets over Powershell. 

**Run with admin rights:**

    Install-Module -Name HPEiLOCmdlets
Or download manually:  https://www.powershellgallery.com/packages/HPEiLOCmdlets/
Offical HP Downloadpage: https://support.hpe.com/connect/s/softwaredetails?language=en_US&collectionId=MTX-9cb80bdda3824b3d

## Parameters  
| Parmeter | Description |  
|----------|----------------------------------|  
| ILO_IP | iLO webinterface IP |  
| ILO_USER | iLO User to Query Health Summary |  
| ILO_PASS | iLo user super secure password |

## Examples:  

### Status: OK
  
`PS .\check_hpe_ilo_health_summary.ps1 -ILO_IP 10.10.10.10 -ILO_USER Administrator -ILO_PASS supersecurepass  
--> OK: all ok`

### Status: Warning/Critical  
`PS .\check_hpe_ilo_health_summary.ps1 -ILO_IP 10.10.10.10 -ILO_USER Administrator -ILO_PASS supersecurepass  
--> CRITICAL: Storage Status = Warning`

## Which values are checked?
This script checks the values from the iLO Health Summary. To see details, log in to the iLO web interface.

    Get-HPEiLOHealthSummary -Connection $connection;

	
	AgentlessManagementService : Ready
	BatteryStatus              : OK
	BIOSHardwareStatus         : OK
	FanStatus                  : OK
	FanRedundancy              : Redundant
	MemoryStatus               : OK
	NetworkStatus              : OK
	PowerSuppliesStatus        : OK
	PowerSuppliesRedundancy    : Redundant
	PowerSuppliesMismatch      : No
	ProcessorStatus            : OK
	StorageStatus              : OK
	TemperatureStatus          : OK



### Run manually

    $connection = Connect-HPEiLO 10.10.10.10 -Username Administrator -Password supersecurepass -DisableCertificateAuthentication;
    Get-HPEiLOHealthSummary -Connection $connection;

## Copyright & Support
Copyright by <a href="https://varilan.de" target="_blank">Varilan GmbH</a>.
For support, please contact us via our Website www.varilan.de

Licensed by MIT license.
