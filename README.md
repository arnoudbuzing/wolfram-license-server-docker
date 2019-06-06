# Wolfram License Server for Docker

## Introduction

This runs the Wolfram License Server (also known as MathLM) on Docker.

## Build

To build, run the following command:

```
docker build -t arnoudbuzing/wolfram-license-server .
```

## Running the Wolfram License Server

To run, do the following:

```
docker run -P --volume D:/github/wolfram-license-server-docker/mathpass:/wolfram/mathpass arnoudbuzing/wolfram-license-server
```

Notes:

1. The `-P` option binds the license server ports (16286 and 16287)
2. The `--volume` makes the `mathpass` file available from the host machine to the Docker image.
3. The `mathpass` file content is provided by Wolfram Research to licensed users.

If successful the Wolfram License Server will start and listen for incoming connections:

```
f74b8ac45a09 - root [06/Jun/2019:17:13:59] "MathLM 12.0 executable launched" "/wolfram/mathlm" -
f74b8ac45a09 - root [06/Jun/2019:17:13:59] "Default (Common Logfile Format) log format specified" "%h3 - %u2 [%d/%m2/%y2:%t2] %q%e2%q %q%r2%q -" -
f74b8ac45a09 - root [06/Jun/2019:17:13:59] "Logfile specified" "None" -
f74b8ac45a09 - root [06/Jun/2019:17:13:59] "Verbosity level specified" "4" -
f74b8ac45a09 - root [06/Jun/2019:17:13:59] "Logging verbosity level specified" "1" -

Online help is available at
http://reference.wolfram.com/network

f74b8ac45a09 - root [06/Jun/2019:17:13:59] "Password file specified" "/wolfram/mathpass" -

Jun 6 17:13:59:
Cannot get "tcp" protocol entry.
f74b8ac45a09 - root [06/Jun/2019:17:13:59] "Binding IPv6 socket" "Success.  Socket 16287 taken." -
f74b8ac45a09 - root [06/Jun/2019:17:13:59] "Binding IPv4 socket" "Success.  Socket 16286 taken." -
f74b8ac45a09 - root [06/Jun/2019:17:13:59] "Creating license table" "Success" -
f74b8ac45a09 - root [06/Jun/2019:17:13:59] "Binding to socket" "Success.  Socket 16286 taken." -
f74b8ac45a09 - root [06/Jun/2019:17:13:59] "Hostname" "f74b8ac45a09" -
f74b8ac45a09 - root [06/Jun/2019:17:13:59] "PID" "1" -

Mathematica Class B processes:
20 MathKernel processes authorized; 0 in use.
20 Mathematica processes authorized; 0 in use.
100 Sub MathKernel processes authorized; 0 in use.
100 Sub Mathematica processes authorized; 0 in use.
```

## Connecting to the Wolfram License Server

On the client machine, create a `mathpass` file under `$UserBaseDirectory/Licensing` and add the following line to point to the license server:

```
!172.17.0.2
```

The actual ip address is the ip address for the Docker image that is running. Use:

```
docker ps
```

to find the container id:

```
CONTAINER ID        IMAGE                                 COMMAND                  CREATED             STATUS              PORTS                                                NAMES
861d59d77a76        arnoudbuzing/wolfram-license-server   "/wolfram/mathlm -pwÎíÎõ"   43 minutes ago      Up 43 minutes       0.0.0.0:32791->16286/tcp, 0.0.0.0:32790->16287/tcp   blissful_kepler
```

and use the container id or the container name to find the actual network ip address where the Wolfram License Server is running:

```
docker inspect blissful_kepler
```

and look for the line with the IPAddress:

```
"IPAddress": "172.17.0.2"
```

Note: On a Windows host you may need to route the traffic as follows (for a client to be able to find the server):

```
route /P add 172.17.0.0 MASK 255.255.0.0 10.0.75.2
```

See: https://github.com/docker/for-win/issues/221 , for more details.

Next, launch a Wolfram Language kernel and evaluate `$LicenseServer` to confirm it connected properly to the server:

```
PS C:\Users\arnoudb.WRI> & 'C:\Program Files\Wolfram Research\Mathematica\12.0\wolfram.exe'
Mathematica 12.0.0 Kernel for Microsoft Windows (64-bit)
Copyright 1988-2019 Wolfram Research, Inc.

In[1]:= $LicenseServer

Out[1]= 172.17.0.2
```

On the server side, a message is also printed:

```
10.0.75.1 - arnoudb [06/Jun/2019:17:25:39] "Reading client packet" "Success" -
10.0.75.1 - arnoudb [06/Jun/2019:17:25:39] "Kernel License requested" "License #1 granted" -
10.0.75.1 - arnoudb [06/Jun/2019:17:25:39] "Writeback attempt" "Success" -
```

Quit the kernel:

```
PS C:\Users\arnoudb.WRI> & 'C:\Program Files\Wolfram Research\Mathematica\12.0\wolfram.exe'
Mathematica 12.0.0 Kernel for Microsoft Windows (64-bit)
Copyright 1988-2019 Wolfram Research, Inc.

In[1]:= $LicenseServer

Out[1]= 172.17.0.2

In[2]:= Quit
PS C:\Users\arnoudb.WRI>
```

The server will print a message that the license is returned:

```
10.0.75.1 - arnoudb [06/Jun/2019:17:27:47] "Reading client packet" "Success" -
10.0.75.1 - arnoudb [06/Jun/2019:17:27:47] "Kernel License returned" "License #1 accepted" -
10.0.75.1 - arnoudb [06/Jun/2019:17:27:47] "Writeback attempt" "Success" -
```





