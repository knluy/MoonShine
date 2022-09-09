### Nmap

- nmap is an free, open-source and powerful tool used to discover hosts and services on a computer network.

```
nmap -sC -sV -oN nmap_results.txt <IP>
```

Option | Purpose
-|-
`-sV `|Attempts to determine the version of the services running
-p &lt;x&gt; or -p- | Port scan for port &lt;x&gt; or scan all ports
`-Pn` | Disable host discovery and just scan for open ports
`-A `|  Enables OS and version detection, executes in-build scripts for further enumeration 
`-sC` | Scan with the default nmap scripts
`-v `| Verbose mode
`-sU` | UDP port scan
`-sS` | TCP SYN port scan


#### NMAP SAMBA

`nmap -p 445 --script=smb-enum-shares.nse,smb-enum-users.nse 10.10.150.254`

Note:

nmap scans all subnet first to check live hosts, then proceed with port scanning of every live hosts.

### Advanced Flags

Scan Type | Example Command
	-|-
	ARP Scan | `sudo nmap -PR -sn MACHINE_IP/24`
	ICMP Echo Scan | `sudo nmap -PE -sn MACHINE_IP/24`
	ICMP Timestamp Scan | `sudo nmap -PP -sn MACHINE_IP/24`
	ICMP Address Mask Scan | `sudo nmap -PM -sn MACHINE_IP/24`
	TCP SYN Ping Scan | `sudo nmap -PS22,80,443 -sn MACHINE_IP/30`
	TCP ACK Ping Scan | `sudo nmap -PA22,80,443 -sn MACHINE_IP/30`
	UDP Ping Scan | `sudo nmap -PU53,161,162 -sn MACHINE_IP/30`
	 
Remember to add `-sn` if you are only interested in host discovery without port-scanning. Omitting `-sn` will let Nmap default to port-scanning the live hosts.

Option | Purpose
-|-
`-n` | no DNS lookup
`-R` | reverse-DNS lookup for all hosts
`-sn` | host discovery only


### Port Scan Type

Example | Command
-|-
TCP Connect Scan | `nmap -sT 10.10.201.235`
TCP SYN Scan | `sudo nmap -sS 10.10.201.235`
UDP Scan | `sudo nmap -sU 10.10.201.235`

These scan types should get you started discovering running TCP and UDP services on a target host.

Option | Purpose
-|-
`-p-` | all ports
`-p1-1023` | scan ports 1 to 1023
`-F` | 100 most common ports
`-r` | scan ports in consecutive order
`-T<0-5>` | -T0 being the slowest and T5 the fastest
`--max-rate 50` | rate <= 50 packets/sec
`--min-rate 15` | rate >= 15 packets/sec
`--min-parallelism 100` | at least 100 probes in parallel


Port Scan Type | Example Command
-|-
TCP Null Scan | `sudo nmap -sN 10.10.141.133`
TCP FIN Scan | `sudo nmap -sF 10.10.141.133`
TCP Xmas Scan | `sudo nmap -sX 10.10.141.133`
TCP Maimon Scan | `sudo nmap -sM 10.10.141.133`
TCP ACK Scan | `sudo nmap -sA 10.10.141.133`
TCP Window Scan | `sudo nmap -sW 10.10.141.133`
Custom TCP Scan | `sudo nmap --scanflags URGACKPSHRSTSYNFIN 10.10.141.133`
Spoofed Source IP | `sudo nmap -S SPOOFED_IP 10.10.141.133`
Spoofed MAC Address | `--spoof-mac SPOOFED_MAC`
Decoy Scan | `nmap -D DECOY_IP,ME 10.10.141.133`
Idle (Zombie) Scan | `sudo nmap -sI ZOMBIE_IP 10.10.141.133`
Fragment IP data into 8 bytes | `-f`
Fragment IP data into 16 bytes | `-ff`


Option | Purpose
-|-
`--source-port PORT_NUM`  | specify source port number
`--data-length NUM` | append random data to reach given length

These scan types rely on setting TCP flags in unexpected ways to prompt ports for a reply. Null, FIN, and Xmas scan provoke a response from closed ports, while Maimon, ACK, and Window scans provoke a response from open and closed ports.


Option | Purpose
-|-
`--reason` | explains how Nmap made its conclusion
`-v` | verbose
`-vv` | very verbose
`-d` | debugging
`-dd` | more details for debugging
