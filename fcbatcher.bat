ECHO OFF
REM This is a batch process to help automate the FC patcher toolset
REM the FC patcher toolset is made by the OG's and is available in
REM github at https://github.com/o-gs/DJI_FC_Patcher
REM
REM THIS TOOL IS SPECIFIC TO MAVIC 1 PRO/PLAT AT THIS TIME
CLS
SETLOCAL DisableDelayedExpansion
if not exist tools mkdir tools
java -version >nul 2>&1 && ( GOTO:MAIN
 ) || ( call )
javac -version >nul 2>&1 && ( GOTO:MAIN
 ) || ( echo.-: Java not installed...
  pause
 exit )
:MAIN
SET APPVER=1.0
SET ORIGDATE=April 18, 2019
SET SAVEDATE=%DATE%
@ECHO OFF
CLS
ECHO.
ECHO ------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------
ECHO  The tool will assist in the FC Patcher process. The FC patcher "process"
ECHO  enables you to modify flight controller parameters on the newer versions
ECHO  of firmware for DJI Mavic Pro,  Mavic Platinum (no sd card needed), 
ECHO  Phantom 4 Std, Phanton 4 Pro, Phantom 4 Advanced, Inspire 2 and Spark.
ECHO. 
ECHO  The process isn't quick or easy. Lots of hard work was done to enable this.
ECHO.
ECHO. At a high level, we will extract the firmware, decrypt it, copy it to the
ECHO  aircraft, use the aircraft to fake a signature, decrypt the file, then 
ECHO  extract the flight controller and then you can modify it. Once that is done,
ECHO  we will recompile it and then you can use dumldore to install on the aircraft.
ECHO.
ECHO  This could brick your drone, please know what you are doing. Press 
ECHO  the any key to proceed.
ECHO. 
ECHO ------------------------------------------------------------------------
PAUSE
GOTO MAINM
:MAINM
SET APPVER=1.0
SET ORIGDATE=April 18, 2019
SET SAVEDATE=%DATE%
@ECHO OFF
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Select the firmawre you want to modify. Please make sure the .bin file
ECHO  is in the same folder as this batch file.
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO.
SET index=1
SETLOCAL ENABLEDELAYEDEXPANSION
FOR %%f IN (*.BIN) DO (
   SET file!index!=%%f
   ECHO   !index! - %%f
   SET /A index=!index!+1
)
SETLOCAL DISABLEDELAYEDEXPANSION
ECHO.
SET /P selection="Select the firmware file: "
SET file%selection% >nul 2>&1
IF ERRORLEVEL 1 (
   ECHO.
   ECHO Invalid number selected
   TIMEOUT 2   
   GOTO MAIN
)
CALL :RESOLVE %%file%selection%%%
ECHO Selected file name: %filename%
copy %filename% tools
GOTO MAIN2
:RESOLVE
SET filename=%1
GOTO :EOF
:RESOLVE1
SET filename1=%1
GOTO :EOF
:RESOLVE2
SET filename2=%1
GOTO :EOF
:RESOLVE3
SET filename3=%1
GOTO :EOF
:RESOLVE4
SET filename4=%1
GOTO :EOF
:MAIN2
for /f "tokens=1-3* delims=_" %%A in ('dir /b /a-d "%filename%"') do (
  set filenamespec=%%~A_%%~B_%%~C_%%~D
  set acversion=%%~A
  set acname=%%~B
  set miscfilename1=%%~C
  set miscfilename2=%%~D
)
REM CALL :FILECHECK
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  You have selected the following firmware, please confirm.
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO.
ECHO   Firmware Filename    : %filename%
ECHO   Aircraft Type        : %acname%
ECHO   Firmware Version     : %acversion%
ECHO.
SET /P M=Is this information right? Y/N: 
IF %M%==Y GOTO MAIN3
IF %M%==y GOTO MAIN3
IF %M%==N GOTO MAIN
IF %M%==n GOTO MAIN
IF %M%==Q GOTO EOF
IF %M%==q GOTO EOF
:MAIN3
@ECHO OFF
python --version 2>NUL
if errorlevel 1 goto NOPY
GOTO DL1
:NOPY
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  You don't have Python installed. Goto python.org and download python
ECHO.
ECHO ------------------------------------------------------------------------------
TIMEOUT 2 >nul
EXIT
:DL1
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading image.py ..
ECHO.
ECHO ------------------------------------------------------------------------------
IF EXIST "image.py" (
GOTO DL2
) ELSE (
ECHO.
ECHO Downloading image.py tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/fvantienen/dji_rev/raw/master/tools/image.py image.py
)
TIMEOUT 2 >nul
GOTO DL2
:DL2
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading dji_mvfc_fwpak.py ..
ECHO.
ECHO ------------------------------------------------------------------------------
IF EXIST "dji_mvfc_fwpak.py" (
GOTO DL3
) ELSE (
ECHO.
ECHO Downloading dji_mvfc_fwpak.py tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/o-gs/dji-firmware-tools/raw/master/dji_mvfc_fwpak.py dji_mvfc_fwpak.py
)
TIMEOUT 2 >nul
GOTO DL3
:DL3
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading dji_flyc_param_ed.py ..
ECHO.
ECHO ------------------------------------------------------------------------------
IF EXIST "dji_flyc_param_ed.py" (
GOTO EXTRACTBIN
) ELSE (
ECHO.
ECHO Downloading dji_flyc_param_ed.py tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/o-gs/dji-firmware-tools/raw/master/dji_flyc_param_ed.py dji_flyc_param_ed.py
)
TIMEOUT 2 >nul
GOTO DL4
:DL4
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading FC_patch_sequence_for_dummy_verify.sh ..
ECHO.
ECHO ------------------------------------------------------------------------------
IF EXIST "FC_patch_sequence_for_dummy_verify.sh" (
GOTO DL5
) ELSE (
ECHO.
ECHO Downloading FC_patch_sequence_for_dummy_verify.sh tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/o-gs/DJI_FC_Patcher/raw/master/FC_patch_sequence_for_dummy_verify.sh FC_patch_sequence_for_dummy_verify.sh
)
TIMEOUT 2 >nul
GOTO DL5
:DL5
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading patcher.py ..
ECHO.
ECHO ------------------------------------------------------------------------------
IF EXIST "FC_patch_sequence_for_dummy_verify.sh" (
GOTO DL5
) ELSE (
ECHO.
ECHO Downloading patcher.py tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/o-gs/DJI_FC_Patcher/raw/master/patcher.py patcher.py
)
TIMEOUT 2 >nul
GOTO DL6
:DL6
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading patch_wm220_0306.py .. right now this is for Mavic only
ECHO.
ECHO ------------------------------------------------------------------------------
IF EXIST "patch_wm220_0306.py" (
GOTO DL5
) ELSE (
ECHO.
ECHO Downloading patch_wm220_0306.py tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/o-gs/DJI_FC_Patcher/raw/master/patch_wm220_0306.py patch_wm220_0306.py
)
TIMEOUT 2 >nul
GOTO EXTRACTBIN
:EXTRACTBIN
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  We will now do some work to extract the firmware files (cfg, 305 and 306). 
ECHO.
ECHO  We will then decrypt the cfg file and move things where we need to put back 
ECHO  together. 
ECHO.
ECHO ------------------------------------------------------------------------------
PAUSE
REM TIMEOUT 2 >nul // will pause rather than timeout to allow reading
ECHO OFF
REM md final
copy dji_mvfc_fwpak.py tools
copy dji_flyc_param_ed.py tools
copy %filename% tools
copy 7z.exe tools
copy image.py tools
cd tools
md fwextract
7z.exe x %filename%
copy *305*.* fwextract
copy *306*.* fwextract
copy *w*.cfg.sig fwextract
copy image.py fwextract
del %filename%
del *.sig
del image.py
del 7z.exe
cd fwextract
md 305
md 306
md cfgn
GOTO 305MOD
:305MOD
copy *305*.* 305
cd 305
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  We found the following 305 module files. Please select the one to use.
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO.
SET index=1
SETLOCAL ENABLEDELAYEDEXPANSION
FOR %%f IN (*305*.SIG) DO (
   SET file!index!=%%f
   ECHO   !index! - %%f
   SET /A index=!index!+1
)
SETLOCAL DISABLEDELAYEDEXPANSION
ECHO.
SET /P selection="Select the 305 module file: "
SET file%selection% >nul 2>&1
IF ERRORLEVEL 1 (
   ECHO.
   ECHO Invalid number selected
   TIMEOUT 2   
   GOTO MAIN
)
CALL :RESOLVE1 %%file%selection%%%
ECHO Selected file name: %filename1%
cd ..
del *305*.*
TIMEOUT 2 >nul
GOTO M306
:M306
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  We found the following 306 module files. Please select the one to use.
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO.
SET index=1
SETLOCAL ENABLEDELAYEDEXPANSION
FOR %%f IN (*306*.SIG) DO (
   SET file!index!=%%f
   ECHO   !index! - %%f
   SET /A index=!index!+1
)
SETLOCAL DISABLEDELAYEDEXPANSION
ECHO.
SET /P selection="Select the 306 module file: "
SET file%selection% >nul 2>&1
IF ERRORLEVEL 1 (
   ECHO.
   ECHO Invalid number selected
   TIMEOUT 2   
   GOTO MAIN
)
CALL :RESOLVE2 %%file%selection%%%
ECHO Selected file name: %filename2%
copy *306*.* ..
del *306*.*
TIMEOUT 2 >nul
GOTO MCFGN
:MCFGN
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  We will now copy the CFG file and decrypt with image.py (credits: fvantienen) 
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO.
SET index=1
SETLOCAL ENABLEDELAYEDEXPANSION
FOR %%f IN (W*.SIG) DO (
   SET file!index!=%%f
   ECHO   !index! - %%f
   SET /A index=!index!+1
)
SETLOCAL DISABLEDELAYEDEXPANSION
ECHO.
SET /P selection="Select the proper CFG file: "
SET file%selection% >nul 2>&1
IF ERRORLEVEL 1 (
   ECHO.
   ECHO Invalid number selected
   TIMEOUT 2   
   GOTO MAIN
)
CALL :RESOLVE3 %%file%selection%%%
ECHO Selected file name: %filename3%
copy w*.cfg.sig cfgn
copy image.py cfgn
del image.py
del w*.sig
GOTO WOO
:WOO
cd cfgn
for /f "tokens=1-3* delims=." %%A in ('dir /b /a-d "%filename3%"') do (
  set filenamespec=%%~A.%%~B.%%C
  set acmodel3=%%~A
  set sig1%%~B
  set sig2=%%~C
)
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  We are attempting to decrypt the cfg file.
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO.
TIMEOUT 2 >nul
python image.py %acmodel3%.cfg.sig
move %acmodel3%.cfg_0000.bin %acmodel3%.cfg.ori
copy %acmodel3%.cfg.ori ..
del *.ori
del *.sig
del image.py
cd ..
GOTO 305FOLDERS
:305FOLDERS
cd 305
for /f "tokens=1-3* delims=_" %%A in ('dir /b /a-d "%filename1%"') do (
  set filenamespec=%%~A_%%~B_%%~C_%%~D
  set acmodel=%%~A
  set acmodule1=%%~B
  set acversion305=%%~C
  set miscfiledate=%%~D
)
copy *305*.* ..
del *305*.*
cd ..
GOTO 306FOLDERS
:306FOLDERS
for /f "tokens=1-3* delims=_" %%A in ('dir /b /a-d "%filename2%"') do (
  set filenamespec=%%~A_%%~B_%%~C_%%~D
  set acmodel2=%%~A
  set acmodule2=%%~B
  set acversion306=%%~C
  set miscfiledate2=%%~D
)
GOTO MOVEIT
:MOVEIT
cd 306
copy *306*.* ..
del *306*.*
cd ..
copy *306*.* ..
del *306*.*
cd ..
copy *306*.* ..
del *306*.*
cd ..
copy *306*.* adb
del *306*.*
cd adb
del patch*.*
cd .. 
cd tools
cd fwextract
rd cfgn
rd 306
rd 305
cd ..
cd ..
GOTO ADB1
:ADB1
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Now we will need to connect to the aircraft. Plug it in via USB and power on.
ECHO.
ECHO  After plugging in, wait about 30 seconds for the computer to recognize it. DO
ECHO  not close this window. Do not power off the %acname%
ECHO.
ECHO. 
ECHO. After about 30-60 seconds, press the any key to continue.
ECHO.
ECHO ------------------------------------------------------------------------------
PAUSE
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  We are now attempting to connect to the %acname%. 
ECHO.
ECHO ------------------------------------------------------------------------------
TIMEOUT 2>nul
cd adb
adb shell REM lets test before remounting
adb exit
adb shell mount -o remount,rw /vendor
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Mounted the drive 
ECHO.
ECHO ------------------------------------------------------------------------------
TIMEOUT 2 >nul
adb shell mkdir /vendor/bin
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Made the directory 
ECHO.
ECHO ------------------------------------------------------------------------------
TIMEOUT 2 >nul
adb push %filename2% /vendor/bin/
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Copied the file 
ECHO.
ECHO ------------------------------------------------------------------------------
TIMEOUT 2 >nul
adb shell cd /vendor/bin/
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Moved to the folder
ECHO.
ECHO ------------------------------------------------------------------------------
TIMEOUT 2 >nul
adb shell /sbin/dji_verify -n 0306 -o %filename2%
REM this works for 1.03.0100+, change to /system/bin for lower version on M1P
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Verified firmware file
ECHO.
ECHO ------------------------------------------------------------------------------
TIMEOUT 2 >nul
adb pull /vendor/bin/0306.unsig
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Copied unsigned file
ECHO.
ECHO ------------------------------------------------------------------------------
TIMEOUT 2 >nul
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  Cleaning up ...
ECHO.
ECHO ------------------------------------------------------------------------------
TIMEOUT 2 >nul
ECHO OFF
adb shell cd /vendor/bin/
adb shell rm 0306.unsig
adb shell rm *.fw.sig
adb shell cd /
adb shell sync
adb shell mount -o remount,ro /vendor
TIMEOUT 2 >nul
GOTO DECFC
:DECFC
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  We will run the DJI Flight Controller Firmware Decryptor tool (credit o-gs)
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO.
pause
copy 0306.unsig ..
REM ADD BACK LATER WHEN REAL TEST **** del 0306.unsig
cd ..
copy 0306.unsig tools
del 0306.unsig
cd tools
python dji_mvfc_fwpak.py dec -i 0306.unsig
del dji_mvfc_fwpak.py
del 0306.unsig
ren 0306.decrypted.bin %filename2%
ren *pro.fw.sig *.
ren *pro.fw *.fw_0306_decrypted.bin
GOTO DECFC1
:DECFC1
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  We will now extract the flight controller contents using dji_flyc_param_ed.py
ECHO  credits to mefistotelis
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO.
ECHO OFF
SET index=1
SETLOCAL ENABLEDELAYEDEXPANSION
FOR %%f IN (*decrypted.BIN) DO (
   SET file!index!=%%f
   ECHO   !index! - %%f
   SET /A index=!index!+1
)
SETLOCAL DISABLEDELAYEDEXPANSION
ECHO.
SET /P selection="Select the proper decrypted 306 file: "
SET file%selection% >nul 2>&1
IF ERRORLEVEL 1 (
   ECHO.
   ECHO Invalid number selected
   TIMEOUT 2   
   GOTO MAIN
)
CALL :RESOLVE4 %%file%selection%%%
ECHO Selected file name: %filename4%
python dji_flyc_param_ed.py -vv -x -b 0x420000 -m %filename4%
del dji_flyc_param_ed.py
copy flyc_param_infos flyc_param_infos_stock_%acname%_%acversion%
GOTO PARAMSFILE
:PARAMSFILE
CLS
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO ------------------------------------------------------------------------------
ECHO. 
ECHO  We have extracted the flight controller file into a text file flyc_param_infos
ECHO.
ECHO  This file is located in the tools folder. We will open it using notepad. Make 
ECHO  your edits and save. After saving, tool will continue, press any key. 
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO.
PAUSE
notepad.exe flyc_param_infos
copy flyc_param_infos flyc_param_infos_modded_%acname%_%acversion%
ECHO TOOW
PAUSE
:EOF
EXIT