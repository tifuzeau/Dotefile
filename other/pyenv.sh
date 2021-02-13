#!/bin/sh

PATH_ENV_START="env/bin/activate"

usage ()
{
	echo "Usage: {init|start|stop|freeze}"
}

init ()
{
	if [ -d ".git" ]
		then
		virtualenv -p python3 env
	else
		echo "You are not on git repository"
	fi
}

start ()
{
	if [ -f $PATH_ENV_START ]
		then
		source $PATH_ENV_START
	else
		echo "pyenv: $PATH_ENV_START not found"
	fi
}

stop ()
{
	deactivate
}

freeze()
{
	if [ -d ".git" ]
		then
		pip freeze > requirements.txt
	else
		echo "You are not on git repository"
	fi
}


case "$1" in
	init|start|stop|freeze) $1;;
	*) usage ;;
esac
exit
