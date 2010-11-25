#!/bin/bash

start=$(date +%s)

curl http://www.example.com

stop=$(date +%s)

let total_time=stop-start

echo $total_time

