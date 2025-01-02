@echo off
echo Retrieving Wi-Fi network passwords...

:: Create or overwrite the output file
echo Wi-Fi Network Passwords > wifi_network_passwords.txt

:: List all profiles
for /f "tokens=1 delims=:" %%i in ('netsh wlan show profiles') do (
    set profile=%%i
    set profile=!profile:~1!
    
    :: Check if the profile has a password stored
    for /f "tokens=2 delims=:" %%j in ('netsh wlan show profile name^="!profile!" key^=clear 2^>nul ^| findstr /i "Key Content"') do (
        set password=%%j
        set password=!password:~1!
        
        :: Save the network name and password to the output file
        echo !profile! : !password! >> wifi_network_passwords.txt
    )
)

echo Wi-Fi passwords have been saved to wifi_network_passwords.txt.
pause
