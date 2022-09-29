#!/bin/bash

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run /usr/lib/geoclue-2.0/demos/agent 
run picom -b --experimental-backends --config ~/.config/picom/picom.conf
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 
run redshift-gtk 
run redshift 
