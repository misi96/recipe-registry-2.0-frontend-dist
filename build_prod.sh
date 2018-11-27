#!/bin/bash

#Saving directory names as variables
repositoryDir=recipe-registry-frontend
distRepositoryDir=recipe-registry-frontend-dist

#Updating the repository
git pull

#Removing dist folder
rm -rf dist

#Navigating to the frontend repository
cd ../$repositoryDir

#Updating the repository
git pull

#Starting production build
npm run build_prod

#Displaying the result of production build
if [ $? -eq 0 ]; then
    printf "\nBUILD SUCCESS\n\n"
else
    printf "BUILD FAILED"
	exit 1
fi

#Navigating back to the dist repository
cd ../$distRepositoryDir

#Displaying the working tree status
git status

#Asking permission to commit and push
echo
while true; do
    read -p "Would you like to commit and push? (yes/no)" yn
    case $yn in
        [Yy]* ) echo
				git add -A
				git commit -m "Frontend version update - `date`"
				git push
				break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
