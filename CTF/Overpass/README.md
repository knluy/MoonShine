### Overpass

What happens when a group of broke Computer Science students try to make a password manager?
Obviously a perfect commercial success!


User Flag:
thm{65c1aaf000506e56996822c6281e6bf7}

nmap scan:

![](../../img/Pasted%20image%2020220825105132.png)

Port available: 22 and 80 (golang net/http server)

Further enumeration using gobuster:

![](../../img/Pasted%20image%2020220825105649.png)

We now have directories we can explore on the webpage. Tried to explore as below:

![](../../img/Pasted%20image%2020220825105538.png)

![](../../img/Pasted%20image%2020220825105551.png)

![](../../img/Pasted%20image%2020220825105605.png)

After that i download files pertaining to linuxOS, as well as the build script and the source code:

![](../../img/Pasted%20image%2020220825105701.png)

Opening /admin page, we are greeted by a fill up form:

![](../../img/Pasted%20image%2020220825105739.png)

Looks like we can't find any hints on the admin credentials. Hence, we tried to look at the source code:

![](../../img/Pasted%20image%2020220825105837.png)

Take a look the login.js. There is an if statement that says, if credentials are wrong, page will echo "incorrect credentials". Else, browser will create a session token. Therefore, we can abuse this by manually creating a sessionToken on the cookies's tab:

![](../../img/Pasted%20image%2020220825110036.png)

This is the part where I struggle the most. For now, once sessionTokens are provided and path is set to /, we can reload and see the admin user:

![](../../img/Pasted%20image%2020220825110424.png)

Now that we have the RSA pem key, we can crack these using john. Convert the RSA pem key first using ssh2john, then crack it away:

![](../../img/Pasted%20image%2020220825110712.png)

Now we have the ssh password, lets go ahead and login to get our first flag:

![](../../img/Pasted%20image%2020220825110829.png)


Root Flag:
thm{7f336f8c359dbac18d54fdd64ea753bb}

To capture the rootflag, since we cannot use sudo -l to check for previleges, we can use LinEnum as tool for enumeration. We can setup an http server on our machine to copy linenum.sh, like so:

![](../../img/Pasted%20image%2020220825111137.png)

After that, we run linenum to check for attack vectors that can lead us to root:

![](../../img/Pasted%20image%2020220825111415.png)

Out of the box, we can see under crontabs (jobs that can run on a specific time interval) that there is a curl that calls the website and specific page every minute. We can exploit this by overriding the /etc/hosts, change the host of the website from localhost to our Kali machine (since we have permissions to write /etc/hosts) and then create a fake path that leads to our buildscript.sh that we will inject a reverse shell payload using bash:

SETUP:

1. in our Kali box, we will setup a fake directory path by performing mkdir downloads/src/ and from there we will copy our buildscript.sh:
![](../../img/Pasted%20image%2020220825111818.png)
![](../../img/Pasted%20image%2020220825111835.png)

2. Opening our buildscript.sh file, we have checked that the reverse shell was written in bash. Inject your kalibox IP address as well as the port number of your liking:

![](../../img/Pasted%20image%2020220825111912.png)


3. Once done, we can to go james user and change overpass.thm parameters in /etc/hosts:

![](../../img/Pasted%20image%2020220825112034.png)

4. So now, everytime the crontab run jobs every minute, overpass.thm will call on our kali machine box IP (10.13.48.47), and NOT THE LOCALHOST:

5. setup your server and listener. On your default directory, use python3 -m http.server 80 and in another terminal, use netcat as listener:

![](../../img/Pasted%20image%2020220825112322.png)
6. Lastly, patiently wait for your low hanging fruit to pick and capture the root flag:

![](../../img/Pasted%20image%2020220825112403.png)

Congratulations! You have captured the flag.
For me this will be my most grittiest and the most grindiest CTF I have ever done, for the steps provided here are new to me and takes a steep lear