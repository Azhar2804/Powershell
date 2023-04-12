"" | Set-Content "C:\Temp\localuserlist.txt"
 
#Get-LocalUser | Select-Object -ExpandProperty Name | Set-Content -Encoding utf8 C:\Temp\localuserlist.txt
 
    $xdoc2 = Get-Localuser | ConvertTo-Xml -as string | Set-Content -Encoding utf8 C:\Temp\localuserdetails.xml
    $xdoc_2 = new-object System.Xml.XmlDocument
    $file_2 = resolve-path("C:\Temp\localuserdetails.xml")
    $xdoc_2.load($file_2)
 
 
 
#Initialize array for Local User result
$LocalUserArray_2 = @()
#$LocalUserArray_2 = "|Computername|Domain|USERNAME|Enabled|Description|AccountExpires|PasswordChangeableDate|PasswordExpires|UserMayChangePassword|PasswordRequired|PasswordLastSet|LastLogon|Name|SID|PrincipalSource|ObjectClass|Groups|----"
 
 
 
    Foreach ($localuser in $xdoc_2.Objects.Object){
        #Initialize to blank for each user
 
        $Username= ""
        $Enabled=""
        $Description=""
        $AccountExpires= ""
        $PasswordChangeableDate=""
        $PasswordExpires=""
        $UserMayChangePassword= ""
        $PasswordRequired=""
        $PasswordLastSet=""
        $LastLogon= ""
        $Name=""
        $SID=""
        $PrincipalSource=""
        $ObjectClass=""
        $Group=""
 
        #Get the details for each property of group
        Foreach ($localUserProperty in $localuser.property){
            if($localUserProperty.Name -eq "Name"){
                $Username = $localUserProperty.'#text'
                $GRP1 = net user $Username |Select-String "Local Group Memberships"
                $Groups = $GRP1 -replace 'Local Group Memberships',''  -replace '\*' ,'|'
            } elseif($localUserProperty.Name -eq "Enabled"){
                $Enabled = $localUserProperty.'#text'
            } elseif($localUserProperty.Name -eq "Description"){
                $Description = $localUserProperty.'#text'
            } elseif($localUserProperty.Name -eq "FullName"){
                $Name = $localUserProperty.'#text'
            } elseif($localUserProperty.Name -eq "AccountExpires"){
                $AccountExpires = $localUserProperty.'#text'
            } elseif($localUserProperty.Name -eq "PasswordChangeableDate"){
                $PasswordChangeableDate = $localUserProperty.'#text'
            } elseif($localUserProperty.Name -eq "PasswordExpires"){
                $PasswordExpires = $localUserProperty.'#text'
            }  elseif($localUserProperty.Name -eq "UserMayChangePassword"){
                $UserMayChangePassword  = $localUserProperty.'#text'
            } elseif($localUserProperty.Name -eq "PasswordRequired"){
                $PasswordRequired = $localUserProperty.'#text'
            } elseif($localUserProperty.Name -eq "PasswordLastSet"){
                $PasswordLastSet = $localUserProperty.'#text'
            } elseif($localUserProperty.Name -eq "LastLogon"){
                $LastLogon = $localUserProperty.'#text'
            } elseif($localUserProperty.Name -eq "SID"){
                $SID = $localUserProperty.'#text'
            } elseif($localUserProperty.Name -eq "PrincipalSource"){
                $PrincipalSource = $localUserProperty.'#text'
            } elseif($localUserProperty.Name -eq "ObjectClass"){
                $ObjectClass = $localUserProperty.'#text'
            }
        }
 
        #log details for each group
        #Write-Host "|$($env:COMPUTERNAME)|$($env:userdnsdomain)|$($Username)|$($Enabled)|$($Description)|$($AccountExpires)|$($PasswordChangeableDate)|$($PasswordExpires)|$($UserMayChangePassword)|$($PasswordRequired)|$($PasswordLastSet)|$($LastLogon)|$($Name)|$($SID)|$($PrincipalSource)|$($ObjectClass)|$($Groups)|----"
        #Add line end and new group details
        #$LocalUserArray_2 += $("" | Out-String)
        $LocalUserArray_2 += "|$($env:COMPUTERNAME)|$($env:userdnsdomain)|$($Username)|$($Enabled)|$($Description)|$($AccountExpires)|$($PasswordChangeableDate)|$($PasswordExpires)|$($UserMayChangePassword)|$($PasswordRequired)|$($PasswordLastSet)|$($LastLogon)|$($Name)|$($SID)|$($PrincipalSource)|$($ObjectClass)|$($Groups)|----"
 
    }
 
 
    $LocalUserArray_2 |out-file C:\Temp\localuserlist.txt
 
    Get-Content ("C:\Temp\localuserlist.txt")
