#!/bin/bash
cd ~
#下载go-mips32源 
rm -rf go-mips32
git clone https://github.com/nwct/go-mips32.git
cd ./go-mips32/src

#配置GO编译参数 
export GOOS=linux 
export GOARCH=mips32le

#执行编译
./make.bash 
cd ..

#创建编译后文件存放文件夹 
rm -rf /opt/mipsgo
sudo mkdir /opt/mipsgo

#复制 
sudo cp -R * /opt/mipsgo

#下载frp源 
cd /root/
git clone https://github.com/nwct/frpu-mips32le.git
cd ./frpu-mips32le

#配置GO编译参数 
export GOPATH=/root/frpu-mips32le
export GOOS=linux 
export GOARCH=mips32le
export GOROOT=/opt/mipsgo 
export PATH=/opt/mipsgo/bin:$PATH

#执行编译
go fmt ./src/...
go build -o bin/linux-mips32le/frps ./src/cmd/frps
go build -o bin/linux-mips32le/frpc ./src/cmd/frpc
