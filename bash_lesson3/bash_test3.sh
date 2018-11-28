#!/usr/bin/env bash
opt=Exit
case "${opt}" in
	"Install-Puppet-Server" )
		install_master $1
		exit
	;;

	"Install-Puppet-Client" )
		install_client $1
		exit
	;;

	"Config-Puppet-Server" )
		config_puppet_master
		exit
	;;

	"Config-Puppet-Client" )
		config_puppet_client
		exit
	;;

	"Exit" )
		exit
	;;

	* ) echo "Bad option, please choose again"
esac