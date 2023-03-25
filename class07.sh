#!/bin/bash

myvar=17

echo "Countdown to extinction..."

while [ $myvar -ge 0 ]; do
    echo $myvar
    myvar=$(( $myvar - 1 ))
    sleep 0.5
done

echo "Bye bye mammals."
