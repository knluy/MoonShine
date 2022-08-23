### How to Hack PLDTWIFI Default Credetials


#### Requirements

1. TPLink AC600 (or any relevant wifi adapter) that can enable monitor mode.
	1. Other wifi adapters include: Alfa AWUS036ACH, Panda PAU05

![[Pasted image 20220823063011.png]]

2. Kali Linux Distro, or any other Linux Distro
3. Windows powershell


#### Steps

1. Open Linux OS in a virtual machine setting (using vmware, or  virtualbox). Then login to the machine and spawn a terminal, like so:

![[Pasted image 20220823063319.png]]

![[Pasted image 20220823063333.png]]

2. Check if the wifi adapter is connected and enabled in the machine. If you are using vmware workstation, you may check the status of the wifi adapter below, and status must be connected:

![[Pasted image 20220823063501.png]]
3. Check if the wireless interface is up. On the terminal, type `lsusb`  and `iwconfig` to verify, like so:

![[Pasted image 20220823063623.png]]
	As you can see, in our case, the bus 001 device is registered as Realtek RTL8811AU [Archer T2U Nano]. Further verification on iwconfig shows wlan0 interface with Mode: Managed.

4. Prepare the tools needed for the attack. The tools are the following:
	1. Check if repositories are updated. Perform `sudo apt-get update`
	   ![[Pasted image 20220823064450.png]]
	2. Perform repositories upgrade. Use `sudo apt-get upgrade`
	   ![[Pasted image 20220823064609.png]]
	3. airmon-ng - this is natively installed on Kali. Otherwise, perform `sudo apt-get install airmon-ng` to install the package.
	   
	4. hcxdumptool - perform `sudo apt-get install hcxdumptool`, like so. If there is no repository, you can perform `git clone https://github.com/ZerBea/hcxdumptool`
	   ![[Pasted image 20220823064901.png]]
	5. hcxpcapngtool - perform `sudo apt-get install hcxpcapngtool`, like so. If there is no repository, you can perform `git clone https://github.com/ZerBea/hcxtools`
	   ![[Pasted image 20220823065142.png]]
	6. airodump-ng - this is also native in Kali, however if you dont have this repository, perform `sudo apt-get install airodump-ng`
	7. hashcat - perform `sudo apt-get install hashcat` on Linux and go to https://hashcat.net/hashcat/ on Windows.
	   ![[Pasted image 20220823065204.png]]
5. Enable Wifi adapter in Monitor Mode. You can do this by performing `sudo airmon-ng check kill` first, then `sudo airmon-ng start wlan0`, like so
	   ![[Pasted image 20220823065350.png]]
	   As you can see, after performing the syntax, upon performing `iwconfig`, the mode changed from "Managed" to "Monitor".

6. Perform reconaissance. Use the syntax `sudo airodump-ng wlan0` to scan for other wireless adapters:

	Another helpful tip: you can use `sudo airodump-ng wlan0 --band a` to scan 5GHz wifi adapters:
	
	![[Pasted image 20220823070005.png]]

	The SSID that we will be attacking: PLDTHOMEFIBR5GBCRxh.
	Also, take note of the mac address. We will be using this later.

7. Perform further enumeration to filter only the mac address of the attacking router. Use `sudo airodump-ng wlan0 --band a -d 24:91:BB:40:62:44`, like so:
   ![[Pasted image 20220823070256.png]]
   Take note of the channel (CH) number, we will be using it later.
8. Open up another terminal. Then use the syntax `hcxdumptool -i wlan0 -o test.pcapng --enable_status=1 -c 149`
   Where: 
	   -i = interface
	   -o = output file
	   --enable_status = filter only the needed protocol (1 is used for PKMID+EAPOL)
	   -c = channel



