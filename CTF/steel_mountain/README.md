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
- 