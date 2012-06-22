#!/bin/sh

git add -f config/smart_twitter.yml
git commit -m "<tmp-commit> smart_twitter.yml"
git push -f heroku master
git reset --soft HEAD\^
