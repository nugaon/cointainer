#!/bin/sh
while test $# -gt 0
do
    case "$1" in
        --v) VERSION="$2"
			 echo "Setting version to "${VERSION}
            ;;
        --build) echo "building..."
				if [ -z "$VERSION" ]
					then
					docker build -t nemesgyadam/capricoin-core .
				else
					docker build -t nemesgyadam/capricoin-core --build-arg CAPRICOIN_VERSION=${VERSION} .
				fi
            ;;
        --*) echo "bad option $1"
            ;;
        
    esac
    shift
	done
if [ -z $(docker images -q nemesgyadam/capricoin-core) ] 
then
	echo "Can't find image, building..."
	if [ -z "$VERSION" ]
					then
					docker build -t nemesgyadam/capricoin-core .
				else
					docker build -t nemesgyadam/capricoin-core --build-arg CAPRICOIN_VERSION=${VERSION} .
				fi
	fi
cp Capricoin.conf ~/capricoin/Capricoin.conf
docker run -v /home/ubuntu/capricoin:/home/ubuntu/capricoin -d --rm --network host --name capricoin-node nemesgyadam/capricoin-core
