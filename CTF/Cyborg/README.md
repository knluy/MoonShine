### CYBORG

export IP=10.10.49.133

Please deploy the machine so you can get started. Please allow a few minutes to make sure all the services boot up. Good luck!

twitter: fieldraccoon


#### Compromise the System

Compromise the machine and read the user.txt and root.txt

Scan the machine, how many ports are open?


```
2

```




What service is running on port 22?

```
OpenSSH 7.2p2 Ubuntu 4ubuntu2.10 (Ubuntu Linux; protocol 2.0)
```



What service is running on port 80?

```
http
```


What is the user.txt flag?


[Nmap](../../TOOLS/Nmap.md) scan:

![](../../img/Pasted%20image%2020220824094314.png)

As we can see, there are 2 ports open, ssh and http

Let's proceed with [Gobuster](../../TOOLS/Gobuster.md) scan for further enumeration:

![](../../img/Pasted%20image%2020220824090117.png)

We have checked that there are also 2 pages, /admin and /etc. Let's explore those sites:

for /etc, we have checked a folder called squid. Lets explore:

![](../../img/Pasted%20image%2020220824090243.png)

There are 2 files, passwd and squid.conf. Opened passwd and we are greeted by a hash file:

![](../../img/Pasted%20image%2020220824090317.png)

`music_archive:$apr1$BpZ.Q.1m$F0qqPwHSOG50URuOVQTTn.`

Opened squid.conf:

![](../../img/Pasted%20image%2020220824090331.png)


This seems to be a configuration file for squid proxy. 
Looking back and exploring, we see an admin page that looks like this:

![](../../img/Pasted%20image%2020220824091324.png)

It says my backup 'music_archive' is safe. Seems confident.

Checking also on the Downloads page, there is an archive file that needs to download:

![](../../img/Pasted%20image%2020220824091439.png)

Save this and copy the file to your directory

To get Alex's password, we will crack the hash file using the hash and salts located on passwd page:

`music_archive:$apr1$BpZ.Q.1m$F0qqPwHSOG50URuOVQTTn.`

![](../../img/Pasted%20image%2020220824091602.png)

Cracking the hash using [John the Ripper](../../TOOLS/John%20the%20Ripper.md), we have a password:

![](../../img/Pasted%20image%2020220824091923.png)

Password: squidward

Looking back at the archive.tar file, we will try to extract these and enumerate further:

`tar -vxf archive.tar`

Exploring the directory extracted, we are stumbled by a README page:

![](../../img/Pasted%20image%2020220824092108.png)

![](../../img/Pasted%20image%2020220824092124.png)

It says : Borg Backup repository.

Looking at the internet further, we can learn how to use the borg backup repository:

![](../../img/Pasted%20image%2020220824092252.png)

We can install this repository using git or pip.

Once installed, we can check for ways to extract this archive.tar (since this file has the repository of Alex's files, documents, etc)

![](../../img/Pasted%20image%2020220824092449.png)

Using the syntax `borg extract /path/to/repo::my-files`, we can use this against alex's archive, like so:

![](../../img/Pasted%20image%2020220824092541.png)

We are asked for a password, lets try using the password cracked earlier:

![](../../img/Pasted%20image%2020220824092623.png)


Once done, we have now opened alex's directory on home/alex/. Further enumeration shows the user's password:

alex:S3cretP@s3

![](../../img/Pasted%20image%2020220824092740.png)

Voila! We can use this to login to alex's host using SSH and acquire a bash shell:

![](../../img/Pasted%20image%2020220824092917.png)

First flag: Done

Further enumeration for privilege escalation using sudo -l (see [Privilege Escalation Tools](../../TOOLS/Privilege%20Escalation%20Tools.md)gives us a file that can run as root:

![](../../img/Pasted%20image%2020220824093018.png)

Opening file /etc/mp3backups/backup.sh and upon understanding at the end of the code, we can perform any commands here:

![](../../img/Pasted%20image%2020220824093113.png)

We can further escalate this by calling the binary and then perform -c for command and "chmod +s /bin/bash", like so:


`sudo /etc/mp3backups/backup.sh -c "chmod +s /bin/bash"
 `
![](../../img/Pasted%20image%2020220824093306.png)

Once done, perform bash -p to obtain a shell.

Further checking using whoami shows we are now root. We can now capture the root flag:

![](../../img/Pasted%20image%2020220824093359.png)


Flag: flag{Than5s_f0r_play1ng_H0p£_y0u_enJ053d}



END