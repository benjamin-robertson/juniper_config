#!/usr/bin/expect -f

set commitmode [lindex $argv 0]
set configname [lindex $argv 1]
set hostname [lindex $argv 2]

proc connect {} {
  expect {
    "bolt>" {
        return 0
    }
  }
  # timeout
  return 1
}

spawn ssh bolt@13.211.138.173

set rez [connect]

if { $rez == 0 } {
  sleep 2
  send "configure exclusive\r"
  send "load set /tmp/boltconfig\r"
  send "show | compare\r"
  send "commit and-quit\r"
  close
  exit
}