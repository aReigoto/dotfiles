#!/usr/bin/env bash

echo $( ( pipenv --py 2> /dev/null ) || ( whereis python ) )
