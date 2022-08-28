### Skynet

export IP=10.10.68.81

#### Deploy and compromise the vulnerable machine!

What is Miles password for his emails?

nmap scan:

![](../../img/Pasted%20image%2020220827201706.png)

Gobuster scan:

![](../../img/Pasted%20image%2020220827203111.png)

Looking at the pages on the browser, almost all pages return nothing, except the /squirrelmail, where we need to login our credentials:


![](../../img/Pasted%20image%2020220827203156.png)

Looking for other vectors of attack, we observed the smb port is open. We will try to enumerate the port using smbmap:

![](../../img/Pasted%20image%2020220827203243.png)

There are 2 directories of interest, the anonymous and the milesdyson share. We will open both directories and get all information we can get:

Anonymous is easy to open since it does not use credentials:

![](../../img/Pasted%20image%2020220827203357.png)

Opening up attention.txt file (after we get all files from the share)

![](../../img/Pasted%20image%2020220827203429.png)

Opening up log1.txt:

![](../../img/Pasted%20image%2020220827203447.png)

Other logs provide no details.








