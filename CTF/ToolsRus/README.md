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




Whose name can you find from this directory?


What directory has basic authentication?




What is bob's password to the protected part of the website?



What other port that serves a webs service is open on the machine?



Going to the service running on that port, what is the name and version of the software?

Answer format: Full_name_of_service/Version


Use Nikto with the credentials you have found and scan the /manager/html directory on the port found above.

How many documentation files did Nikto identify?


What is the server version (run the scan against port 80)?



What version of Apache-Coyote is this service using?



Use Metasploit to exploit the service and get a shell on the system.

What user did you get a shell as?



What text is in the file /root/flag.txt
