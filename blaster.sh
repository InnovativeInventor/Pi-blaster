#!/bin/bash
#This is a shell dnsblaster to stress-test pihole

## Deps
WHATITIS=dnsutils
WHATPACKAGE=dnsutils
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
apt-get install -y $WHATPACKAGE
fi

## Vars
HOSTTOBLAST=$(whiptail --inputbox "What DNS server would you like to blast?" 10 80 "" 3>&1 1>&2 2>&3)
AMOUNTOFBLASTS=$(whiptail --inputbox "How many requests would you like to send?" 10 80 "" 3>&1 1>&2 2>&3)
whiptail --title "Disclamer" --yesno "The developers of this program are not responsible for any excessive load on DNS servers caused by this program. By selecting yes, you agree not to use this program in a malicious way. To exit, press control-c." 10 80
if [ $? -eq 1 ]
  echo "Ok, exiting . . ."
  exit 1
fi

sudo git clone https://github.com/jedisct1/dnsblast /etc/dnsblast
cd /etc/dnsblast
sudo make
/etc/dnsblast/dnsblast $HOSTTOBLAST $AMOUNTOFBLASTS

sudo rm -r /etc/dnsblast
