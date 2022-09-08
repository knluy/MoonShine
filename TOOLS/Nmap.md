### Nmap

- nmap is an free, open-source and powerful tool used to discover hosts and services on a computer network.

```
nmap -sC -sV -oN nmap_results.txt <IP>
```

```
-sV Attempts to determine the version of the services running
-p <x> or -p- Port scan for port <x> or scan all ports
-Pn Disable host discovery and just scan for open ports
-A Enables OS and version detection, executes in-build scripts for further enumeration 
-sC Scan with the default nmap scripts
-v Verbose mode
-sU UDP port scan
-sS TCP SYN port scan
```

#### NMAP SAMBA

`nmap -p 445 --script=smb-enum-shares.nse,smb-enum-users.nse 10.10.150.254`

Note:

nmap scans all subnet first to check live hosts, then proceed with port scanning of every live hosts.



### Advanced Flags

Scan Type | Example Command

ARP Scan

`sudo nmap -PR -sn MACHINE_IP/24`

ICMP Echo Scan

`sudo nmap -PE -sn MACHINE_IP/24`

ICMP Timestamp Scan

`sudo nmap -PP -sn MACHINE_IP/24`

ICMP Address Mask Scan

`sudo nmap -PM -sn MACHINE_IP/24`

TCP SYN Ping Scan

`sudo nmap -PS22,80,443 -sn MACHINE_IP/30`

TCP ACK Ping Scan

`sudo nmap -PA22,80,443 -sn MACHINE_IP/30`

UDP Ping Scan

`sudo nmap -PU53,161,162 -sn MACHINE_IP/30`


Remember to add `-sn` if you are only interested in host discovery without port-scanning. Omitting `-sn` will let Nmap default to port-scanning the live hosts.

Option | Purpose

`-n`

no DNS lookup

`-R`

reverse-DNS lookup for all hosts

`-sn`

host discovery only