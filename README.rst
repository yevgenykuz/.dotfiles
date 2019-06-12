Initial setup and configuration
###############################

This is my initial setup procedure.

-----


.. contents::

.. section-numbering::


Configuration during setup
==========================

Ubuntu flavored OS Installation
-------------------------------

* Set locale, keyboard, and all language settings to English(US)
* Set hostname and user information
* Do not encrypt home directory
* Set timezone to local timezone
* Partitioning - use entire disk and set up LVM, set usage amount to 80%
* Leave HTTP proxy blank
* Choose no automatic updates (if installing ubuntu server)
* Software selection: standard system utilities, OpenSSH server (if installing ubuntu server)
* Install GRUB boot loader
* **Installation complete**

Static IP configuration
-----------------------

* Edit /etc/network/interfaces with sudo (replace "ens32" with actual interface)

.. code-block:: bash

    ...
    # The primary network interface
    auto ens32
    iface ens32 inet static
    address 192.168.14.202
    netmask 255.255.255.0
    gateway 192.168.14.1
    dns-nameservers 192.168.14.1 1.1.1.1 8.8.8.8 9.9.9.9

* Reboot

.. code-block:: bash

    sudo reboot

Custom Software installation
============================

Add custom PPAs:
----------------

* TeamSpeak 3 client

.. code-block:: bash

    sudo add-apt-repository ppa:materieller/teamspeak3

* Update apt

.. code-block:: bash

    sudo apt update

Install the following
---------------------

.. code-block:: bash

    sudo apt install git zsh vim openjdk-8-jdk open-jdk-8-source maven python-pip python3-pip python3-dev screenfetch htop tree thefuck terminator ttf-mscorefonts-installer g++ clang cmake treaceroute ruby-full build-essential zlib1g-dev teamspeak3-client

Configure zsh as main shell
---------------------------

.. code-block:: bash

    chsh -s $(which zsh)
    sudo reboot

Beautify zsh
------------

.. code-block:: bash

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    mkdir ~/temp
    git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git  ~/temp
    ~/temp/install.sh SourceCodePro
    rm -rf ~/temp

Install python modules for .rst file editing with vscode extention
-------------------------------------------------------------------

.. code-block:: bash

    pip install setuptools wheel docutils doc8 pygments

Install RUBY gems for Jekyll to build personal github.io page
-------------------------------------------------------------

.. code-block:: bash

    gem install jekyll bundler
    
Sync with configuration backup repo
===================================

.. code-block:: bash

    mkdir ~/configuration_backup
    git clone https://github.com/yevgenykuz/station-configuration.git ~/configuration_backup
    # copy all files and folder from ~/configuration_backup to their appropriate location
    # add +x permissions to scripts in /home/yevgeny/custom_system_scripts
    sudo fc-cache -f -v
    update_system.sh
    sudo reboot

Linux Mint notes
================

Install manually from "Software Manager"
----------------------------------------
* Gparted
* Spotify
* Deluge
* Bleachbit
* Virutalbox
* Keepassx
* Filezilla
* Sublime
* VLC

Install manually from official sites
------------------------------------
* Chrome
* IntelliJ
* PyCharm
* CLion
* Visual Studio Code

Remove
------
* Transmission-gtk
* Rhytmbox

Install extensions (System Settings -> Extensions)
--------------------------------------------------
* Transparent panels

Install applets (System Settings -> Applets)
--------------------------------------------
* Weather
* Multi-Core System Monitor

Meta
====

Authors
-------

`yevgenykuz <https://github.com/yevgenykuz>`_

-----
