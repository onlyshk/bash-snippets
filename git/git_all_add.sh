#!/bin/bash

read -p "Enter commit message: " comment;
git add .
echo "All files added"
git commit -m $commit
echo "Commit done"
git push
echo "Pushed"
