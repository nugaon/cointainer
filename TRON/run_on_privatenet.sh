#!/bin/bash
#https://github.com/TRON-US/docker-tron-quickstart

docker run -ti --rm -p 8090:9090 --name tron-quickstart -e "defaultBalance=100000" -e "showQueryString=true" -e "showBody=true" -e "formatJson=true" trontools/quickstart
