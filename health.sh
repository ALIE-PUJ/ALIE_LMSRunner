#!/bin/bash

if [[ $(curl http://127.0.0.1:1234/v1/models/ -fs | jq ".data | length") == 1 ]] ;
then exit 0; 
else exit -1; 
fi