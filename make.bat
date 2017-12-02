@echo off
set GOPATH=%~dp0
cd %~dp0
go fmt ./src/...
set version=0.13.0

echo.
echo ��ʼ����Windows 32λϵͳ�ĳ���
set GOOS=windows
set GOARCH=386
echo.
echo ��ʼ��������...
go build -o bin/%GOOS%/%version%/frps.exe ./src/cmd/frps
echo �������
echo.
echo ��ʼ����ͻ���...
go build -o bin/%GOOS%/%version%/frpc.exe ./src/cmd/frpc/main.go
echo �������
echo.

echo ��ʼ����Linux 32λϵͳ�ĳ���
set GOOS=linux
set GOARCH=386
echo.
echo ��ʼ��������...
go build -o bin/%GOOS%/%version%/frps ./src/cmd/frps/main.go
echo �������
echo.
echo ��ʼ����ͻ���...
go build -o bin/%GOOS%/%version%/frpc ./src/cmd/frpc/main.go
echo �������
echo.

echo ��ʼ����Linux armϵͳ�ĳ���
set GOOS=linux
set GOARCH=arm
echo.
echo ��ʼ��������...
go build -o bin/%GOOS%-%GOARCH%/%version%/frps ./src/cmd/frps/main.go
echo �������
echo.
echo ��ʼ����ͻ���...
go build -o bin/%GOOS%-%GOARCH%/%version%/frpc ./src/cmd/frpc/main.go
echo �������
echo.

echo ��ʼ����MAC 32λϵͳ�ĳ���
set GOOS=darwin
set GOARCH=386
echo.
echo ��ʼ��������...
go build -o bin/%GOOS%-%GOARCH%/%version%/frps ./src/cmd/frps/main.go
echo �������
echo.
echo ��ʼ����ͻ���...
go build -o bin/%GOOS%-%GOARCH%/%version%/frpc ./src/cmd/frpc/main.go
echo �������
echo.
echo �������˳�
pause>nul
