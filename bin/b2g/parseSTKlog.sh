#!/bin/bash

function a  {
  cat $1 | \
  grep "STK Communication changed\|STK:CALLS State change\|sendStkEventDownload\|handleStkProactiveCommand.*\"typeOfCommand\":5"
  exit 0
}

function b {
#  cat $1 | \
	adb logcat | \

#  grep "\[0\] commandNumber\|\[0\] Received chrome message\|Received message from worker" | \

  grep "\[0\] commandNumber\|\[0\] Received chrome message\|STK Proactive Command for SIM " | \
#  sed 's/^[0-9\ \:\.\-]*[\ ]*[0-9]*[\ ]*[0-9]*[\ ]*I Gecko   : RIL Worker: \[0\] //g' | \
#  sed 's/^[0-9\ \:\.\-]*[\ ]*[0-9]*[\ ]*[0-9]*[\ ]*I GeckoDump: \[system\] //g' | \
#  sed 's/^[0-9\ \:\.\-]*[\ ]*[0-9]*[\ ]*[0-9]*[\ ]*I Gecko   : -\*- RadioInterface\[0\]: //g' | \
  sed 's/\(^Received chrome message.*"rilMessageType":"sendStkTerminalResponse".*\)/\
[TR]    \1/g' | \
  sed 's/\(^Received chrome message.*"rilMessageType":"sendStkMenuSelection".*\)/\
[MENU]  \1/g' | \
  sed 's/\(^Received chrome message.*"rilMessageType":"sendStkEventDownload".*\)/\
[EVT]   \1/g' | \
  sed 's/\(^Received message from worker.*\)/\
[>>SIM] \1/g' | \
  sed 's/\(^STK Proactive Command for SIM .*\)/\
[<<SIM] \1/g' | \
  sed 's/\(^commandNumber = [0-9]* typeOfCommand = [0-9]* commandQualifier = [0-9]*\)/\
[<<SIM] \1/g'

  echo "============================================"
  exit
}

function c {
  cat $1 | \
  sed 's/^[0-9\ \:\.\-]*[\ ]*[0-9]*[\ ]*[0-9]*[\ ]*I Gecko   : RIL Worker: \[0\] //g' | \
  sed 's/^[0-9\ \:\.\-]*[\ ]*[0-9]*[\ ]*[0-9]*[\ ]*I Gecko   : -\*- RadioInterface\[0\]: //g'
  exit
}

b $1


