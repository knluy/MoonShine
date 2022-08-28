### Brooklyn_99

export IP=10.10.111.122


####  Deploy and get hacking

This room is aimed for beginner level hackers but anyone can try to hack this box. There are two main intended ways to root the box. If you find more dm me in discord at Fsociety2006.

User flag


Root flag

nmap scan:

![](../../img/Pasted%20image%2020220828040401.png)

ports open - 21 (ftp), 22 (ssh), and 80 (http)

We can see immediately that there is an ftp anon server, meaning, we can get any file hints there:

Login to FTP anon:

![](../../img/Pasted%20image%2020220828042434.png)

Once note_to_jake.txt was transferred to our local machine, we check its contents:

![](../../img/Pasted%20image%2020220828042518.png)

From there we can check that usernames are amy, jake and holt. We wil focus on Jake first.

Since usernames are already provided, and there is a hint that his password is weak, we can use hydra to brute force jake's password and login to ssh:

![](../../img/Pasted%20image%2020220828042649.png)

![](../../img/Pasted%20image%2020220828042701.png)

Jake is logged in, but user.txt is nowhere to be found. Lets check thoroughly:

![](../../img/Pasted%20image%2020220828042806.png)

As you can see, holt has the user.txt file and thus we capture the user flag.

Looking at sudo -l for privilege escalation, we can see that user jake has sudo privileges for /usr/bin/less:

![](../../img/Pasted%20image%2020220828042904.png)

We can abuse this and obtain root shell by using an arbitrary file (in our case, /etc/profile, as per GTFObins)

![](../../img/Pasted%20image%2020220828043011.png)

We can perform the following:

`sudo /usr/bin/less /etc/pr`

![](../../img/Pasted%20image%2020220828043042.png)










