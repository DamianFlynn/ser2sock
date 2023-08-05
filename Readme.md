# Serial to TCP/IP bridge

This is a simple serial to TCP/IP bridge. It is intended to be used with the C-Gate web server to allow it to communicate with a serial device.

## Usage

```
docker run -d --name serialbridge -p 10001:10001 -e SERIAL_DEVICE=/dev/ttyUSB0 damianflynn/serialbridge
```

## Environment variables

* SERIAL_DEVICE - The serial device to use (default: /dev/ttyUSB0)
* SERIAL_BAUD - The baud rate to use (default: 9600)
