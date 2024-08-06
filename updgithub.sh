#!/usr/bin/bash
rm -rf .git
git init
git add .gitignore
git add --all
git commit -m "updated packages"
git remote add origin git@github.com:emercoin/apt-repo.git
git push -u --force origin master
