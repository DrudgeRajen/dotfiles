#!/bin/bash

FONT_SIZE=15
FONT_FAMILY="FiraCode Nerd Font Mono"

if [ "$SENDER" = "wifi_change" ] || [ "$SENDER" = "forced" ]; then
    haswifi="󱚽"
    nohasnowifi="󱛅"
    PRIV_IPADDR="$(networksetup -getinfo Wi-Fi | grep "IP address" | head -n 1 | awk -F ':' '{print $2}')" # 0.0.0.0 | none
    SSID="$(system_profiler SPAirPortDataType | awk '/Current Network Information:/ { getline; print substr($0, 13, (length($0) - 13)); exit }')"
    icon=""
    if [ "$PRIV_IPADDR" != " none" ]; then
        icon="$haswifi"
        PRIV_IPADDR="$PRIV_IPADDR"
	## Get public IP address
        PUB_IPADDR="$(curl https://ipinfo.io/ip 2>/dev/null)"
    else
        icon="$nohasnowifi"
        PUB_IPADDR="none"
        SSID="-offline-"
    fi


    sketchybar --set wifi icon="$icon" label="$SSID" label.font="$FONT_FAMILY:Regular:14.0" icon.font="$FONT_FAMILY:Bold:17" \
        --set wifi.priv.addr label="$PRIV_IPADDR " label.font="$FONT_FAMILY:Regular:12.0" \
        --set wifi.pub.addr label="$PUB_IPADDR" label.font="$FONT_FAMILY:Regular:12.0"

elif [ "$SENDER" == "mouse.entered" ]; then
    sketchybar --set wifi popup.drawing=on
elif [ "$SENDER" == "mouse.exited" ]; then
    sketchybar --set wifi popup.drawing=off
fi
