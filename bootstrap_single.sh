#!/usr/bin/env bash


#########################################################
# Source https://mailinabox.email/ https://github.com/mail-in-a-box/mailinabox
# Updated by cryptopool.builders for crypto use...
# This script is intended to be ran from the multipool installer
#########################################################

if [ -z "${TAG}" ]; then
	TAG=v1.18
fi

# Clone the MultiPool repository if it doesn't exist.
if [ ! -d $HOME/multipool/yiimp_single ]; then
	echo Downloading MultiPool YiiMP Single Server Installer ${TAG}. . .
	git clone \
		-b ${TAG} --depth 1 \
		https://github.com/zhq1/multipool_yiimp_single \
		$HOME/multipool/yiimp_single \
		< /dev/null 2> /dev/null

	echo
fi

# Change directory to it.
cd $HOME/multipool/yiimp_single

# Update it.
sudo chown -R $USER $HOME/multipool/install/.git/
if [ "${TAG}" != `git describe --tags` ]; then
	echo Updating MultiPool YiiMP Single Server Installer to ${TAG} . . .
	git fetch --depth 1 --force --prune origin tag ${TAG}
	if ! git checkout -q ${TAG}; then
		echo "Update failed. Did you modify something in `pwd`?"
		exit
	fi
	echo
fi

# Start setup script.
cd $HOME/multipool/yiimp_single
source start.sh
