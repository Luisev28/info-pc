$get = Get-ComputerInfo -Property "BiosSeralNumber";

 $url = 'https://linkdaapi/paraupdate/'+$get  

 $params = @{"owner” = Get-ComputerInfo -Property “WindowsRegisteredOwner”;
“bios” = Get-ComputerInfo -Property “BiosManufacturer”;
“serial” = Get-ComputerInfo -Property “BiosSeralNumber”;
“serial_number” = Get-ComputerInfo -Property “BiosSeralNumber”;
“modelo”  = Get-ComputerInfo -Property “CsModel”;
“hostname” = Get-ComputerInfo -Property “CsName”;
“processador” = Get-CimInstance -ClassName Win32_Processor | Select-Object -ExcludeProperty "CIM*" -Property "Name";
 “memoria” = Get-ComputerInfo -Property “OsTotalVisibleMemorySize”;
“tipo” = Get-ComputerInfo -Property “PowerPlatformRole”;
“ip” = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content;
"ip2" = (Invoke-WebRequest -uri "http://ipinfo.io/ip").Content;
"hd" = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" -Property Size | Select-Object -Property Size | ConvertTo-Json ;
"bssid" = netsh wlan show networks mode=bssid|findstr BSSID | ConvertTo-Json;
};
  


Invoke-RestMethod -Uri $url -Body $params -Method Put -ContentType "application/x-www-form-urlencoded"


$clock = [diagnostics.stopwatch]::StartNew()
while ($clock.elapsed){
Invoke-RestMethod -Uri $url -Body  $params -Method Put -ContentType "application/x-www-form-urlencoded"

cls
Invoke-RestMethod -Uri $url -Body  $params -Method Put -ContentType "application/x-www-form-urlencoded"

start-sleep -seconds 3600
}
