#!/bin/sh

DIR="/var/www/html"
BACKUPDIR="/home/vagrant/backup"
INCDIR=$BACKUPDIR/Incremental

if [ ! -e $BACKUPDIR ]; then
    sudo mkdir -p $BACKUPDIR #Si no existe, crealo
    sudo mkdir $BACKUPDIR/Total $BACKUPDIR/Diferencial $BACKUPDIR/Incremental
fi

FILENAME="inc_$(date +%d:%m_%H:%M).tar.gz" # Crea el nombre

#Hace la copia diferencial nº1
sudo tar -czf $INCDIR/$FILENAME -g $BACKUPDIR/Total/total.snap $DIR --force-local  # Hace la copia diferencial
rsync -a -e 'ssh -p 22 -i /vagrant/.vagrant/machines/lan/virtualbox/private_key' $BACKUPDIR/* vagrant@192.168.120.2:$HOME/backups -y

sleep 30

#Hace la copia diferencial nº2
sudo tar -czf $INCDIR/$FILENAME -g $BACKUPDIR/Total/total.snap $DIR --force-local  # Hace la copia diferencial
rsync -a -e 'ssh -p 22 -i /vagrant/.vagrant/machines/lan/virtualbox/private_key' $BACKUPDIR/* vagrant@192.168.120.2:$HOME/backups -y
