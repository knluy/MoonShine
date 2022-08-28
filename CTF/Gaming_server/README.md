### Gaming Server

export IP=10.10.3.50

Can you gain access to this gaming server built by amateurs with no experience of web development and take advantage of the deployment system.


What is the user flag?


What is the root flag?



nmap scan:

![](../../img/Pasted%20image%2020220828012352.png)

Per checking, we only have 2 ports, ssh and http

Visiting the webpage, we are greeted on the homepage:

![](../../img/Pasted%20image%2020220828012437.png)

Performing gobuster scan reveals that there are secret pages inside:

dict.list

![](../../img/Pasted%20image%2020220828012737.png)


