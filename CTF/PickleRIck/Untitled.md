### Vulnversity

`export IP: 10.10.189.12`

#### Deploy the Machine

Connect to our network and deploy this machine. If you are unsure on how to get connected, complete the OpenVPN room first.


Deploy the machine
Ans. No answer needed


#### Reconaissance

Scan this box: `nmap -sV <machines ip>`


nmap is an free, open-source and powerful tool used to discover hosts and services on a computer network. In our example, we are using nmap to scan this machine to identify all services that are running on a particular port. nmap has many capabilities, below is a table summarising some of the functionality it provides.

There are many nmap "cheatsheets" online that you can use too.


Scan the box, how many ports are open?
Ans. 

```


```



What version of the squid proxy is running on the machine?
Ans. 

```



```

How many ports will nmap scan if the flag -p-400 was used?
Ans. 

```


```

Using the nmap flag -n what will it not resolve?
Ans. 

```


```

What is the most likely operating system this machine is running?

```



```

What port is the web server running on?

```


```


Its important to ensure you are always doing your reconnaissance thoroughly before progressing. Knowing all open services (which can all be points of exploitation) is very important, don't forget that ports on a higher range might be open so always scan ports after 1000 (even if you leave scanning in the background)


#### Locating directories using GoBuster