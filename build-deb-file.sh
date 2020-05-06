#!/bin/sh
set -e -u

docker run -v $PWD:/out meeshkan/hmt-deb-builder
