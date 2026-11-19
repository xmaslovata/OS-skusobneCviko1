#!/bin/bash
#Ziskanie adresy servera
SERVER=$(echo "$1" | cut -d / -f 1-3)

curl -sL "$1" |
tr -d '\n' |
tr '<' '\n' |
grep -E '^img ' |                       #Vyber obrazkov
grep -o 'src="[^"]*"' |
sed 's/src="//; s/"$//' |
while IFS= read -r LINE                 #citanie adres
do
    if echo "$LINE" | grep '^https:' >/dev/null    #adresa zacina z https: ??
    then
        curl -sL -O "$LINE"                       #ak adresa pravda zacina z https: tak stiahny
    elif echo "$LINE" | grep '^/[^/]' >/dev/null   #adresa zacina z jedneho / ?
    then
        curl -sL -O "$SERVER$LINE"
    fi
done
