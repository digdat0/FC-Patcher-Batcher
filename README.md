FC Patcher Batcher                                                                              
                                                                                   
This tool is intended to help automate using the FC Patcher toolset. You can find that here:
https://github.com/o-gs/DJI_FC_Patcher

Credits to all the OG's, Matioupi, mefistotelis, fvantienen, jcase, jezzab, jan and anyone else involved 
with making the toolset or associated tools. Here's to the community.

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
Have root access (run dumlracer or dumldore get adb) 
  https://github.com/CunningLogic/DUMLRacer
  https://github.com/jezzab/DUMLdore




04/22/2019 - KNOWN ISSUES
--------------------------------------------------------------
- it works up to patch_wm220_0306.py, working on it
- Delete the 'tools' folder between runs
- some filecopy/deletes not working
- ALL adb untested!!!!!!!! its theoretical
- root flow causing issues with 305/306 not showing up, removed for now
- only m1p support
