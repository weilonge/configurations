#!/bin/bash

CMD=$1

if [ "$CMD" == "reset" ]; then
    GAIA_DPPX=1.5 NOFTU=1 DEVICE_DEBUG=1 make reset-gaia
elif [ "$CMD" == "comms" ]; then
    GAIA_DPPX=1.5 DEVICE_DEBUG=1 APP=communications make install-gaia
elif [ "$CMD" == "settings" ]; then
    GAIA_DPPX=1.5 DEVICE_DEBUG=1 APP=settings make install-gaia
elif [ "$CMD" == "clean" ]; then
    GAIA_DPPX=1.5 DEVICE_DEBUG=1 make clean
elif [ "$CMD" == "install-gaia" ]; then
    GAIA_DPPX=1.5 DEVICE_DEBUG=1 make install-gaia
fi

