### SMBClient

smbclient - ftp-like client to access SMB/CIFS resources on servers
```
smbclient -L 192.168.1.40
smbclient //192.168.1.40/guest
get file.txt

```

SMBClient

Because we're trying to access an SMB share, we need a client to access resources on servers. We will be using SMBClient because it's part of the default samba suite. While it is available by default on Kali and Parrot, if you do need to install it, you can find the documentation here.

We can remotely access the SMB share using the syntax:

```

smbclient //[IP]/[SHARE]

smbclient //<ip>/anonymous

smbclient -U username \\\\ip\\name_of_share

```

Followed by the tags:

-U [name] : to specify the user

-p [port] : to specify the port

Sample:
`smbclient -U milesdyson \\\\10.10.162.178\\milesdyson`

