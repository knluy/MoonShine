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



