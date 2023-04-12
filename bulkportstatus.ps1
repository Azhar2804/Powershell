$list=Get-Content .\list1.txt
foreach ($item in $list) {
$status = Test-NetConnection -port 443 -InformationLevel quiet -computername $item
$data= $($item) +"|"+ $($status)
$data |out-file .\port_status01.txt -append
}
Send-MailMessage -From 'mail@mai.com' -To 'mail@mail.com' -Subject 'Port status' -Body "Please fidn teh port status." -Attachments c:\temp\port_status.txt -SmtpServer 'smtp.com'
