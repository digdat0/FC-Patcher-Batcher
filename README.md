FC Patcher Batcher                                                                              
                                                                                   
This tool is intended to help automate using the FC Patcher toolset. You can find that here:
https://github.com/o-gs/DJI_FC_Patcher

Credits to all the OG's, Matioupi, mefistotelis, fvantienen, jcase, jezzab, jan and anyone else involved 
with making the toolset or associated tools. Here's to the community.

Copy fw file to folder, copy all the files in the repo. Run batch file, follow commands. Then when done, flash with dumldore3.

For info on parameters: http://dji.retroroms.info/howto/start

04/22/2019 - KNOWN ISSUES


^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
- it works up to running the FC_patch_sequence_for_dummy_verify.sh Mavic 03.02.44.99 function and errors on py
anything after that is untested
- need to delete tools folder between runs, doeasnt like it. need cleanup
- some filecopy/deletes not working
- ALL adb untested!!!!!!!! its theoretical
- root flow causing issues with 305/306 not showing up, removed for now
- only m1p support
