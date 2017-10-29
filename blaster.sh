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
whiptail --title "Disclamer" --msgbox "The developers of this program are not responsible for any excessive load caused by this program. By selecting OK, you have made yourself aware of the potential repercussions of your actions. To exit, press control-c." --cancel-button Cancel 10 80

sudo git clone https://github.com/jedisct1/dnsblast /etc/dnsblast
cd /etc/dnsblast
sudo make
/etc/dnsblast/dnsblast $HOSTTOBLAST $AMOUNTOFBLASTS

sudo rm -r /etc/dnsblast

## Remove hostlist
rm $DOMAINLIST
