#!/usr/bin/env bash

echo $(arp | grep -i "${caveMAC}" | perl -lane 'print "$F[0]"')
