#!/bin/bash

config=$PT_config
timestamp=`date +%s`

echo Using configuration file $config
echo $timestamp

scp $config bolt@13.211.138.173:/tmp/boltconfig
#-$timestamp

commands="show interface terse \n exit"
#commands="configure exclusive" \
#load set /tmp/juniperconfig \
#commit check \
#commit | compare \
#commit and-quit \
#exit"

#`echo ${commands} > /tmp/commands-${timestamp}`

#ssh bolt@13.211.138.173 < echo ${commands}
#ssh bolt@13.211.138.173 < /tmp/commands-$timestamp

#send_command()
#{
#    echo "spawn ssh bolt@13.211.138.173"
#    echo "sleep 10"
#    echo "send \"configure exclusive\r\""
#    echo "send \"load set /tmp/boltconfig\r\""
##    echo "send \"show | compare\r\""
#    echo "send \"commit and-quit\r\""
#}
#`send_command | /usr/bin/expect -f - >> /tmp/expectlog`

/usr/bin/expect -c '
spawn ssh bolt@13.211.138.173
sleep 2
send "\r"
expect "*>"
send "configure exclusive\r"
expect "*#"
send "load set /tmp/boltconfig\r"
expect "*#"
send "show | compare\r"
expect "*#"
send "commit and-quit\r"
expect "*>"
close
exit

'



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
