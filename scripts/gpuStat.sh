#!/usr/bin/env bash

while true ; do
    echo
    ioreg -l |grep \"PerformanceStatistics\" | cut -d '{' -f 2 | tr '|' ',' | tr -d '}' | tr ',' '\n'|grep 'Temp\|Fan\|Clock'
    sleep 2
done
