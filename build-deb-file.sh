#!/bin/sh
set -e -u

docker run -v $PWD:/out fredrikfornwall/hmt-deb-builder
