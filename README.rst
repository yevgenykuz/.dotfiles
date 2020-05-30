Initial setup and configuration
###############################

| This is my initial setup procedure of a Linux Mint machine with Cinnamon.
| Perform the steps in the following order.

-----


.. contents::

.. section-numbering::


Initial configuration
=====================

Ubuntu flavored OS installation - setup guidelines
--------------------------------------------------

* Set locale, keyboard, and all language settings to English(US)
* Set hostname and user information
* Do not encrypt home directory
* Set timezone to local timezone
* Partitioning - use entire disk and set up LVM, set usage amount to 80%
* Leave HTTP proxy blank
* Choose no automatic updates (if installing Ubuntu server)
* Software selection: standard system utilities, OpenSSH server (if installing Ubuntu server)
* Install GRUB boot loader

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

* Restart the network manager service

.. code-block:: bash

    sudo service network-manager restart

Create SSH and GPG keys
-----------------------

See `Appendix: SSH and GPG keys`_.

Sync with configuration backup repo
===================================

.. code-block:: bash

    rm -rf ~/.dotfiles
    git clone https://github.com/yevgenykuz/.dotfiles.git ~/.dotfiles
    chmod +x ~/.dotfiles/install.sh
    chmod +x ~/.dotfiles/scripts/*.sh
    # after logging into Mozilla account in Firefox, move all items from ~/.dotfiles/.mozilla/firefox/RANDOM_PROFILE_STRING to generated profile folder in ~/.mozilla/firefox

Automatic package installation and configuration
================================================

Run install.sh
--------------

.. code-block:: bash

    chmod +x ~/.dotfiles/install.sh
    bash ~/.dotfiles/install.sh

Manual package installation and configuration
=============================================

Install from "Software Manager"
-------------------------------
* Gparted
* Spotify
* Deluge
* Bleachbit
* Virutalbox
* Keepassxc (NOT flatpack edition)
* Filezilla
* Sublime
* VLC
* Gimp-plugin-registry
* Remmina
* Remmina-plugin-rdp

Install from official sites
---------------------------
* IntelliJ
* PyCharm

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
* Redshift
* Spices Update

Appendix: SSH and GPG keys
==========================

SSH key
-------

* Creation:

.. code-block:: bash

   ssh-keygen -t rsa -b 4096 -C "yevgenyku@gmail.com"
   # Accept default file location, and then type a pass phrase
   # --> Done
   # To use it, copy your public key to system clipboard:
   xclip -sel clip < ~/.ssh/id_rsa.pub
   # Paste into target location

* Deletion:

.. code-block:: bash

   rm ~/.ssh/id_rsa*

* Password testing:

.. code-block:: bash

   # Load it into your SSH agent:
   ssh-add
   # If it was loaded, unload it:
   ssh-add -d

GPG key
-------

* Creation:

.. code-block:: bash

    gpg --full-generate-key
    # Select default key king (RSA and RSA)
    # Set key size to 4096
    # Set key expiration 1y
    # Set name to "Yevgeny Kuznetsov"
    # Set email to "yevgenyku@gmail.com"
    # Leave comment empty
    # Type a pass phrase
    # --> Done (move mouse during key generation)
    # To use it, get ID for created key (can be found after "sec   4096R/_____ID_____":
    gpg --list-secret-keys --keyid-format LONG
    # Copy GPG public key to system clipboard:
    gpg --armor --export _____ID_____ | xclip -sel clip
    # Paste into target location

* Current key ID retrieval:

.. code-block:: bash

    gpg --list-secret-keys --keyid-format LONG

* Deletion:

.. code-block:: bash

    # Get current key ID, and then delete the key:
    gpg --delete-secret-key <KEYID>
    # Confirm multiple times

* Password testing:

.. code-block:: bash

    # Get current key ID, and then try with the key:
    echo "Test" | gpg --no-use-agent -o /dev/null --local-user <KEYID> -as - && echo "OK"

Meta
====

Authors
-------

`yevgenykuz <https://github.com/yevgenykuz>`_

-----
