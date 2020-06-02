pwd
cat -A deploy.sh

#!/bin/bash

git clone https://github.com/$3/$4.git
rsync -av /Users/distiller/project/ /Users/distiller/public_repo/vr-ios-sdk/ --exclude '/.git' --exclude '/.circleci' --exclude '/README.md'
cd $4
git config --global user.email $1
git config --global user.name $2
git checkout -b release_$5_$6
git add .
git commit -m "[auto] release branch"
git remote set-url origin https://$2:$7@github.com/$3/$4.git 
git push origin release_$5_$6