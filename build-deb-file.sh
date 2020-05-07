#!/bin/sh
set -e -u

docker run --rm -v $PWD:/out meeshkan/hmt-deb-builder
