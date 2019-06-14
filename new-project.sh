#!/bin/bash

Path="/ROUTE/OF/DIRECTORIE" #change path to your projects folder
GitUser="USER" #set your github user
Extension=""
Folder=""
case "$1" in
"-py")
    Extension="py"
    Folder="python"
    ;;
"-java")
    Extension="txt"
    Folder="java"
    ;;
*)
    echo $1" is not a valid cammand try -py or -java"
    exit 0
    ;;
esac
if [ ! -d $Path$Folder ]; then
    cd $Path
    mkdir -p $Folder
fi;
cd $Path$Folder/
if [ ! -d $2 ]; then
    echo "creating proyect: " $2
    mkdir -p $2
    echo "created main folder: " $2
    cd $2
    curl -u $GitUser https://api.github.com/user/repos -d "{\"name\":\"$2\"}"
    git init
    echo "ADD README CONTENT" > README.md
    git add README.md
    git commit -m "Initial"
    git remote add origin https://github.com/$GitUser/$2.git
    git push -u origin master
    mkdir "src"
    echo "created src folder: "
    cd $Path$Folder/$2/src/
    > $2.$Extension
else
    echo "A folder named "$2" already exist"
fi;
