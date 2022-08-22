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

