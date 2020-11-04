#!/bin/bash


# set all the varibles
config=$PT_config
username=$PT_user
host=$PT__target
applymode=$PT_apply_mode
# diag echos
echo noop is $PT__noop
echo host is $PT__target

#set timestamp for config file
timestamp=`date +%s`

echo Using configuration file $config
echo Running in load mode $applymode

newhost=$(echo $host | awk -F 'uri":' '{ print $2 }' | awk -F "," '{ print $1 }' | sed 's/"//g')
echo Running on host $newhost


# Copy config to juniper host under /tmp
scp $config bolt@$newhost:/tmp/boltconfig-$timestamp

#check if we are operting noop mode
if [ $PT__noop == true ]
then
    echo Running in noop mode
    apply_command="commit check"
else
    echo Running in apply mode
    apply_command="commit and-quit"
fi


#If we are using password
if [[ -v PT_password ]]
then
    send_command_password()
    {
        echo "spawn ssh $username@$newhost"
        echo "sleep 2"
        echo "send \r"
        echo "expect \"Password:\""
        echo "send \"$PT_password\""
        echo "expect \"*>\""
        echo "send \"configure exclusive\r\""
        echo "expect \"*#\""
        echo "send \"load $applymode /tmp/boltconfig-$timestamp\r\""
        echo "expect \"*#\""
        echo "send \"show | compare\r\""
        echo "expect \"*#\""
        echo "send \"$apply_command\r\""
        if [ $PT__noop == true ]
        then
            echo "expect \"*#\""
            echo "send \"exit configuration-mode\r\""
        fi
        echo "expect \"*>\""
    }
    send_command_password | /usr/bin/expect -f -
    exit 0
fi

#if we are using explicit private key
if [[ -v PT_ssh_key ]]
    send_command_explict_key()
    {
        echo "spawn ssh -i $PT_ssh_key $username@$newhost"
        echo "sleep 2"
        echo "send \r"
        echo "expect \"*>\""
        echo "send \"configure exclusive\r\""
        echo "expect \"*#\""
        echo "send \"load $applymode /tmp/boltconfig-$timestamp\r\""
        echo "expect \"*#\""
        echo "send \"show | compare\r\""
        echo "expect \"*#\""
        echo "send \"$apply_command\r\""
        if [ $PT__noop == true ]
        then
            echo "expect \"*#\""
            echo "send \"exit configuration-mode\r\""
        fi
        echo "expect \"*>\""
    }
    send_command_explict_key | /usr/bin/expect -f -
    exit 0
fi

#assume default ssh key
send_command()
{
    echo "spawn ssh $username@$newhost"
    echo "sleep 2"
    echo "send \r"
    echo "expect \"*>\""
    echo "send \"configure exclusive\r\""
    echo "expect \"*#\""
    echo "send \"load $applymode /tmp/boltconfig-$timestamp\r\""
    echo "expect \"*#\""
    echo "send \"show | compare\r\""
    echo "expect \"*#\""
    echo "send \"$apply_command\r\""
    if [ $PT__noop == true ]
    then
        echo "expect \"*#\""
        echo "send \"exit configuration-mode\r\""
    fi
    echo "expect \"*>\""
}
send_command | /usr/bin/expect -f -



exit 0
