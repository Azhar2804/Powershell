"" | Set-Content "C:\Temp\ansible_uptime.txt"
$hostname = hostname
$uptime = (Get-CimInstance -ClassName Win32_OperatingSystem -Property LastBootUpTime).LastBootUpTime
$data = @()

$data += "|$($hostname)|$($uptime)|"
  

$data | out-file C:\Temp\ansible_uptime.txt

Get-Content ("C:\Temp\ansible_uptime.txt")
