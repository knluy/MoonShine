### Gobuster

- GoBuster is a tool used to brute-force URIs (directories and files), DNS subdomains and virtual host names.

```
gobuster dir -u http://<ip>:port -w <word list location>
```


- -e Print the full URLs in your console
- -u The target URL
- -w Path to your wordlist
- -U and -P Username and Password for Basic Auth
- -p (x) Proxy to use for requests
- -c (http cookies) Specify a cookie for simulating your auth

Sample:

```
┌──(kali㉿kali)-[~]
└─$ gobuster dir -u "10.10.236.200" -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -o /home/kali/ken/MoonShine/CTF/LazyAdmin/gobuster_scan2.txt -t 64

```

