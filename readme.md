
# DU Linux Printer Installation Guide
----
# Quick and Easy Mode
_note: These instructions were tested on Arch Linux_
1. Download and install **CUPS** using your package manager
2. Download and install **ghostscript**, again using your package manager
3. Enable the CUPS service (command for systemd users): 
```bash
sudo systemctl enable org.cups.cupsd.service`
sudo systemctl start org.cups.cupsd.service`
```
4. Update your permissions (this step assumes your username is part of the usergroup 'wheel'):
```bash
sudo sed -i '/SystemGroup sys root$/ s/$/ wheel/' /etc/cups/cups-files.conf
sudo systemctl restart org.cups.cupsd.service
```
5. Open a browser to http://localhost:631/
6. Under CUPS for Administrators, Click **Adding Printers and Classes**
7. Click add Printer
    1. Select LPD
    2. Enter the address: `lpd://YOUR_ID_NUMBER@uniprint.cair.du.edu/p-dunet4525`
    3. Enter whatever you want for this step, it doesn't matter
    4. Select HP and click continue
    5. Select **HP LaserJet Series PCL 6 CUPS**
    6. Select **Add Printer** at the bottom of the page.
8. Repeat the above with the address`lpd://YOUR_ID_NUMBER@uniprint.cair.du.edu/p-dunetm6xx`. Make sure to select **HP DesignJet 600, pcl**.



If you are having issues please email Paul.Heinen@du.edu and Dan.Cruwys@du.edu.

## Debian/Ubuntu Distro Quick Install
----

**Make Sure to Read *Some Things To Note* Below after you set the printers up. There are instructions on how to properly use the software there and avoid running into issues with printing.**

A bash script was made to make the printer installation process *hopefully* painless on any Debian Based Distro, which basically means if you use the apt-get install command to install packages, then this script should hopefully work.

**Instructions:**

* Either clone this repository or click 'Download Zip' on the right-side of github.
* Navigate to the location where you downloaded it and unzip the DULinuxPrinters.
* Be sure to compile the binary using chmod.
* Here's an example on how to do this with command line.
---
    [user@someDebDistro ~]: sudo apt-get install zip -y
    [user@someDebDistro ~]: unzip ~/Downloads/DULinuxPrinters.zip -d ~/Documents && cd ~/Documents/DULinuxPrinters
    [user@someDebDistro ~]: chmod u+x ./UbuntuInstallScript.sh
    [user@someDebDistro ~]: sudo ./UbuntuInstallScript.sh
---
* Now, simply Logout and Log back in. 

**If this script doesn't work please submit an issue, or let Paul or Nathan know. You can also attempt to follow the install instructions below.**

**For Non-Debian Based Users: ** The UbuntuInstallScript.sh can serve as a template. All you would likely have to change is the package manager's name, i.e. change **sudo apt-get install** to **sudo pacman -S** or **sudo yum install** for example.

## Basics
-----

**You need to have the following installed:**

* **python 2.7** 
  * To check open a terminal and type: **ls /usr/bin | grep python**
  * If python3.whatever is installed you will need to use **python2** wherever python is listed

* **PIP**

  * **Note:** PIP is not needed if you can install WxPython through your package manager.
  * Again to check if installed type: ls /usr/bin | grep pip
  * Make sure that you have pip2 or pip2.7
    *  **Note: ** If you have pip installed for python3.xx, make sure to to type **pip2** or whatever wherever the use of pip is specified. 

* **WxPython** - To check if installed go to a terminal, type **python** and type **import wx**

  * If it's not installed, and you have pip properly setup type **pip install WxPython**
* **CUPS** - Most distros should have this pre-installed. To check open a browser and go to http://localhost:631. If you have any issues the [Arch Wiki article on CUPS](https://wiki.archlinux.org/index.php/CUPS) is probably the best resource.
  * You only need the **libcups** package, which is the client package

* **hplip** - These are the Linux HP drivers
* **zip** - Needed for unzipping the .zip file

Here's an exact list of packages you need before installing the hplip package, as per [HP's official linux page](http://hplipopensource.com/hplip-web/install/manual/index.html).

    avahi-utils libcups2 cups libcups2-dev cups-bsd cups-client libcupsimage2-dev libdbus-1-dev build-essential ghostscript openssl libjpeg-dev libsnmp-dev libtool libusb-1.0.0-dev wget python-imaging policykit-1 policykit-1-gnome gtk2-engines-pixbuf python-qt4 python-qt4-dbus python-dbus python-gobject python-dev python-notify2 python python-reportlab libsane libsane-dev sane-utils xsane

## Installation 
----
Included is basically everything you need, as long as you have the basics set up properly.

  1. Unzip DULinuxPrinters.zip to your home directory or Documents directory

  2. Open a terminal shell and cd into the directory you unzipped into. Type after to check if you're in the right directory
 
  3. type **sudo python setup.py**

---    
    unzip ~/Downloads/DULinuxPrinters.zip -d ~/Documents && cd ~/Documents/DULinuxPrinters
    sudo python setup.py
    
  Hopefully everything went smoothly on this step. Try printing a test file, you may notice that you don't get a dialog box for print options and only the Pharos Popup appears, a script will be made to give you more print control options in the near future. Make sure you enter your student id then check to see if your document printed, student IDs are still required to print at a DU printing station.

If you encounter any issues you can't figure out how to fix, please submit the issue to the [github page](https://github.com/v3nturetheworld/DULinuxPrinting).

## Some things to Note
----  
Print options are kind of weird a program specific. For example, when you click Print in XFCE's document viewer it just prints to whatever printer was last used and gives no printing options. Other programs like Adobe Acrobat Reader give a ton of options for printing, and for programs with dialogue boxes like this you should be able to print in whatever way you need. 

* **While not thoroughly tested, the software might not work if your not connected to PioneerNet. If enough people don't have PioneerNet setup on Linux I'll add a section on how to configure it. **

* If you are connected to a VPN that doesn't have an end node connected to the schools internet, then printing won't work.

### Accidental Printing

Because multi-queue printing seems to work poorly, to cancel prints you have to do the following.

  1. Open a browser and go to http://localhost:631

  2. Navigate to **Jobs** at the top
     * **Note: ** If Jobs is empty, then the print job was already sent to the printer. If you didn't want to print a document or accidentally printed a bunch of documents they will time out eventually. **Check the cost of the print job before you print it!!!!**

  3. Click cancel job. There might be a Pharos popup (the same one you see when you print), ignore it (I don't know what happens if you click OK).
  4. It will pop open a window asking you to login. Your root account info should work, you may choose to setup permissions to allow your user account. This varies by Distro though.

  If you have problems, please talk to Paul or Nathan or submit an issue to the GitHub page. If you know python and want to help, feel free to try and get some more features working with the printers. 

  Also a TON of credit goes to the guy who wrote the original reverse engineered Pharos python script. If you need any more help checkout his [GitHub](https://github.com/junaidali/pharos-linux).
