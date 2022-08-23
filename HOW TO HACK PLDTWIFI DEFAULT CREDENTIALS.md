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
	   
	4. hcxdumptool - perform `sudo apt-get install hcxdumptool`, like so. 
	   ![[Pasted image 20220823064901.png]]
	5. hcxpcapngtool - perform `sudo apt-get install hcxpcapngtool`, like so:
	6. hashcat - perform `sudo apt-get install hashcat` on Linux and go to https://hashcat.net/hashcat/ on Windows.
	   

