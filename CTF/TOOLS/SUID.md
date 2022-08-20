### SUID


![[Pasted image 20220816003128.png]]


Permission	On Files	On Directories
SUID Bit	User executes the file with permissions of the file owner	-
SGID Bit	User executes the file with the permission of the group owner.
File created in directory gets the same group owner.
Sticky Bit	No meaning	Users are prevented from deleting files from other users.


`find / -perm -u=s -type f 2>/dev/null`