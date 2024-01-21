#!/usr/bin/env bash

SCREENSHOT='/tmp/scrot_lock_screen.png'
BLURRED_SCREENSHOT='/tmp/scrot_lock_screen_blurred.png'

rm $SCREENSHOT
rm $BLURRED_SCREENSHOT

scrot -m -q 50 $SCREENSHOT
convert $SCREENSHOT -blur 0x6 -brightness-contrast -10x-10 $BLURRED_SCREENSHOT
i3lock -i $BLURRED_SCREENSHOT
