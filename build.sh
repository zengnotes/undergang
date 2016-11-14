#!/bin/sh

ProjectPath=`pwd`
export GOPATH=$ProjectPath/vendor:$ProjectPath:$GOPATH
if [ -z "$1" ]
then
	echo "place select a version to build...\n\n"
	exit 1
fi

if [ "X$1" = "Xtest" ]
then
	go test test
	exit 0
fi

rm -f $ProjectPath/bin/*

cd $ProjectPath
echo  $1 "version building..."
go get github.com/Sirupsen/logrus
go get github.com/boivie/undergang/app
go get github.com/codegangsta/cli

##-gcflags "-N -l"
go build -ldflags "-X main._VERSION_=$1 "  -o ./bin/sshproxy ./src/cmd

if [ "X$1" = "Xonline" ]
then
cd $ProjectPath
./bin/sshproxy
else
cd $ProjectPath
./bin/sshproxy
fi

#调试的时候使用
echo  $1 "version build finish"
