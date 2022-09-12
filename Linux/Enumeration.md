### Enumeration


hostname

![](../img/Pasted%20image%2020220912083702.png)

uname -a

![](../img/Pasted%20image%2020220912083730.png)

/proc/version

![](../img/Pasted%20image%2020220912083847.png)

/etc/issue

![](../img/Pasted%20image%2020220912083923.png)

ps

![](../img/Pasted%20image%2020220912084841.png)

env

![](../img/Pasted%20image%2020220912090134.png)

ps -A

![](../img/Pasted%20image%2020220912090346.png)

ps axjf

![](../img/Pasted%20image%2020220912090429.png)

ps aux

![](../img/Pasted%20image%2020220912090528.png)

sudo -l

![](../img/Pasted%20image%2020220912090612.png)

ls -la

![](../img/Pasted%20image%2020220912091404.png)

id
![](../img/Pasted%20image%2020220912091431.png)

/etc/passwd

![](../img/Pasted%20image%2020220912091505.png)

pwede ring cat /etc/passwd | cut -d ";" -f 1

![](../img/Pasted%20image%2020220912092432.png)

history

![](../img/Pasted%20image%2020220912092509.png)

ifconfig /ip route

![](../img/Pasted%20image%2020220912092606.png)

netstat

other commands:
- netstat -a
- netstat -at
- netstat -au
- netstat -l (list ports)
- netstat -s (list network usage by statistics)
- netstat -tp (list connections)
- netstat -i (interface statistics)

In most blogs, they use netstat -ano

-   `-a`: Display all sockets
-   `-n`: Do not resolve names
-   `-o`: Display timers

![](../img/Pasted%20image%2020220912094757.png)

find

`find . -name flag1.txt`: find the file named “flag1.txt” in the current directory
`find /home -name flag1.txt`: find the file names “flag1.txt” in the /home directory
`find / -type d -name config`: find the directory named config under “/”
 `find / -type f -perm 0777`: find files with the 777 permissions (files readable, writable, and executable by all users)
 `find / -perm a=x`: find executable files
`find /home -user frank`: find all files for user “frank” under “/home”
 `find / -mtime 10`: find files that were modified in the last 10 days
`find / -atime 10`: find files that were accessed in the last 10 day
 `find / -cmin -60`: find files changed within the last hour (60 minutes)
`find / -amin -60`: find files accesses within the last hour (60 minutes)
`find / -size 50M`: find files with a 50 MB size