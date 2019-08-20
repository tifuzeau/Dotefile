#!/bin/bash 

# Exit error code
FAIL_SAVE=2
FAIL_INSTALL=3
FAIL_IS_FILE=4
FAIL_CREAT_DIR=5

PATH_SAVE=~/.save/

# $1 == ${?}, $2 == "Error message", $3 == errorcode
check_error ()
{
	if [ ${1} -ne 0 ]
	then
		echo "Error: ${2}"
		echo "Script will now exit !"
		exit ${3}
	fi
}

check_save ()
{
	if [ ! -d ${PATH_SAVE} ]
	then
		if [ -f ${PATH_SAVE} ]
		then
			echo "Error: ${PATH_SAVE} is a file"
			echo "Please remove it"
			echo "Script will now exit !"
			exit FAIL_IS_FILE
		fi
		echo "Creating ${PATH_SAVE}"
		mkdir --mode=700 ${PATH_SAVE}
		check_error ${?} "Fail to Create ${PATH_SAVE}" ${FAIL_CREAT_DIR}
	fi
}

save_file()
{
	check_save
	if [ ! -d ${PATH_SAVE}${2} ]
	then
		echo "Creating ${2}"
		mkdir --mode=700 ${PATH_SAVE}${2}
		check_error ${?} "Fail to Create ${PATH_SAVE}${2}" ${FAIL_CREAT_DIR}
	fi
	if [ -f  ${1} ]
	then
		echo "Save ${1}"
		mv ${1} ${PATH_SAVE}${2}`basename ${1}`
		check_error ${?} "Fail to save ${1}" ${FAIL_SAVE}
	fi
}

install_git ()
{
	PATH_CONF=~/.gitconfig
	PATH_INSTALL=${PWD}/git/gitconfig

	echo "Git Install: START"
	save_file ${PATH_CONF} "git/"
	echo "install .gitconfig"
	cp ${PATH_INSTALL} ${PATH_CONF}
	check_error ${?} "Fail in install of gitconfig" ${FAIL_INSTALL}
	echo "Git Install: END"
	echo
}

install_ssh ()
{
	PATH_SSH=~/.ssh
	PATH_SSH_CONFIG=${PATH_SSH}/config
	PATH_INSTALL=${PWD}/ssh/config

	echo "SSH Install: START"
	if [ ! -d ${PATH_SSH} ]
	then
		echo "Creating ${PATH_SSH}"
		mkdir --mode=700 ${PATH_SSH}
		check_error ${?} "Fail to Create ${PATH_SSH}" ${FAIL_CREAT_DIR}
	fi
	save_file ${PATH_SSH_CONFIG} "ssh/"
	echo "install ssh/config"
	cp ${PATH_INSTALL} ${PATH_SSH}
	check_error ${?} "Fail in install of ssh/config" ${FAIL_INSTALL}
	echo "SSH Install: END"
	echo
}

install_rc ()
{
	PATH_RC=~/.file_rc
	PATH_INSTALL=${PWD}/file_rc

	PATH_ZSHRC=~/.zshrc
	PATH_INSTALL_ZSHRC=${PATH_INSTALL}/zshrc

	echo "File_rc Install: START"
	if [ -d ${PATH_RC} ]
	then
		echo "Save ${PATH_RC}"
		mv ${PATH_RC} ${PATH_SAVE}
		check_error ${?} "Fail to save ${PATH_RC}" ${FAIL_SAVE}
	fi
	echo "install file_rc"
	cp -r ${PATH_INSTALL} ${PATH_RC}
	check_error ${?} "Fail in install of ${PATH_RC}" ${FAIL_INSTALL}
	save_file ${PATH_ZSHRC} "rc/"
	echo "install zshrc"
	cp ${PATH_INSTALL_ZSHRC} ${PATH_ZSHRC}
	check_error ${?} "Fail in install of ${PATH_ZSHRC}" ${FAIL_INSTALL}
	echo "File_rc Install: END"
	echo
}

main ()
{
	install_git
	install_ssh
	install_rc
}

main
