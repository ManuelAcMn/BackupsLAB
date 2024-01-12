#!/bin/sh

archivo=$1
[ ! $1 ] && read -p "Dime el nombre del archivo: " archivo

read -p "Que tipo de raid es? (Total | Diferencial | Incremental)" carpeta

file="/home/vagrant/backup/$carpeta/$archivo"
sudo tar -xpzf $file -C /

