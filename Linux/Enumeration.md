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

Command | Purpose
-|-
`find . -name flag1.txt` | find the file named “flag1.txt” in the current directory
`find /home -name flag1.txt` | find the file names “flag1.txt” in the /home directory
`find / -type d -name config` | find the directory named config under “/”
`find / -type f -perm 0777` | find files with the 777 permissions (files readable, writable, and executable by all users)
`find / -perm a=x` | find executable files
`find /home -user frank` | find all files for user “frank” under “/home”
`find / -mtime 10` | find files that were modified in the last 10 days
`find / -atime 10` | find files that were accessed in the last 10 day
`find / -cmin -60` | find files changed within the last hour (60 minutes)
`find / -amin -60` | find files accesses within the last hour (60 minutes)
`find / -size 50M` | find files with a 50 MB size

This command can also be used with (+) and (-) signs to specify a file that is larger or smaller than the given size.

Folders and files that can be written to or executed from:

-   `find / -writable -type d 2>/dev/null` : Find world-writeable folders
-   `find / -perm -222 -type d 2>/dev/null`: Find world-writeable folders
-   `find / -perm -o w -type d 2>/dev/null`: Find world-writeable folders

Find development tools and supported languages:

-   `find / -name perl*`
-   `find / -name python*`
-   `find / -name gcc*`

Find specific file permissions:

Below is a short example used to find files that have the SUID bit set. The SUID bit allows the file to run with the privilege level of the account that owns it, rather than the account which runs it. This allows for an interesting privilege escalation path,we will see in more details on task 6. The example below is given to complete the subject on the “find” command.

-   `find / -perm -u=s -type f 2>/dev/null`: Find files with the SUID bit, which allows us to run the file with a higher privilege level than the current user.

### General Linux Commands

As we are in the Linux realm, familiarity with Linux commands, in general, will be very useful. Please spend some time getting comfortable with commands such as `find`, `locate`, `grep`, `cut`, `sort`, etc.