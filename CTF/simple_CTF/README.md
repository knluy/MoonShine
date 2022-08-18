### simple_CTF

export IP: 10.10.170.151

Deploy the machine and attempt the questions!


How many services are running under port 1000?
- 2 

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/simple_CTF]
└─$ nmap -sC -sV -vv -oN nmap_results.txt 10.10.170.151
Starting Nmap 7.92 ( https://nmap.org ) at 2022-08-17 10:18 EDT
Scanned at 2022-08-17 10:18:31 EDT for 73s
Not shown: 997 filtered tcp ports (no-response)
PORT     STATE SERVICE REASON  VERSION
21/tcp   open  ftp     syn-ack vsftpd 3.0.3
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to ::ffff:10.2.77.171
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 4
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_Can't get directory listing: TIMEOUT
80/tcp   open  http    syn-ack Apache httpd 2.4.18 ((Ubuntu))
| http-robots.txt: 2 disallowed entries 
|_/ /openemr-5_0_1_3 
|_http-title: Apache2 Ubuntu Default Page: It works
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Apache/2.4.18 (Ubuntu)
2222/tcp open  ssh     syn-ack OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 29:42:69:14:9e:ca:d9:17:98:8c:27:72:3a:cd:a9:23 (RSA)
| ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCj5RwZ5K4QU12jUD81IxGPdEmWFigjRwFNM2pVBCiIPWiMb+R82pdw5dQPFY0JjjicSysFN3pl8ea2L8acocd/7zWke6ce50tpHaDs8OdBYLfpkh+OzAsDwVWSslgKQ7rbi/ck1FF1LIgY7UQdo5FWiTMap7vFnsT/WHL3HcG5Q+el4glnO4xfMMvbRar5WZd4N0ZmcwORyXrEKvulWTOBLcoMGui95Xy7XKCkvpS9RCpJgsuNZ/oau9cdRs0gDoDLTW4S7OI9Nl5obm433k+7YwFeoLnuZnCzegEhgq/bpMo+fXTb/4ILI5bJHJQItH2Ae26iMhJjlFsMqQw0FzLf
|   256 9b:d1:65:07:51:08:00:61:98:de:95:ed:3a:e3:81:1c (ECDSA)
| ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBM6Q8K/lDR5QuGRzgfrQSDPYBEBcJ+/2YolisuiGuNIF+1FPOweJy9esTtstZkG3LPhwRDggCp4BP+Gmc92I3eY=
|   256 12:65:1b:61:cf:4d:e5:75:fe:f4:e8:d4:6e:10:2a:f6 (ED25519)
|_ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2I73yryK/Q6UFyvBBMUJEfznlIdBXfnrEqQ3lWdymK
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Nmap done: 1 IP address (1 host up) scanned in 73.49 seconds
                                                                                                                      
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/simple_CTF]
└─$ 


```


What is running on the higher port?
- ssh

What's the CVE you're using against the application?
- CVE-2019-9053

- using gobuster, we can check that there is another page linking to a site:

```

┌──(kali㉿kali)-[~]
└─$ gobuster dir -u "http://10.10.170.151:80" -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -o /home/kali/ken/MoonShine/CTF/simple_CTF/http_enum.txt
===============================================================
Gobuster v3.1.0
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://10.10.170.151:80
[+] Method:                  GET
[+] Threads:                 10
[+] Wordlist:                /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.1.0
[+] Timeout:                 10s
===============================================================
2022/08/17 10:51:26 Starting gobuster in directory enumeration mode
===============================================================
/simple               (Status: 301) [Size: 315] [--> http://10.10.170.151/simple/]
Progress: 21282 / 220561 (9.65%)                                                 ^C
[!] Keyboard interrupt detected, terminating.
                                                                                  
===============================================================
2022/08/17 11:05:31 Finished
===============================================================
                                                                                                                      
┌──(kali㉿kali)-[~]
└─$ 

```

![[Pasted image 20220817110557.png]]

![[Pasted image 20220817110606.png]]

- upon checking on CMS Made Simple version 2.2.8, a vulnerability was found

![[Pasted image 20220817110644.png]]

---

new machine IP: 10.10.134.118

10.10.134.118

Using the enumeration acquired:

nmap - found port 80
gobuster - found /simple and CMS Made Simple version 2.2.8,
google - found  CVE-2019-9053

we can check that there is a python script for exploit. We will use that:

```

┌──(kali㉿kali)-[~]
└─$ cd ken/CVE-2019-9053           
                                                                                                                       
┌──(kali㉿kali)-[~/ken/CVE-2019-9053]
└─$ ls
exploit.py  README.md
                                                                                                                       
┌──(kali㉿kali)-[~/ken/CVE-2019-9053]
└─$ 


```

