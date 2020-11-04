#!/usr/bin/expect -f

set commitmode [lindex $argv 0]
set configname [lindex $argv 1]
set hostname [lindex $argv 2]

spawn ssh bolt@13.211.138.173
sleep 2
send "configure exclusive\r"
send "load set /tmp/boltconfig\r"
send "show | compare\r"
send "commit and-quit\r"
close
exit