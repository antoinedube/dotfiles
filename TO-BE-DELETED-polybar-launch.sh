#!/usr/bin/env bash

killall -q polybar

polybar laptop >> /tmp/polybar-laptop.log 2>&1 &

echo "Polybar laptop launched"
