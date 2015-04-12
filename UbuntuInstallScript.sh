#!/bin/bash
#DU Printers Install tool
#Written by Paul Heinen

wget=/usr/bin/wget
tar=/bin/tar
#Store the location of this script
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PyInstall=false

echo "DU Printer Installation Tool for Debian Based Linux (Yes that includes any form of Ubuntu)."
echo "Please note that this script hasn't been thoroughly tested. Hopefully it just works."

if [ $EUID -ne 0 ]; then
	echo "You to be root to run this script"
else
	read -p "Script ran as root. Do you want to continue with the installation? (y/n) " RESP
	if [ "$RESP" = "y" ]; then 
  #User said yes. Install code begin.
  		echo "Updating Packages"
  		sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu trusty-security main" 
		sudo apt-get update
		echo "Checking Python Version"
		ret=`python -c 'import sys; print("%i" % (sys.hexversion<0x03000000))'`
		if [ $ret -eq 0 ]; then
        PyInstall=true
        sudo apt-get install python2.7 -y
        if [ $? -eq 0  ]; then
          echo "Python2.7 was succesfully installed using your package manager"
        else
          echo "Your package manager failed to install python. Attempting to download an build package"
   			  echo "Python detected is not 2.7. Installing Python 2.7."
   			  echo -e "\nSetting up the Install Environment. This will take some time..."
        	sudo apt-get install zlib* zlib-devel readline-devel  openssl-devel bzip2-devel wget gcc python-dev -y
          if [ $? -eq 0 ]; then
            echo "Pre-reqs installed."
      	  	# Compile and Build Python 2.7 under /opt
        	  cd /usr/local/src/
          	echo "Assuming you have wget pre-installed."
          	wget http://www.python.org/ftp/python/2.7.1/Python-2.7.1.tgz
          	tar xvfz Python-2.7.1.tgz
          	cd Python-2.7.1
          	./configure --prefix=/opt/python2.7.1 --with-threads --enable-shared
          	make
          	make install
          	# for shared libraries
         		touch /etc/ld.so.conf.d/opt-python2.7.1.conf
         		echo "/opt/python2.7.1/lib/" >> /etc/ld.so.conf.d/opt-python2.7.1.conf
         		ldconfig
          	ln -sf /opt/python2.7.1/bin/python2 /usr/bin/python2.7
          	echo "Python2.7 Install was succesful!"
          else
            echo "Pre-reqs to build failed to install"
          fi
        fi
		fi
    
	    # Python2.7 is already be installed
	    echo "You have a valid version of Python installed. Installing WxPython."
	    sudo apt-get install python-wxgtk2.8 -y
	    if [ $? -eq 0 ]; then
	      echo "WxPython was installed succesfully."
	    else
	      echo "WxPython failed to install! Install will proceed WxPython is required to print"
	    fi
	    
	    echo "Downloading and Installing HP Drivers."
	    # Compile and Build Python 2.7 under /opt
		sudo apt-get install --assume-yes avahi-utils libcups2 cups libcups2-dev cups-bsd cups-client libcupsimage2-dev libdbus-1-dev build-essential ghostscript openssl libjpeg-dev libsnmp-dev libtool libusb-1.0.0-dev wget python-imaging policykit-1 policykit-1-gnome gtk2-engines-pixbuf python-qt4 python-qt4-dbus python-dbus python-gobject python-dev python-notify2 python python-reportlab libsane libsane-dev sane-utils xsane
	    if [ $? -eq 0 ]; then
	      echo "Printer dependencies installed."
	      sudo apt-get install hplip -y
	      if [ $? -eq 0 ]; then
	        echo "hplip succesfully installed."
	        cd "$DIR"
	        echo "Hopefully everything was installed correctly. Attempting pharos setup"
	        if [ "$PyInstall" = false ]; then
	          sudo python setup.py
	        else
	          sudo python2.7 setup.py
	        fi
	      fi
	    fi
	fi #install code end
fi
#

