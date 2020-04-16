#!/bin/bash
repo="four_in_a_row_online_backend"
if [[ -d "/home/pi/$repo" ]]
then
	echo "Repo Exists, fetching…"
	git --git-dir="/home/pi/$repo/.git" fetch 
	lst="last_commit.txt"
	touch $lst
	current=$(git --git-dir="/home/pi/$repo/.git" show-branch master)
	last=$(cat $lst)
	echo "Current commit message: $current"
	echo "Last commit message: $last"
	if [ "$current" != "$last" ] 
	then
		echo "New commits found, pulling…"
		echo $current > $lst
		git --git-dir="/home/pi/$repo/.git" pull
		exit 0
	else
		echo "No changes, not pulling"
		exit 1
	fi
else
	echo "Repo does not exist, cloning…"
	git clone "https://github.com/elsholz/$repo.git"
	exit 0
fi
