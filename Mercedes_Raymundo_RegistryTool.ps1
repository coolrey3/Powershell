#start log
Start-Transcript;""

#Define Paths Array
$array = @()

#Define Verify Array
$verify = @()

#Registry "Master" keys array
$keys ="VB and VBA Program Settings", "Power Analysis"

#Registry Sub Keys Array
$skeys = "Graph","Recent"

#Software registry path
$reg = "HKLM:\Software"

#Test and create "Master" keys if not found
ForEach($key in $keys) {
    
    if(test-path "$reg\$key") {"$key key already exists"}  else {"$key key does not exist, creating now"; new-item "$reg" -name "$key" -itemtype "directory"}
    $reg = "$reg\$key"
    
    #Registry path added to array
    $array += New-Object psobject $reg
    
    #verification messages added to array
    $vkey = "$key key verified."
    $verify += New-Object psobject $vkey
    $vkey    
    }

#Test and create Sub keys if not found
ForEach($skey in $skeys) {
    $reg = "HKLM:\Software\VB and VBA Program Settings\Power Analysis"
    
     if(test-path "$reg\$skey") {"$skey key already exists"}  else {"$skey key does not exist creating now" ; new-item $reg -Name "$skey"  -itemtype "directory";}
     $reg = "$reg\$skey"

     #Registry path added to array
     $array += New-Object psobject $reg    

     #verification messages added to array
     $vskey = "$skey key verified."
     $verify += New-Object psobject $vskey
     $vskey
     
  
     }
           
 #create Graph registry key properties

 new-itemproperty -path $array[2] -name "gColor(1,0)" -value "1"
 new-itemproperty -path $array[2] -name "gColor(1,1)" -value "1"
 new-itemproperty -path $array[2] -name "gColor(1,2)" -value "1"
 new-itemproperty -path $array[2] -name "gColor(1,3)" -value "1"
 new-itemproperty -path $array[2] -name "gColor(1,4)" -value "1"
 new-itemproperty -path $array[2] -name "gColor(1,5)" -value "1"
 new-itemproperty -path $array[2] -name "gColorScheme" -value "1"

  #create Recent registry key properties
 new-itemproperty -path $array[3] -name 10 
 new-itemproperty -path $array[3] -name 5 
 new-itemproperty -path $array[3] -name 6 
 new-itemproperty -path $array[3] -name 7 
 new-itemproperty -path $array[3] -name 8 
 new-itemproperty -path $array[3] -name 9 

 #verify registry key values
 Get-ItemProperty -path $array[2]
 Get-ItemProperty -path $array[3]

 #Validate keys created sucessfully after foreach statement
 $vg=test-path $array[2];
 $vr=test-path $array[3];

 #Write results of script to Event Viewer
 Write-EventLog -LogName "Application" -source "SamplePower Registry" -eventid 1 -EntryType Information -message "Tests and creates Registry Keys if they are not found. Result: $verify"   -category 1 -rawdata 10,20

 #stop log
 Stop-Transcript