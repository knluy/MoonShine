### RootMe

export IP: 10.10.43.146


Scan the machine, how many ports are open?

- port 44442 is not included since status is filtered

```
                                                                                                                      
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/RootMe]
└─$ nmap -sC -sV -oN nmap_results.txt 10.10.43.146 
Starting Nmap 7.92 ( https://nmap.org ) at 2022-08-18 08:27 EDT
Nmap scan report for 10.10.43.146
Host is up (0.66s latency).
Not shown: 997 closed tcp ports (conn-refused)
PORT      STATE    SERVICE         VERSION
22/tcp    open     ssh             OpenSSH 7.6p1 Ubuntu 4ubuntu0.3 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 4a:b9:16:08:84:c2:54:48:ba:5c:fd:3f:22:5f:22:14 (RSA)
|   256 a9:a6:86:e8:ec:96:c3:f0:03:cd:16:d5:49:73:d0:82 (ECDSA)
|_  256 22:f6:b5:a6:54:d9:78:7c:26:03:5a:95:f3:f9:df:cd (ED25519)
80/tcp    open     http            Apache httpd 2.4.29 ((Ubuntu))
|_http-title: HackIT - Home
| http-cookie-flags: 
|   /: 
|     PHPSESSID: 
|_      httponly flag not set
|_http-server-header: Apache/2.4.29 (Ubuntu)
44442/tcp filtered coldfusion-auth
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 97.26 seconds
                                                                                                                      
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/RootMe]

```

What version of Apache is running?
- 2.4.29


What service is running on port 22?
- ssh

