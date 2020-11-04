#!/usr/bin/expect -f

set commitmode [lindex $argv 0]
set configname [lindex $argv 1]
set hostname [lindex $argv 2]


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
