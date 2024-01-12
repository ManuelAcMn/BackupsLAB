#!/bin/sh

DIR="/var/www/html"
BACKUPDIR="/home/vagrant/backup"
TotalDir=$BACKUPDIR/Total

if [ ! -e $BACKUPDIR ]; then
    sudo mkdir -p $BACKUPDIR #Si no existe, crealo
    sudo mkdir $BACKUPDIR/Total $BACKUPDIR/Diferencial $BACKUPDIR/Incremental
fi

# Crea el nombre de el nuevo backup
FILENAME="total_$(date +%d:%m_%H:%M).tar.gz" 

# Si existe una total igual, borra la total
if [ -e $TotalDir/$FILENAME ]; then 
    sudo rm -r $TotalDir/$FILENAME
fi
# Si existe la snashot, la borro para que haga una total
if [ -e $TotalDir/total.snap ]; then 
    sudo rm -r $TotalDir/total.snap
fi

# Hace la backup total
sudo tar -czf $TotalDir/$FILENAME -g $TotalDir/total.snap $DIR --force-local # Hace la copia

# Envia todo al servidor LAN
rsync -a -e 'ssh -p 22 -i /vagrant/.vagrant/machines/lan/virtualbox/private_key' $BACKUPDIR/* vagrant@192.168.120.2:$HOME/backups -y

sudo cp $TotalDir/total.snap $BACKUPDIR/Incremental/inc.snap #Crea la incremental
