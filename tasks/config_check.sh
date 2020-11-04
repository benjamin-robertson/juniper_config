#!/bin/bash

config=$PT_config
username=$PT_user
host=$PT_target
echo noop is $PT__noop
echo host is $PT__target
export
timestamp=`date +%s`

echo Using configuration file $config

newhost=`echo $host | awk -F 'uri."' { print $2 }`
echo new host $newhost

scp $config bolt@13.211.138.173:/tmp/boltconfig-$timestamp


send_command()
{
    echo "spawn ssh bolt@13.211.138.173"
    echo "sleep 2"
    echo "send \r"
    echo "expect \"*>\""
    echo "send \"configure exclusive\r\""
    echo "expect \"*#\""
    echo "send \"load set /tmp/boltconfig-$timestamp\r\""
    echo "expect \"*#\""
    echo "send \"show | compare\r\""
    echo "expect \"*#\""
    echo "send \"commit and-quit\r\""
    echo "expect \"*>\""
}
send_command | /usr/bin/expect -f -






#/usr/bin/expect -c '
#spawn ssh bolt@13.211.138.173
#sleep 2
#send "\r"
#expect "*>"
#send "configure exclusive\r"
#expect "*#"
#send "load set /tmp/boltconfig\r"
#expect "*#"
#send "show | compare\r"
#expect "*#"
#send "commit and-quit\r"
#expect "*>"
#close
#exit
#'



exit 0

# Puppet Task Name: config_check
#
# This is where you put the shell code for your task.
#
# You can write Puppet tasks in any language you want and it's easy to
# adapt an existing Python, PowerShell, Ruby, etc. script. Learn more at:
# https://puppet.com/docs/bolt/0.x/writing_tasks.html
#
# Puppet tasks make it easy for you to enable others to use your script. Tasks
# describe what it does, explains parameters and which are required or optional,
# as well as validates parameter type. For examples, if parameter "instances"
# must be an integer and the optional "datacenter" parameter must be one of
# portland, sydney, belfast or singapore then the .json file
# would include:
#   "parameters": {
#     "instances": {
#       "description": "Number of instances to create",
#       "type": "Integer"
#     },
#     "datacenter": {
#       "description": "Datacenter where instances will be created",
#       "type": "Enum[portland, sydney, belfast, singapore]"
#     }
#   }
# Learn more at: https://puppet.com/docs/bolt/0.x/writing_tasks.html#ariaid-title11
#
