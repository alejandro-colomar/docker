#!/bin/bash

#set -x

pwd=$( dirname $( readlink -f $0 ) ) ;

test -z "$stack" && echo PLEASE DEFINE THE VALUE FOR stack && exit 1 ;

source $pwd/../../common/functions.sh

command=" sudo docker swarm join-token manager | grep token " ;
targets=" InstanceManager1 " ;
for target in $targets ; do
	echo "Waiting for $target to complete ..."			;
 send_list_command "$command" "$stack" "$target" ;
done ;
token_manager=" $output ";

command=" sudo docker swarm join-token worker | grep token " ;
targets=" InstanceManager1 " ;
for target in $targets ; do
	echo "Waiting for $target to complete ..."			;
 send_list_command "$command" "$stack" "$target" ;
done ;
token_worker=" $output ";

command=" sudo $token_manager " ;
targets=" InstanceManager2 InstanceManager3 " ;
for target in $targets ; do
 send_command "$command" "$stack" "$target" ;
done ;

command=" sudo $token_worker " ;
targets=" InstanceWorker1 InstanceWorker2 InstanceWorker3 " ;
for target in $targets ; do
 send_command "$command" "$stack" "$target" ;
done ;

command=" cat /token_ucp " ;
targets=" InstanceManager1 " ;
for target in $targets ; do
	echo "Waiting for $target to complete ..."			;
 send_list_command "$command" "$stack" "$target" ;
done ;
echo " UCP Credentials: " ;
echo " $output ";

