#!/bin/bash

########################
# a script by lazypwny #
########################

#Colors
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
purple="\033[0;35m"
cyan="\033[0;36m"
cafe="\033[0;33m"
fiuscha="\033[0;35m"
blue="\033[1;34m"
tp="\e[0m"

owner="lazypwny"
setversion="1.0"


setdir="$PWD"
setsourcedir="https://github.com/lazypwny751/wordlister/raw/main/sources.tar.gz"
setsource="https://raw.githubusercontent.com/lazypwny751/wordlister/main/sources.list"

swld="./wordlists"

dc="https://discord.gg/gzDZQm6FyZ"

trap btw 2

btw() {
    rm *.list* &> /dev/null
    rm *.gz* &> /dev/null
    [ -d "${setdir}/sources" ] && rm -rf sources &> /dev/null
    echo -e "\nThanks for use wordlister (^-^)"
    exit 0
}

center() {
    termwidth="$(tput cols)"
    padding="$(printf '%0.1s' ={1..500})"
    printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
    echo -e "$tp"
}

banner() {
    randco
    echo -e '
888       888                    888888     d8b        888                   
888   o   888                    888888     Y8P        888                   
888  d8b  888                    888888                888                   
888 d888b 888 .d88b. 888d888 .d88888888     888.d8888b 888888 .d88b. 888d888 
888d88888b888d88""88b888P"  d88" 888888     88888K     888   d8P  Y8b888P"   
88888P Y88888888  888888    888  888888     888"Y8888b.888   88888888888     
8888P   Y8888Y88..88P888    Y88b 888888     888     X88Y88b. Y8b.    888     
888P     Y888 "Y88P" 888     "Y8888888888888888 88888P" "Y888 "Y8888 888      
' ; echo -e "$tp\t\t\t\t\t\t\t\t--$owner"
}

function randco {
    echo -ne "\e[3$(( $RANDOM * 6 / 32767 + 1 ))m$rengarenk"
    rengarenk=""
}

function pressanykey {
    read -n 1 -r -s -p $'Press Any Key To Continue...\n'
}

function netcheck {
    wget -q --spider http://google.com

    if ! [ $? -eq 0 ] ; then
        echo "OffLine [-]"
        exit 1
    fi
}

function checkf {
    if ! [ -d "$swld" ] ; then
        mkdir "$swld"
    fi
}

function indexworlistdir {
    center "*"
    checkf
    echo ""
    tree "${swld}"
    echo ""
    pressanykey
    echo ""
    center "*"
}

function getsourceslist {
    netcheck
    rm *.list* &> /dev/null
    rm *.gz* &> /dev/null
    [ -d "${setdir}/sources" ] && rm -rf sources &> /dev/null
    wget "$setsource" &> /dev/null
    if ! [ -f "${setdir}/sources.list" ] ; then
        echo "some unknown errors occurred, if the problem persists, you can contact us at our discord address.: $dc"
        exit 1  
    fi
    wget "$setsourcedir" &> /dev/null && tar -zxvf sources.tar.gz &> /dev/null
    if ! [ -d "${setdir}/sources" ] ; then
        echo "some unknown errors occurred, if the problem persists, you can contact us at our discord address.: $dc"
        exit 1  
    fi 
}

function interpetsourceslist {
    echo ""
    if [[ -f "${setdir}/sources.list" ]] ; then
        n=0; while IFS= read -r "line$n"; do
            n=$((n + 1))
            lne=$(cat "${setdir}/sources.list" | awk "NR==${n}")
            echo "${n}-) $lne"
        done < "${setdir}/sources.list"
        echo ""
    else
        echo "some unknown errors occurred, if the problem persists, you can contact us at our discord address.: $dc"
        exit 1
    fi
}

function getfile {
    getsourceslist
    while :; do
        interpetsourceslist
        echo -e "0-) back"
        echo -ne "${blue}wordlister-${setversion}${tp}@${red}${owner}${fiuscha}[wordlistdownloader]${tp}> " ; read ln
        echo "" ; center "*"
        if [[ ${ln} != "" ]] && [ ${ln} -gt 0 ] && [ ${ln} -lt $(($n + 1)) ] 2> /dev/null ; then
            source=$(cat "${setdir}/sources.list" | awk "NR==${ln}")
            source "${setdir}/sources/${source}"
            #reponame="?"
            #filename="?"
            break
        elif [[ $ln =~ ^("0"|"00")$ ]] ; then
            rm *.list* &> /dev/null
            rm *.gz* &> /dev/null
            [ -d "${setdir}/sources" ] && rm -rf sources &> /dev/null
            break
        else
            echo "Pls Try Again If You Want To Main Menu Type '0'"
        fi
    done
}

function _init {

while :; do
    banner

    echo -e "1-) WordList Generator.\n2-) WordList Downloader.\n3-) List WordLists.\n0-)Exit the tool.\n"
    echo -ne "${blue}wordlister-${setversion}${tp}@${red}${owner}${fiuscha}[mainmenu]${tp}> " ; read input
    echo ""
    if [[ ${input} =~ ^(1|01)$ ]] ; then
        echo -e "${red}very soon!${tp}"
    elif [[ ${input} =~ ^(2|02)$ ]] ; then
        getfile
    elif [[ ${input} =~ ^(3|03)$ ]] ; then
        indexworlistdir
    elif [[ ${input} =~ ^(0|00)$ ]] ; then
            rm *.list* &> /dev/null
            rm *.gz* &> /dev/null
            [ -d "${setdir}/sources" ] && rm -rf sources &> /dev/null
            echo "Thanks For Use wordlister (^-^)"
            exit 0
    else
        center "*"
        echo -e "Pls Try Again If You Want To Exit This Tool Type '0'"
    fi
done
}

_init