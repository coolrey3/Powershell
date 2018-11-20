#Log Folder Path
$logfolder = "C:\Logs"

#check for Log Folder, if it does not exist create 
if(Test-Path $logfolder) {"Log Folder Exists"} else {"Log Folder does not exist, Creating now"; "";New-Item -ItemType "directory" -Name "Logs" -Path "c:\";  } 

#Start log
Start-Transcript -Path "C:\logs\Notepad_Installation.log"

#File download url 
$download32= "https://notepad-plus-plus.org/repository/7.x/7.5.4/npp.7.5.4.Installer.exe"
$download64= "https://notepad-plus-plus.org/repository/7.x/7.5.4/npp.7.5.4.Installer.x64.exe"

#Install file path
$install32 = "c:\npp.7.5.4.Installer.exe"
$install64 = "c:\npp.7.5.4.Installer.x64.exe"

#get computer architecture
$osarch = Get-WmiObject win32_operatingsystem

#64bit install
if($osarch.OSArchitecture -eq "64-bit") {"64 bit architecture detected.";

#check for notepad++.exe 64 bit, if it does not exist install application

 if( Test-Path "C:\Program Files\Notepad++\notepad++.exe" )
     {"" ;"notepad++ already installed"} else
     {"Notepad++ not installed, Installing now." ; 
     Invoke-WebRequest -Uri $download64 -OutFile $install64;
     Start-Process $install64 -ArgumentList "/S  " } 
     "Log Folder created and Notepad++ successfully installed:"
     start-sleep -Seconds 5; Test-Path "C:\program files\Notepad++\notepad++.exe"}
      
else 

#32 bit install
{"32 Bit architecture detected."; 

#check for notepad++.exe 32 bit, if it does not exist install application

if( Test-Path "C:\Program Files\Notepad++\notepad++.exe" )
     {"" ;"Notepad++ installed"} else
     {"Notepad++ not installed, Installing now." ;
     Invoke-WebRequest -Uri $download32 -OutFile $install32;
     Start-Process $install32 -ArgumentList " /S" } 
     "Log Folder created and Notepad++ successfully installed:"
     Test-Path "C:\program files\Notepad++\notepad++.exe" 
     }
 
#stop log
Stop-Transcript
