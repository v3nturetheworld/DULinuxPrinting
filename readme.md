#DU Linux Printer Installation Guide#

**NOTE: Colored Printing has not been figured out yet**

##Basics##

**You need to have the following installed**

*python 2.7 
  *To check open a terminal and type: ls /usr/bin | grep python
  *If python3.whatever is installed you will need to use **python2** wherever python is listed
*PIP
  *Again to check if installed type: ls /usr/bin | grep pip
  *Make sure that you have pip2 or pip2.7
*WxPython - To check if installed go to a terminal, type **python** and type **import wx**
  *If it's not installed, and you have pip installed type **pip install wx**
*CUPS - Most systems should have this installed. To check open a browser and go to http://localhost:631
  *You only need the **libcups** package, which is the client package
*hplip - These are the linux hp drivers

**Some reccomended things**

I'm honostly not positive if these are required but they are worth installing anyway

  *ghostscript
  *gsfonts

##Installation 

Included is basically everything you need, as long as you have the basics set up properly.
	1. Unzip DULinuxPrinters.zip to your home directory or Documents directory
	2. Open a terminal shell and cd into the directory you unzipped into. Type after to check if you're in the right directory
	3. type **python setup.py**

Alright, assuming everything went well, you should now be able to print. Try test printing a file, obviously things won't be 100% perfect but at least printing works. 

##Some things to Note##
  
  Currently, double sided printing hasn't been figured out, and you can't print multiple things at once.

  ##Accidental Printing##
    Because multi-queue printing seems to work poorly, to cancel prints you have to do the following.
       1. Open a browser and go to http://localhost:631
       2. Navigate to **Jobs** at the top
       3. Click cancel job. There will be a pharos popup, ignore it (I dont know what happens if you click OK).
       4. It will pop open a window asking you to login. Your root account info should work, you may choose to setup permissions to allow your user account. This varies by Distro though.

  If you have problems, UTS will probably be worthless. It took a lot of work to get the info required that could easily have just been given out. Please talk to Paul or Nathan for help with any issues. 

  Currently this process has been tested on Arch Linux and Ubuntu.
  Also shoutout to the guy who wrote the original reverse engineered Pharos python script. If you need any more help checkout his github here: https://github.com/junaidali/pharos-linux

