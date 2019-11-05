FC Patcher Batcher                                                                              
                                       
This is a wrapper batch file which uses tools other developrs made. My intention is to make this easier; All credit to all the OG's, Matioupi, mefistotelis, fvantienen, jcase, jezzab, jan and anyone else involved. Please review the source and please give all credit and or donations to the folk who created the tools. 

https://github.com/o-gs/DJI_FC_Patcher

https://github.com/o-gs/dji-firmware-tools                                       
                                       
--------------------------------------------

Copy fw file to folder, copy all the files in the repo. Run batch file, follow commands. Then when done, flash with dumldore3.

For info on parameters: http://dji.retroroms.info/howto/start


--------------------------------------------------------------
Things / Tools Required to Run
--------------------------------------------------------------
Pyton2 https://www.python.org/downloads/release/python-2716/

Python 3 https://www.python.org/ftp/python/3.7.3/python-3.7.3.exe

Install Pcrypto+ConfigParser via PIP at command line:
  - python -m pip install pycryptodome
  - python -m pip install configparser

JRE/JDK https://www.oracle.com/technetwork/java/javase/downloads/index.html

7zip installed https://www.7-zip.org/download.html

Have root access (run dumlracer or dumldore enable adb) 
  https://github.com/CunningLogic/DUMLRacer
  https://github.com/jezzab/DUMLdore



06/22/2019 - KNOWN ISSUES
--------------------------------------------------------------
- Delete the 'tools' folder between runs
- some filecopy/deletes not working but doesnt affect outcome
- ALL adb tested except dji_Verify steps
- only mavic 1 support
