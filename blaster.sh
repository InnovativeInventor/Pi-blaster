#!/bin/bash
## This is a shell dnsblaster to stress-test dns servers

## Deps
WHATITIS=whiptail
WHATPACKAGE=whiptail
timestamp=$(echo `date`)
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS is installed"
else
printf "$yellow"  "Installing $WHATITIS"
sudo apt-get install -y $WHATPACKAGE
fi

WHATITIS=git
WHATPACKAGE=git
timestamp=$(echo `date`)
if
which $WHATITIS >/dev/null;
then
echo ""
printf "$yellow"  "$WHATITIS is installed"
else
printf "$yellow"  "Installing $WHATITIS"
sudo apt-get install -y $WHATPACKAGE
fi

## Disclaimers
whiptail --title "Disclamer" --yesno "The developers of this program are not responsible for any excessive load on DNS servers caused by this program. By selecting yes, you agree not to use this program in a malicious way. To exit, press control-c." 10 80
if [ $? -eq 1 ]; then
  echo "Ok, exiting . . ."
  exit 1
fi

## Vars
HOSTTOBLAST=$(whiptail --inputbox "What DNS server would you like to blast?" 10 80 "" 3>&1 1>&2 2>&3)
AMOUNTOFBLASTS=$(whiptail --inputbox "How many requests would you like to send?" 10 80 "" 3>&1 1>&2 2>&3)

sudo git clone https://github.com/jedisct1/dnsblast /etc/dnsblast
cd /etc/dnsblast
sudo make
/etc/dnsblast/dnsblast $HOSTTOBLAST $AMOUNTOFBLASTS

## Asking if user wants to remove dnsblaster
whiptail --title "Keep dnsblaster?" --yesno "Do you want to keep dnsblaster to speed up future runnings of this script?" 10 80
if [ $? -eq 1 ]; then
  echo "Ok, removing dnsblaster . . ." 
  # Deleting dnsblast
  sudo rm -r /etc/dnsblast
fi
exit 0
