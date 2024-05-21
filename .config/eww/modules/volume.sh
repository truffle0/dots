#!/bin/bash

case $2 in
	"up") adjust="+2%";;
	"down") adjust="-2%";;
esac

case $1 in 
	'source') exec pactl set-source-volume @DEFAULT_SOURCE@ $adjust ;;
	'sink') exec pactl set-sink-volume @DEFAULT_SINK@ $adjust ;;
esac