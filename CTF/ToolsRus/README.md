### ToolsRus

export IP=10.10.74.173

Your challenge is to use the tools listed below to enumerate a server, gathering information along the way that will eventually lead to you taking over the machine.

This task requires you to use the following tools:

Dirbuster
Hydra
Nmap
Nikto
Metasploit

What directory can you find, that begins with a "g"?

- guidelines


Whose name can you find from this directory?

- bob 

![](../../img/Pasted%20image%2020220826070002.png)

What directory has basic authentication?

- protected

![](../../img/Pasted%20image%2020220826065903.png)

What is bob's password to the protected part of the website?

- bubbles

Using hydra, use the syntax `hydra -l bob -P /usr/share/wordlists/rockyou.txt -t 4 10.10.87.93 http-get /protected -V `

![](../../img/Pasted%20image%2020220826070316.png)

![](../../img/Pasted%20image%2020220826070324.png)

What other port that serves a webs service is open on the machine?
- 1234


Going to the service running on that port, what is the name and version of the software?

Answer format: Full_name_of_service/Version

- Apache Tomcat/7.0.88


Use Nikto with the credentials you have found and scan the /manager/html directory on the port found above.

How many documentation files did Nikto identify?
- 5
![](../../img/Pasted%20image%2020220826070430.png)

What is the server version (run the scan against port 80)?

- Apache/2.4.18

What version of Apache-Coyote is this service using?

- 1.1

![](../../img/Pasted%20image%2020220826065706.png)

Use Metasploit to exploit the service and get a shell on the system.

What user did you get a shell as?
- root

![](../../img/Pasted%20image%2020220826070505.png)

What text is in the file /root/flag.txt
 - ff1fc4a81affcc7688cf89ae7dc6e0e1

![](../../img/Pasted%20image%2020220826070522.png)

END