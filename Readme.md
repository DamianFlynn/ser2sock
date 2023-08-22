# Serial-to-TCP Bridge using Docker: ser2sock

ser2sock is a versatile utility that enables serial communication over TCP sockets, converting RS232 or RS485 data into a format suitable for network transmission. This repository provides a Dockerized version of ser2sock, allowing you to easily deploy and run the utility on various platforms, such as a Raspberry Pi with a USB-to-Serial adapter. This solution serves as an alternative to devices like Global Cache iTach, offering a cost-effective and customizable option for your serial communication needs.

## Purpose

The primary purpose of this project is to facilitate seamless serial communication over a network, bridging the gap between legacy serial devices and modern IP-based systems. By containerizing ser2sock, we aim to simplify the deployment process, making it accessible and convenient for users looking to establish serial communication channels without investing in specialized hardware.

Features:

- **Serial Communication:** ser2sock enables bidirectional communication with RS232 and RS485 serial devices, allowing you to interface with a wide range of equipment.
- **TCP Socket Conversion:** It converts serial data to TCP socket communication, enabling remote access and integration into networked systems.
- **Dockerized Deployment:** The provided Dockerfile allows you to build a containerized version of ser2sock, making it easy to set up and run on various platforms.
- **Customizable Configuration:** The environment variables in the Dockerfile can be modified to suit your specific requirements, including the listener port, baud rate, and more.

## Usage

To use this Dockerized `ser2sock` container, follow these steps:

Parameters


* SERIAL_DEVICE - The serial device to use (default: /dev/ttyUSB0)
* SERIAL_BAUD - The baud rate to use (default: 9600)

### Build the Docker Image:**
   
   ```bash
   docker build -t ser2sock .
   ```


### Docker Compose

Create a Docker Compose File

   ```yaml
   version: '3.8'
   
   services:
   
     # Serial port (RS232 to USB) to TCP 10001
     ser2sock:
       hostname: "ser2sock"
       image: ser2sock:latest
       container_name: ser2sock
       restart: unless-stopped
       ports:
         - 10001:10001
       environment:
         - "SERIAL_DEVICE=/dev/ttyUSB0" # Modify this to match your serial device
       volumes:
         - /dev/ttyUSB0:/dev/ttyUSB0   # Map the serial device to the container
       devices:
         - /dev/serial/by-id/usb-Prolific_Technology_Inc._USB-Serial_Controller_D-if00-port0:/dev/ttyUSB0 # Modify this to match your device
       privileged: true
   ```

Run the Docker Compose:

   ```bash
   # You may need to create the network first
   docker network create proxy

   # Start the Stack
   docker-compose up -d
   ```
### Docker

Run directly with

```
docker run -d --name ser2sock -p 10001:10001 -e SERIAL_DEVICE=/dev/ttyUSB0 ser2sock:latest
```


### Access Serial Data Over TCP

Once the container is up and running, you can connect to it using TCP sockets. For example, if you've configured the listener port as 10001, you can establish a connection to `localhost:10001` or the appropriate IP address and port combination.

**Note:** Please ensure that you modify the environment variables and settings in the Docker Compose file to match your specific hardware and configuration.

## Conclusion

The `ser2sock`` Dockerized solution offers a flexible and accessible way to enable serial communication over TCP sockets. By utilizing this repository, you can leverage the power of Docker to easily set up and deploy the ser2sock utility on a variety of devices, opening up new possibilities for integrating legacy serial devices into modern networked environments.


## Troubleshooting

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

