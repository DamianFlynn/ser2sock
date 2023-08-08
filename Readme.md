# Serial to TCP/IP bridge

This is a simple serial to TCP/IP bridge. It is intended to be used with the C-Gate web server to allow it to communicate with a serial device.

## Usage

```
docker run -d --name serialbridge -p 10001:10001 -e SERIAL_DEVICE=/dev/ttyUSB0 damianflynn/serialbridge
```

## Docker Compose

Network

```sh
docker network create proxy
```

## Docker Permissions

Your host maybe restricting who can use the serial interface

Problem
`Cannot open /dev/ttyUSB0: Permission denied` error is caused by the user not having access to the serial ports. 
More specifically, the user is not in the `dialout` group.

Solution
```sh
sudo usermod -a -G dialout $USER
```

For anyone who likes knowing what they're running before they run it:
usermod - modify a user account
-a - add the user to supplementary groups
-G - a list of supplementary groups (man page says to use -a only with -G)
dialout - group that controls access to serial ports (and other hardware too)
$USER - Bash variable containing current username (not a builtin, usually automatically set env variable)

## Environment variables

* SERIAL_DEVICE - The serial device to use (default: /dev/ttyUSB0)
* SERIAL_BAUD - The baud rate to use (default: 9600)
