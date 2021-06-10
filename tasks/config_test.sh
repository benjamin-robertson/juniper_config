#!/bin/bash

echo "In bash"

# set all the varibles
config=$PT_config
username=$PT_user
host=$PT__target
applymode=$PT_apply_mode
# check if sleeptime has been set, if not default to 5 seconds
if [[ -v PT_sleeptime ]] 
then
    sleeptime=$PT_sleeptime
else
    sleeptime=5
fi


# Check install requirements
expectlocation=`which expect`
if [ $? == 0 ]
then
    echo expect is at $expectlocation
else
    echo Cannot locate expect, please install bailing out.
    exit 1
fi

#set timestamp for config file
timestamp=`date +%s`

echo Using configuration file $config
echo Running in load mode $applymode

newhost=$(echo $host | awk -F 'uri":' '{ print $2 }' | awk -F "," '{ print $1 }' | sed 's/"//g')
echo Running on host $newhost
echo Sleeptime is at $sleeptime seconds



#check if we are operting noop mode
if [ $PT__noop == true ]
then
    echo Running in noop mode
    apply_command="commit check"
else
    echo Running in apply mode
    apply_command="commit and-quit"
fi

./config_default_key.exp