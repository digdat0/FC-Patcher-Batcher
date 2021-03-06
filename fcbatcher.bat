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
SET BUILDVERSION=03.02.45.10
REM change build version + versions when new builds to update
SET SNUM=23
@ECHO OFF
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 			
ECHO -------------------------------------------------------------------------------------
ECHO  The tool will assist in the FC Patcher process. The FC patcher "process"
ECHO  was made by the OG's to help the community modify flight controller 
ECHO  parameters on the newer versions of firmware for DJI Mavic Pro,  Mavic 
ECHO  Platinum (no sd card needed), Phantom 4 Std, Phanton 4 Pro, Phantom 4 
ECHO  Advanced, Inspire 2 and Spark.
ECHO. 
ECHO  The process isn't quick or easy. Lots of hard work was done to enable this.
ECHO  Much respect to Matioupi, mefistotelis, fvantienen and the other og's.
ECHO.
ECHO. At a high level, we will root, extract the firmware, decrypt it, copy it to the
ECHO  aircraft, use the aircraft to fake a signature, decrypt the file, then 
ECHO  extract the flight controller and then you can modify it. Once that is done,
ECHO  we will recompile it and then you can use dumldore to install on the aircraft.
ECHO. 
ECHO  Press the any key to proceed.
ECHO. 
ECHO -------------------------------------------------------------------------------------
PAUSE
GOTO GOTROOT
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
:GOTROOT
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  				Step 1/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  You need root / adb access. Do ya got it? If no, go run dumlracer
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
SET /P M=Well, do ya got that root? Y/N: 
IF %M%==Y GOTO MAINM
IF %M%==y GOTO MAINM
IF %M%==N GOTO MAIN1
IF %M%==n GOTO MAIN1
IF %M%==x GOTO EOF
IF %M%==X GOTO EOF
:MAIN1
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  				Step /%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Do you want to run dumlracer and root your device? Say no if you have already rooted.
ECHO.
ECHO. If you dont know what this means, this tool may not be for you.
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
SET /P M=Do you want to root your device? Y/N/X: 
IF %M%==Y GOTO REWT
IF %M%==y GOTO REWT
IF %M%==N GOTO MAIN2
IF %M%==n GOTO MAIN2
IF %M%==x GOTO EOF
IF %M%==X GOTO EOF
:REWT
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading dumlracer
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "dumlracer.jar" (
GOTO DLDR
) ELSE (
ECHO.
ECHO Downloading dumlracer tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/CunningLogic/DUMLRacer/releases/download/v1.1.1/DUMLRacer.jar dumlracer.jar
)
TIMEOUT 2 >nul
GOTO REWTN
:REWTN
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will run dumlracer to try and root (credits to jcase)
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
PAUSE
cd tools
java -jar dumlracer.jar AC
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We are hopeful that you won both races, but arent too tired. If you lost the
ECHO  race(s), please quit the tool, power off aircraft and back on and try again.
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
pause
GOTO MAINM
:MAINM
SET APPVER=1.0
SET ORIGDATE=April 18, 2019
SET SAVEDATE=%DATE%
@ECHO OFF
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  				Step 2/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Select the firmawre you want to modify. Please make sure the .bin file
ECHO  is in the same folder as this batch file.
ECHO.
ECHO -------------------------------------------------------------------------------------------
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
   GOTO MAINM
)
CALL :RESOLVE %%file%selection%%%
ECHO Selected file name: %filename%
copy %filename% tools
GOTO MAIN2
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
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  				Step 3/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  You have selected the following firmware, please confirm.
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
ECHO   Firmware Filename    : %filename%
ECHO   Aircraft Type        : %acname%
ECHO   Firmware Version     : %acversion%
ECHO.
ECHO   Testing Options: (E, D, A, P, Q, S, I, O)
ECHO   (E)xtractBin, (D)umldoreDL, (A)db1ststep, (P)aramsEdit, patch_se(Q)uence, 
ECHO   (S)etpath, (I)nstalldummy, d(O)wnload, repatch(F)c, (H)ardcode
ECHO.
SET /P M=Is this information right? Y/N: 
IF %M%==Y GOTO MAIN3
IF %M%==y GOTO MAIN3
IF %M%==N GOTO MAIN
IF %M%==n GOTO MAIN
IF %M%==F GOTO patfc
IF %M%==f GOTO patfc
IF %M%==H GOTO HARDCODE
IF %M%==h GOTO HARDCODE
IF %M%==x GOTO EOF
IF %M%==X GOTO EOF
IF %M%==e GOTO EXTRACTBIN
IF %M%==E GOTO EXTRACTBIN
IF %M%==d GOTO DLDD REM DUMLORE JUMP TO
IF %M%==D GOTO DLDD 
IF %M%==a GOTO ADB1 
IF %M%==A GOTO ADB1
IF %M%==p GOTO PARAMSFILE 
IF %M%==P GOTO PARAMSFILE
IF %M%==Q GOTO SEQ REM FC_patch_sequence_for_dummy_verify.sh
IF %M%==q GOTO SEQ
IF %M%==s GOTO PATH 
IF %M%==S GOTO PATH
IF %M%==O GOTO DLDQ 
IF %M%==o GOTO DLDQ
IF %M%==i GOTO ADBINSTALLDUMMY  
IF %M%==I GOTO ADBINSTALLDUMMY
:MAIN3
@ECHO OFF
python --version 2>NUL
if errorlevel 1 goto NOPY
GOTO DL1
:NOPY
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  				Step 4/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  You don't have Python installed. Goto python.org and download python
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
EXIT
:DL1
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  				Step 4a/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading image.py ..
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "tools\image.py" (
GOTO DL2
) ELSE (
ECHO.
ECHO Downloading image.py tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/fvantienen/dji_rev/raw/master/tools/image.py image.py
)
GOTO DL2
:DL2
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER% 	 				Step 4b/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading dji_mvfc_fwpak.py ..
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "tools\dji_mvfc_fwpak.py" (
GOTO DL3
) ELSE (
ECHO.
ECHO Downloading dji_mvfc_fwpak.py tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/o-gs/dji-firmware-tools/raw/master/dji_mvfc_fwpak.py dji_mvfc_fwpak.py
)
GOTO DL3
:DL3
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 				Step 4c/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading dji_flyc_param_ed.py ..
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "tools\dji_flyc_param_ed.py" (
GOTO DL4
) ELSE (
ECHO.
ECHO Downloading dji_flyc_param_ed.py tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/o-gs/dji-firmware-tools/raw/master/dji_flyc_param_ed.py dji_flyc_param_ed.py
)
GOTO DL5 
REM SKIPPING .sh below to have custom one
:DL4
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 				Step 4d/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading FC_patch_sequence_for_dummy_verify.sh ..
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "tools\FC_patch_sequence_for_dummy_verify.sh" (
GOTO DL5
) ELSE (
ECHO.
ECHO Downloading FC_patch_sequence_for_dummy_verify.sh tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/o-gs/DJI_FC_Patcher/raw/master/FC_patch_sequence_for_dummy_verify.sh FC_patch_sequence_for_dummy_verify.sh
)
GOTO DL5
:DL5
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 				Step 4e/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading patcher.py ..
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "tools\patcher.py" (
GOTO DL6
) ELSE (
ECHO.
ECHO Downloading patcher.py tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/o-gs/DJI_FC_Patcher/raw/master/patcher.py patcher.py
)
GOTO DL6
:DL6
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 				Step 4f/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading patch_wm220_0306.py .. right now this is for Mavic only
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "tools\patch_wm220_0306.py" (
GOTO DL7
) ELSE (
ECHO.
ECHO Downloading patch_wm220_0306.py tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/o-gs/DJI_FC_Patcher/blob/master/patch_wm220_0306.py patch_wm220_0306.py
)
GOTO DL7
:DL7
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 				Step 4g/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading dummy_verify.sh .. 
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "tools\dummy_verify.sh" (
GOTO DL8
) ELSE (
ECHO.
ECHO Downloading dummy_verify.sh tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/o-gs/DJI_FC_Patcher/raw/master/dummy_verify.sh dummy_verify.sh
)
GOTO DL8
:DL8
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 				Step 4h/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading DUMLdoreV3 .. 
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "dumldore3.exe" (
GOTO DL9
) ELSE (
ECHO.
ECHO Downloading DUMLdoreV3.zip tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/jezzab/DUMLdore/releases/download/v3.20/DUMLdoreV3.zip DUMLdoreV3.zip
)
GOTO DL9
:DL9
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 				Step 4i/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading UBXCFGGEN.py .. 
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "UBXCFGGEN.py" (
GOTO EXTRACTBIN
) ELSE (
ECHO.
ECHO Downloading UBXCFGGEN.py tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/o-gs/DJI_FC_Patcher/raw/master/UBXCFGGEN.py UBXCFGGEN.py
)
GOTO EXTRACTBIN
:EXTRACTBIN
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 				Step 5/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will now do some work to extract the firmware files (cfg, 305 and 306). 
ECHO.
ECHO  We will then decrypt the cfg file and move things where we need to put back 
ECHO  together. 
ECHO.
ECHO -------------------------------------------------------------------------------------------
PAUSE
@echo off
REM md final
copy %filename% tools
copy 7z.exe tools
copy image.py tools
copy dummy_verify.sh tools
copy FC_patch_sequence_for_dummy_verify.sh tools
cd tools
md fwextract
7z.exe x %filename%
copy *305*.* fwextract
copy dji_flyc_param_ed.py fwextract
copy dji_mvfc_fwpak.py fwextract
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
@echo off
copy *305*.* 305
copy *306*.* 306
cd 305
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 			Step 6/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We found the following 305 module files. Please select the one to use.
ECHO.
ECHO -------------------------------------------------------------------------------------------
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
   GOTO 305MOD
)
CALL :RESOLVE1 %%file%selection%%%
ECHO Selected file name: %filename1%
copy %filename1% ..
cd ..
del *305*.*
TIMEOUT 2 >nul
GOTO M306
:M306
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 			Step 7/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We found the following 306 module files. Please select the one to use.
ECHO.
ECHO -------------------------------------------------------------------------------------------
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
   GOTO M306
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
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 			Step 8/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will now copy the CFG file and decrypt with image.py (credits: fvantienen) 
ECHO.
ECHO -------------------------------------------------------------------------------------------
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
   GOTO MCFGN
)
CALL :RESOLVE3 %%file%selection%%%
ECHO Selected file name: %filename3%
copy w*.cfg.sig cfgn
copy image.py cfgn
del image.py
REM del w*.sig
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
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 			Step 9/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We are attempting to decrypt the cfg file.
ECHO.
ECHO -------------------------------------------------------------------------------------------
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
ren *pro.fw.sig *.
ren *pro.fw *.
ren *pro *.
REM renaming to remove the extension, allows setting %%~D otherwie it appends and i cant get date for future use
for /f "tokens=1-4* delims=_" %%A in ('dir /b /a-d "%filename1%"') do (
  set filenamespec=%%~A_%%~B_%%~C_%%~D
  set acmodel=%%~A
  set acmodule1=%%~B
  set acversion305=%%~C
  set miscfiledate=%%~D
)
ren *_*_*.*.*.*_* *_*.pro.fw.sig
copy *.sig ..
del *.sig
cd ..
GOTO 306FOLDERS
:306FOLDERS
cd 306
ren *pro.fw.sig *.
ren *pro.fw *.
ren *pro *.
for /f "tokens=1-4* delims=_" %%A in ('dir /b /a-d "%filename2%"') do (
  set filenamespec=%%~A_%%~B_%%~C_%%~D
  set acmodel2=%%~A
  set acmodule2=%%~B
  set acversion306=%%~C
  set miscfiledate2=%%~D
)
ren *_*_*.*.*.*_* *_*.pro.fw.sig
copy *.sig ..
del *.sig
GOTO MOVEIT
:MOVEIT
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
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 			Step 10/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Now we will need to connect to the aircraft. Plug it in via USB and power on.
ECHO.
ECHO  After plugging in, wait about 30 seconds for the computer to recognize it. DO
ECHO  not close this window. Do not power off the %acname%
ECHO.
ECHO. 
ECHO. After about 30-60 seconds, press the any key to continue.
ECHO.
ECHO -------------------------------------------------------------------------------------------
PAUSE
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%  	 			Step 10a/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  ADB in the house ... We are now attempting to connect to the %acname%. 
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2>nul
cd adb
adb shell REM lets test before remounting
adb exit
adb root
adb shell mount -o remount,rw /vendor
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 10b/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  ADB in the house ... Mounted the drive 
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
adb shell mkdir /vendor/bin
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 10c/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  ADB in the house ... Made the directory 
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
adb push %filename2% /vendor/bin/
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 10d/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  ADB in the house ... Copied the file 
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
adb root
adb shell cd /vendor/bin/
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 10e/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  ADB in the house ... Moved to the folder
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
adb shell /sbin/dji_verify -n 0306 -o %filename2%
REM this works for 1.03.0100+, change to /system/bin for lower version on M1P
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 10f/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  ADB in the house ... Verified firmware file
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
adb pull /vendor/bin/0306.unsig
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 10g/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  ADB in the house ... Copied unsigned file
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 10h/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  ADB in the house ... Cleaning up ...
ECHO.
ECHO -------------------------------------------------------------------------------------------
TIMEOUT 2 >nul
ECHO OFF
adb root
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
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 11/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will run the DJI Flight Controller Firmware Decryptor tool (credit o-gs)
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
pause
@ECHO OFF
copy 0306.unsig ..
REM ADD BACK LATER  
REM del 0306.unsig
cd ..
copy 0306.unsig tools
del 0306.unsig
cd tools
python dji_mvfc_fwpak.py dec -i 0306.unsig
del dji_mvfc_fwpak.py
del 0306.unsig
ren 0306.decrypted.bin %filename2%
ren *pro.fw.sig *.
ren *pro.fw *.fw_0306.decrypted.bin
copy *.fw_0306.decrypted.bin fwextract
GOTO DECFC1
:DECFC1
@ECHO OFF
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 12/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will now extract the flight controller contents using dji_flyc_param_ed.py
ECHO  credits to mefistotelis
ECHO.
ECHO -------------------------------------------------------------------------------------------
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
   GOTO DECFC1
)
CALL :RESOLVE4 %%file%selection%%%
ECHO Selected file name: %filename4%
python dji_flyc_param_ed.py -vv -x -b 0x420000 -m %filename4%
copy %filename4% fwextract
copy flyc_param_infos flyc_param_infos_stock_%acname%_%acversion%
cd ..
copy python.exe tools
cd tools
copy python.exe fwextract
del python.exe
GOTO PARAMSFILE
:PARAMSFILE
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 13/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We have extracted the flight controller file into a text file flyc_param_infos
ECHO.
ECHO  This file is located in the tools folder. We will open it using notepad. Make 
ECHO  your edits and save. After saving, tool will continue, press any key. 
ECHO.
ECHO  For information on parameters, visit the wiki at http://dji.retroroms.info/howto/
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
PAUSE
@ECHO OFF
notepad.exe flyc_param_infos
copy flyc_param_infos flyc_param_infos_modded_%acname%_%acversion%
move flyc_param_infos_modded_%acname%_%acversion% ..
del flyc_param_infos_modded_%acname%_%acversion%
copy flyc_param_infos fwextract
copy %filename1% fwextract
del flyc_param_infos
cd ..
copy sh.exe tools
copy tar.exe tools
copy patcher.py tools
copy dji_flyc_param_ed.py tools
java -jar download.jar https://github.com/o-gs/DJI_FC_Patcher/raw/master/patch_wm220_0306.py patch_wm220_0306.py
cd tools
copy tar.exe fwextract
copy sh.exe fwextract
copy UBXCFGGEN.py fwextract
copy dji_flyc_param_ed.py fwextract
copy patcher.py fwextract
copy patch_wm220_0306.py fwextract
copy sh.exe fwextract
copy patcher.py fwextract
copy FC_patch_sequence_for_dummy_verify.sh fwextract
cd fwextract
REM moving some commands over from the .sh file, it driving me nutts
GOTO PATFC
:PATFC
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 15/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will now patch the flight controller 306 module
ECHO.
ECHO -------------------------------------------------------------------------------------------
PAUSE
@ECHO OFF
python dji_flyc_param_ed.py -vv -u -b 0x420000 -m %filename4%
GOTO HARDCODE
:HARDCODE
@echo off
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 15a/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We will now patch the hard coded values using patch_%acmodel3%_0306.py
ECHO.
ECHO -------------------------------------------------------------------------------------------
PAUSE
md patch
copy %filename4% patch
copy *.fw_0306.decrypted.bin patch
copy %filename1% patch
copy python.exe patch
copy flyc_param_infos patch
copy patcher.py patch
copy %acmodel3%.cfg.ori patch
copy UBXCFGGEN.py patch
copy patch_%acmodel3%_0306.py patch
cd patch
python patch_%acmodel3%_0306.py %filename4% %BUILDVERSION%
move %filename4% %filename4%_old
move *.patched %filename2%
copy %filename2% ..
cd ..
FC_patch_sequence_for_dummy_verify.sh Mavic %BUILDVERSION%
REM FC_patch_sequence_for_dummy_verify.sh %acmodel% %BUILDVERSION%
REM add logic to pull Mavic name from wm220 or other models once more supported
copy *_dummy_verify.bin ..
cd ..
copy *_dummy_verify.bin ..
GOTO STATUS
:STATUS
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 15b/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  You now have a custom firmware which can be used to flash your aicraft. 
ECHO  In the same folder as the fcbatcher.bat file was found will be a new file named
ECHO  dji_system_%acmodel3%_0306_v%BUILDVERSION%_dummy_verify.bin
ECHO.  
ECHO  When you get to flashing, use dji_system_%acmodel3%_0306_v%BUILDVERSION%_dummy_verify.bin
ECHO. 
ECHO.
ECHO -------------------------------------------------------------------------------------------
PAUSE
GOTO ADBINSTALLDUMMY
:ADBINSTALLDUMMY
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 16/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  This step will install the dummy_verify.sh file on the aircraft. This will 
ECHO  allow you to install your customized firmware.
ECHO.
ECHO  Now we need to connect to the aircraft. Plug it in via USB and power on (if
ECHO  the aircraft isnt already on).
ECHO.
ECHO  After plugging in, wait about 30 seconds for the computer to recognize it. DO
ECHO  not close this window. Do not power off the %acname%
ECHO. 
ECHO. After about 30-60 seconds, press the any key to continue.
ECHO.
ECHO -------------------------------------------------------------------------------------------
PAUSE
echo off
cd adb
adb devices REM lets test before remounting
adb root
adb shell mount -o remount,rw /vendor
adb push dummy_verify.sh /vendor/bin/
adb root
adb shell cd /vendor/bin/
adb shell chown root:root dummy_verify.sh
adb shell chmod 755 dummy_verify.sh
adb shell cp /sbin/dji_verify /vendor/bin/original_dji_verify_copy REM /sbin for 1.03.0100+, /system/bin for earlier on m1p
adb shell sync
adb shell mount -o remount,ro /vendor
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 17/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  We are pretty sure we managed to copy the right stuff to the %acname%
ECHO.
ECHO  Please keep the aircraft on. Leave the USB plugged in.
ECHO. 
ECHO  This step will initiate the dummy verify to allow flashing.
ECHO.
ECHO -------------------------------------------------------------------------------------------
PAUSE
adb root
adb shell mount -o bind /vendor/bin/dummy_verify.sh /sbin/dji_verify
cd ..
GOTO DDLL
:DDLL
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 18/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  If you've gotten here, you've done pretty good. You've done all the steps
ECHO. properly and have flashable firmware file. You can now continue with flashing
ECHO  your %acname% with the .bin file we created. You can use dumldore or dumlflasher
ECHO  to accomplish the flashing process.
ECHO.
ECHO -------------------------------------------------------------------------------------------
GOTO CLEAN
:CLEAN
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 18b/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Cleaning up a bit ...
ECHO.
ECHO -------------------------------------------------------------------------------------------
cd tools
cd fwextract
cd 306
del *.py
cd ..
rd 306
cd patch
del *.sig
del p*.*
del U*.*
del *.bin
cd ..
rd patch
del *.py
del *.exe
del *.sh
del *.sig
del *.ori
del *.cfg
del *.bin
del flyc_param_infos
cd ..
rd fwextract
cd unzip
del *.exe
cd ..
del adb*
del *.py
del *.exe
del *.sh
del *.sig
del *.ori
del *.cfg
del *.bin
cd ..
rd tools
GOTO DLDQ
:DLDQ
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 19/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Do you want to run dumldore v3 to flash your device? 
ECHO.
ECHO. You will need to navigate to the location of the file in tools.
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO.
SET /P M=Do you want to run dumldore to flash? Y/N: 
IF %M%==Y GOTO DLDD
IF %M%==y GOTO DLDD
IF %M%==N GOTO CREDITS
IF %M%==n GOTO CREDITS
IF %M%==x GOTO EOF
IF %M%==X GOTO EOF
:DLDD
cd tools
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 20/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Downloading dumldore3
ECHO.
ECHO -------------------------------------------------------------------------------------------
IF EXIST "dumldore3.zip" (
GOTO DLDR
) ELSE (
ECHO.
ECHO Downloading DUMLdoreV3.zip tool, please wait .. 
ECHO.
java -jar download.jar https://github.com/jezzab/DUMLdore/releases/download/v3.20/DUMLdoreV3.zip DUMLdoreV3.zip
)
TIMEOUT 2 >nul
GOTO DLDR
:DLDR
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 21/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Extracting files and running dumldore tool
ECHO.
ECHO -------------------------------------------------------------------------------------------
cd ..
copy 7z.exe tools
cd tools
7z.exe x DUMLdoreV3.zip
start dumldorev3.exe
TIMEOUT 2 >nul
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 22/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  The dumldore tool should have opened. Chose to load firmware, navigate to
ECHO  the file and press flash firmware. 
ECHO.
ECHO -------------------------------------------------------------------------------------------
pause
GOTO CREDITS
:CREDITS
CLS
ECHO.
ECHO -------------------------------------------------------------------------------------------
ECHO  FC Patcher Batcher -- Firmware Mod Tool %APPVER%   	 			Step 23/%SNUM%
ECHO -------------------------------------------------------------------------------------------
ECHO. 
ECHO  Credits .. alot of smart folk put in alot of work. I want to give kudos to 
ECHO  all the OG's, Matioupi, mefistotelis, fvantienen and anyone else involved 
ECHO  with making the toolset or associated tools. Here's to the community.
ECHO                             respect -- digdat0
ECHO.
ECHO -------------------------------------------------------------------------------------------
pause
GOTO EOF
:EOF
EXIT