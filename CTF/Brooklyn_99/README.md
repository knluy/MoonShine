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

From there we can check that usernames are amy, jake and holt. We wil focus on Jake first:







