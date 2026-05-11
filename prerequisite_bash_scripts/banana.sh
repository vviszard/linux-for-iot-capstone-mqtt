#!/bin/bash

echo "this is the output of $0"
topic=$1
interval=$2
echo "publishing topic: $topic at $interval seconds"
echo "there are total $# arguments passed"
echo "these arguments are as follows: $@"
