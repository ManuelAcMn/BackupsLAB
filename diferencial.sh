#!/bin/sh

DIR="/var/www/html"
BACKUPDIR="/home/vagrant/backup"
DifDir=$BACKUPDIR/Diferencial

if [ ! -e $BACKUPDIR ]; then
    sudo mkdir -p $BACKUPDIR #Si no existe, crealo
    sudo mkdir $BACKUPDIR/Total $BACKUPDIR/Diferencial $BACKUPDIR/Incremental
fi

FILENAME="dif_$(date +%d:%m_%H:%M).tar.gz" # Crea el nombre


sudo cp $BACKUPDIR/Total/total.snap $DifDir/dif.snap #copio de la ultima copia total a una diferencial

sudo tar -czf $DifDir/$FILENAME -g $BACKUPDIR/Total/total.snap $DIR --force-local # Hace la copia

sudo cp $DifDir/dif.snap $BACKUPDIR/Incremental/inc.snap # Copio de diferencial a incremental

rsync -a -e 'ssh -p 22 -i /vagrant/.vagrant/machines/lan/virtualbox/private_key' $BACKUPDIR/* vagrant@192.168.120.2:$HOME/backups -y
