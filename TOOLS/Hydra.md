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


