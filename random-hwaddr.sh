#!/bin/bash
# used to create a random MAC addr
/usr/bin/printf '%02X:%02X:%02X:%02X:%02X:%02X' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] $[RANDOM%256] 
