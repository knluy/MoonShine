### SCP

scp — OpenSSH secure file copy

scp copies files between hosts on a network.

It uses ssh(1) for data transfer, and uses the same authentication and provides the same security as a login session.

scp will ask for passwords or passphrases if they are needed for authentication.

Syntax:

#### Copy a Local File to a Remote System with the scp Command

To copy a file from a local to a remote system run the following command:

`scp file.txt remote_username@10.10.0.2:/remote/directory`

scp file_from_local file_to_remote


#### Transferring Files From Your Host - SCP (SSH)

`scp important.txt ubuntu@192.168.1.30:/home/ubuntu/transferred.txt`

Variable | Value
-|-
The IP address of the remote system | 192.168.1.30
User on the remote system | ubuntu
Name of the file on the local system | important.txt
Name that we wish to store the file as on the remote system | transferred.txt


#### Reverse

`scp ubuntu@192.168.1.30:/home/ubuntu/documents.txt notes.txt`

Variable | Value
-|-
IP address of the remote system | 192.168.1.30
User on the remote system | ubuntu
Name of the file on the remote system | documents.txt
Name that we wish to store the file as on our system | notes.txt


#### Scan OS and Version | Output

Option | Meaning
-|-
`-sV` | determine service/version info on open ports
`-sV --version-light` | try the most likely probes (2)
`-sV --version-all` | try all available probes (9)
`-O` | detect OS
`--traceroute` | run traceroute to target
`--script=SCRIPTS` | Nmap scripts to run
`-sC` or `--script=default` | run default scripts
`-A` | equivalent to `-sV -O -sC --traceroute`
`-oN` | save output in normal format
`-oG` | save output in grepable format
`-oX` | save output in XML format
`-oA` | save output in normal, XML and Grepable formats
