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


nmap scan:




As we can see, there are 2 ports open, ssh and http

Let's proceed with gobuster scan for further enumeration:

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




borg password
squidward



music_archive:$apr1$BpZ.Q.1m$F0qqPwHSOG50URuOVQTTn.



alex:S3cretP@s3





flag{Than5s_f0r_play1ng_H0p£_y0u_enJ053d}