# GTFO-from-LinEnum
The purpose of this script is to check for the existence of GTFOBins for any of the SUID/SGID binaries found in a LinEnum.sh (by @rebootuser) output file

# HOW TO USE
Step 1: Run LinEnum.sh and save to an output file
**./LinEnum.sh > output.txt**

Step2: Run this script against the output file
**chmod +x checkGTFO.sh**
**./checkGTFO.sh /path/to/output.txt**

![Desktop 2024 03 21 - 13 46 09 02 (2)](https://github.com/paulpierce34/GTFO-from-LinEnum/assets/33561650/da2c5c98-2d90-4039-8ace-20ff4740f35f)
