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

Take a look the login.js. There is an if statement that says, if credentials are wrong, page will echo "incorrect credentials". Else, browser will create a session token. Therefore, we can abuse this by manually creating a sessionToken on the debugger

Root Flag:
thm{7f336f8c359dbac18d54fdd64ea753bb}
