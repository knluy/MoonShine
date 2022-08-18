### Agent-sudo

export IP - 10.10.25.133

#### Author's Note

Welcome to another THM exclusive CTF room. Your task is simple, capture the flags just like the other CTF room. Have Fun!

If you are stuck inside the black hole, post on the forum or ask in the TryHackMe discord.


#### Enumerate

Enumerate the machine and get all the important information

How many open ports?
- 3

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Agent-sudo]
└─$ nmap -sC -sV -oN nmap_results.txt 10.10.25.133
Starting Nmap 7.92 ( https://nmap.org ) at 2022-08-18 10:28 EDT
Nmap scan report for 10.10.25.133
Host is up (0.71s latency).
Not shown: 990 closed tcp ports (conn-refused)
PORT      STATE    SERVICE  VERSION
21/tcp    open     ftp      vsftpd 3.0.3
22/tcp    open     ssh      OpenSSH 7.6p1 Ubuntu 4ubuntu0.3 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 ef:1f:5d:04:d4:77:95:06:60:72:ec:f0:58:f2:cc:07 (RSA)
|   256 5e:02:d1:9a:c4:e7:43:06:62:c1:9e:25:84:8a:e7:ea (ECDSA)
|_  256 2d:00:5c:b9:fd:a8:c8:d8:80:e3:92:4f:8b:4f:18:e2 (ED25519)
80/tcp    open     http     Apache httpd 2.4.29 ((Ubuntu))
|_http-title: Annoucement
|_http-server-header: Apache/2.4.29 (Ubuntu)
212/tcp   filtered anet
544/tcp   filtered kshell
2013/tcp  filtered raid-am
4004/tcp  filtered pxc-roid
8649/tcp  filtered unknown
15000/tcp filtered hydap
41511/tcp filtered unknown
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 212.52 seconds
                                                              
```

