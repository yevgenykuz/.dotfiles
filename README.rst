Initial setup and configuration
###############################

| This is my initial setup procedure of a my development machine.
| It supports the following flavours:

* A home box running Linux Mint >20 machine with Cinnamon, including visual aspects like applets and themes, i/o drivers, cinnamon configuration
* Minimal procedure suitable for virtual machines
* Minimal procedure suitable for WSL on windows
* A home box running MacOS

| Perform the steps in the following order.
| If used for a virtual machine or WSL, skip SSH and GPG keys creation and start from `Install Git`_.

-----


.. contents::

.. section-numbering::


Initial configuration
=====================

Manual configuration - MacOS
----------------------------

See `Appendix: MacOS`_.

Manual configuration - Linux Mint
---------------------------------

See `Appendix: Linux Mint`_.

Create SSH and GPG keys
-----------------------

See `Appendix: SSH and GPG keys`_.


Install git
===========

.. code-block:: bash

    # linux:
    sudo apt install -y git
    # mac:
    brew install git


Sync with dotfiles (this) repo
==============================

.. code-block:: bash

    rm -rf ~/.dotfiles
    # if you've set up an SSH key and have access to this repository, you can use ssh:
    git clone git@github.com:yevgenykuz/.dotfiles.git ~/.dotfiles
    # otherwise, use https:
    git clone https://github.com/yevgenykuz/.dotfiles.git ~/.dotfiles
    # make sure all .sh files have execute permission. If not, give it with:
    chmod +x ~/.dotfiles/*.sh
    chmod +x ~/.dotfiles/scripts/*.sh


Automatic package installation and configuration
================================================

Run install.sh
--------------
| Run and select between a full installation for a desktop environment or a minimal installation for a virtual machine.
| WSL or MacOS is detected automatically.
|

.. code-block:: bash

    bash ~/.dotfiles/install.sh
    # this script may take some time, resulting in multiple requests for sudo password


Appendix: MacOS
===============

Apple ID
--------
* Create an Apple ID, login to apple music once to add shipping and payment addresses (without credit card)
* Login to App Store, update everything

Manual terminal setup
---------------------
Install homebrew:

* Get it (accept xcode cmd tools, type password for sudo): ``/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"``
* Follow instructions to add to path and then test it: ``brew doctor``

Bash and iTerm2:

* Update bash before running ``install.sh``: ``brew install bash``
* Install iTerm2: ``brew install --cask iterm2``

Manual system settings configuration
------------------------------------
Go to "System Preferences":

* [General] Language & Region > Add your language(s) and update units
* [General] Date & Time > Set time zone automatically using your current location (enable location services if needed)
* [General] Sharing > Local hostname > Edit if needed
* [Appearance] Appearance > Dark
* [Control Center] Bluetooth > Show in Menu Bar
* [Control Center] Sound > Always Show in Menu Bar
* [Control Center] Spotlight > Don't Show in Menu Bar
* [Privacy & Security] Analytics & Improvements > Disable all
* [Privacy & Security] Apple Advertising > Disable all
* [Desktop & Dock] Adjust dock size
* [Desktop & Dock] Automatically hide and show the Dock
* [Desktop & Dock] Show suggested and recent apps in Dock - Disable
* [Desktop & Dock] Shortcuts > Disable all
* [Desktop & Dock] Hot Corners > Disable all
* [Displays] Night Shift > Set a custom schedule from 6:00AM to 5:55AM
* [Touch ID & Password] Setup new fingerprint, use for all
* [Users & Groups] Disable guest user login
* [Keyboard] Key Repeat > Fast
* [Keyboard] Delay Until Repeat > Short
* [Keyboard] Press fn key to > Show Emoji & Symbols
* [Keyboard] Keyboard navigation > Enable
* [Keyboard] Keyboard shortcuts > Disable all
* [Trackpad] Point & Click > Tap to click
* [Trackpad] More Gestures > Enable all

Manual built-in apps configuration
----------------------------------
Finder:

* Settings > General > Set default directory to home directory
* Settings > General > Use windows to open new folders
* Settings > Sidebar > Edit sidebar items
* Settings > Advanced > Show all filename extensions
* View > Show Path Bar
* Show hidden files, open terminal and: ``defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder;``

Screenshot:

* Change screenshot save location - open the app > Options > Select folder under ``Save to``

iTerm2 (do these after running ``install.sh``):

* Click in menu bar > Make iTerm2 default Term
* Settings > General > Selection > Copy to pasteboard on selection
* Settings > General > Selection > Applications in terminal may access clipboard
* Settings > General > Closing > Disable all
* Settings > Appearance > General > Theme > Minimal
* Settings > Profiles > Other Actions... > Import JSON profiles > import from file in ``~/.dotfiles/.local/iterm2-profiles`` and set as default (`Command+Shift+.` to show hidden files)
* Settings > Pointer > General > Three-finger tap emulates middle click
* Settings > Pointer > General > Focus follows mouse
* Now restart iterm2 (click the icon in the dock it the window doesn't show up), and then > Window > Save window arrangement
* Settings > General > Startup > Window restoration policy > Open default window arrangement
* To allow touch ID with sudo - edit ``/etc/pam.d/sudo`` and add ``auth sufficient pam_tid.so`` at the top
* Settings > Advanced > Allow sessions to survive logging out and back in > set to ``No``
* Restart to apply


Appendix: Linux Mint
====================

Install from official sites
---------------------------
* IntelliJ
* Slack

Manual system settings configuration
------------------------------------
Go to "System Settings":

* [Keyboard] Add keyboard layouts and set switching shortcut to "Alt+Shift"
* [Preferred Applications] Configure preferred applications
* [Applets/Extensions] Configure applets and extensions
* [Desktop] Remove "Computer" and "Home" shortcuts from desktop

Misc.
-----
* Complete Linux Mint system report tasks


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
   # or, if xclip complains about "Error: Can't open display: (null)" just cat the contents and copy manually
   cat ~/.ssh/id_rsa.pub
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

* MacOS integration:

.. code-block:: bash

   # Add to macos keychain:
   ssh-add --apple-use-keychain ~/.ssh/id_rsa
   # Add the following to ~/.ssh/config to persist after reboot
   Host *
     ServerAliveInterval 60
     UseKeychain yes
     AddKeysToAgent yes
     IdentityFile ~/.ssh/id_rsa

GPG key
-------

* Creation:

.. code-block:: bash

    gpg --full-generate-key
    # Select key kind - RSA and RSA
    # Set key size to 4096
    # Set key expiration 1y
    # Set name to "Yevgeny Kuznetsov"
    # Set email to "yevgenyku@gmail.com"
    # Leave comment empty
    # Type a pass phrase
    # --> Done (move mouse during key generation)
    # To use it, get ID for created key (can be found after "sec   rsa4096/<KEYID>":
    gpg --list-secret-keys --keyid-format LONG
    # Copy GPG public key to system clipboard:
    gpg --armor --export <KEYID> | xclip -sel clip
    # or, if xclip complains about "Error: Can't open display: (null)" just show the contents and copy manually
    gpg --armor --export <KEYID>
    # Paste into target location

* Current key ID retrieval:

.. code-block:: bash

    gpg --list-secret-keys --keyid-format LONG

* Deletion:

.. code-block:: bash

    # Get current key ID, and then delete the secret key:
    gpg --delete-secret-key <KEYID>
    # Confirm multiple times
    # Delete the public key too:
    gpg --delete-keys <KEYID>

* Password testing:

.. code-block:: bash

    # Get current key ID, and then try with the key:
    echo "Test" | gpg --no-use-agent -o /dev/null --local-user <KEYID> -as - && echo "OK"

* Key publishing:

.. code-block:: bash

    # Get current key ID, and upload it to the following key servers:
    gpg --keyserver keyserver.ubuntu.com --send-keys <KEYID>
    gpg --keyserver keys.openpgp.org --send-keys <KEYID>
    gpg --keyserver pgp.mit.edu --send-keys <KEYID>

* MacOS integration:

.. code-block:: bash

   # After installing pinentry-mac add the following to ~/.gnupg/gpg-agent.conf (validate with "which pinentry-mac"):
   pinentry-program /opt/homebrew/bin/pinentry-mac
   # Then run:
   gpgconf --kill gpg-agent


Meta
====

Authors
-------

`yevgenykuz <https://github.com/yevgenykuz>`_

-----
