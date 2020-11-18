#!/bin/bash

# set all the varibles
config=$PT_config
username=$PT_user
host=$PT__target
applymode=$PT_apply_mode
# diag echos

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
    #required for password only
    copy_config_file()
    {
        echo "set timeout 5"
        echo "spawn scp -o \"StrictHostKeyChecking no\" -o \"ConnectTimeout 10\" $config $username@$newhost:/tmp/boltconfig-$timestamp"
        echo -e "expect { \n
            \"Password:\" { send \"$PT_password\r\" ; exp_continue } \n
            timeout { puts \"Failed to connect to host $newhost\" ; exit 1 } \n
            eof exit\n
            }"
        echo "send \r"
        echo "sleep 2"
    }
    copy_config_file | /usr/bin/expect -f -
    if [ $? -ne 0 ]
    then
        exit 1
    fi
    send_command_password()
    {
        echo "set timeout 5"
        echo "spawn ssh -o \"StrictHostKeyChecking no\" -o \"ConnectTimeout 10\" $username@$newhost"
        echo -e "expect {\n
            \"Password:\" { send \"$PT_password\" } \n
            timeout { puts \"Failed to connect to host $newhost\" ; exit 1 } \n
            }"
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
        echo "send \"file delete /tmp/boltconfig-$timestamp\r\""
        echo "expect \"*>\""
        echo "send \"exit\""
        echo "exit 0"
    }
    send_command_password | /usr/bin/expect -f -
    if [ $? -ne 0 ]
    then
        exit 1
    else
        exit 0
    fi
fi

#if we are using explicit private key
if [[ -v PT_ssh_key ]]
then
    send_command_explict_key()
    {
        # Copy config to juniper host under /tmp
        scp -o "StrictHostKeyChecking no" -o "ConnectTimeout 10" -i $PT_ssh_key $config $username@$newhost:/tmp/boltconfig-$timestamp
        echo "set timeout 5"
        echo "spawn ssh -o \"StrictHostKeyChecking no\" -o \"ConnectTimeout 10\" -i $PT_ssh_key $username@$newhost"
        echo -e "expect { \n
            \"*>\" { sleep 2 } \n
            timeout { puts \"Failed to connect to host $newhost\" ; exit 1 } \n
            }"
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
        echo "send \"file delete /tmp/boltconfig-$timestamp\r\""
        echo "expect \"*>\""
        echo "send \"exit\""
        echo "exit 0"
    }
    send_command_explict_key | /usr/bin/expect -f -
    if [ $? -ne 0 ]
    then
        exit 1
    else
        exit 0
    fi
fi

# Copy config to juniper host under /tmp
scp -o "StrictHostKeyChecking no" -o "ConnectTimeout 10" $config $username@$newhost:/tmp/boltconfig-$timestamp

#assume default ssh key
send_command()
{
    echo "spawn ssh -o \"StrictHostKeyChecking no\" $username@$newhost"
    echo -e "expect { \n
            \"*>\" { sleep 2 } \n
            timeout { puts \"Failed to connect to host $newhost\" ; exit 1 } \n
            }"
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
    echo "send \"file delete /tmp/boltconfig-$timestamp\r\""
    echo "expect \"*>\""
    echo "send \"exit\""
    echo "exit 0"
}
send_command | /usr/bin/expect -f -
if [ $? -ne 0 ]
then
    exit 1
else
    exit 0
fi


exit 0