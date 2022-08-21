### Crack_hash

#### Task 1

Can you complete the level 1 tasks by cracking the hashes?

48bb6e862e54f2a795ffc4e541caed4d
easy
Method: used crackstation

CBFDAC6008F9CAB4083784CBD1874F76618D2A97 
password123
Method: used crackstation

1C8BFE8F801D79745C4631D09FFF36C82AA37FC4CCE4FC946683D7B336B63032
letmein
Method: used crackstation

`$2y$12$Dwt1BZj6pcyc3Dy1FWZ5ieeUznr71EeNkJkUlypTsgbX1H68wsRom`
bleh

Method: used hashcat

hashcat -a 3 -w 4 hash1.txt ?l?l?l?l


#### Task 2

This task increases the difficulty. All of the answers will be in the classic rock you password list.

You might have to start using hashcat here and not online tools. It might also be handy to look at some example hashes on hashcats page.


F09EDCB1FCEFC6DFB23DC3505A882655FF77375ED8AA2D1C13F640FCCC2D0C85
paule
Method: used crackstation

1DFECA0C002AE40B8619ECF94819CC1B
n63umy8lkf4i
Method: used crackstation


Hash: `$6$aReallyHardSalt$6WKUTqzq.UQQmrm0p/T7MPpMbGNnzXPMAXi4bJMl9be.cfi3/qxIf.hsGpS41BqMhSrHVXgMpdjS6xeKZAs02.`

Salt: aReallyHardSalt
waka99
Method: used hashcat

hashcat -a 3 -w 4 hash2.txt /usr/share/wordlists/rockyou.txt


Hash: e5d8870e5bdd26602cab8dbe07a942c8669e56d6
Salt: tryhackme
Method: used hashcat






