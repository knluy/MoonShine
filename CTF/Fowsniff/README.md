### Fowsniff

export IP=10.10.208.29

This boot2root machine is brilliant for new starters. You will have to enumerate this machine by finding open ports, do some online research (its amazing how much information Google can find for you), decoding hashes, brute forcing a pop3 login and much more!

This will be structured to go through what you need to do, step by step. Make sure you are connected to our network

Credit to berzerk0 for creating this machine. This machine is used here with the explicit permission of the creator.

Deploy the machine. On the top right of this you will see a Deploy button. Click on this to deploy the machine into the cloud. Wait a minute for it to become live.

Using nmap, scan this machine. What ports are open?
- 4

![](../../img/Pasted%20image%2020220826073159.png)

Being stuck here for ideas, i tried to perform enumeration again on the secret page using gobuster, and it revealed /administrator page

![](../../img/Pasted%20image%2020220827205818.png)

We checked the /administrator page :

![](../../img/Pasted%20image%2020220827205853.png)

Not sure what this does, we checked the 'cuppa' using searchsploit:

![](../../img/Pasted%20image%2020220827205927.png)


http://10.10.68.81/45kra24zxs28v3yd/administrator/alerts/alertConfigField.php?urlConfig=../../../../../../../../../etc/passwd
