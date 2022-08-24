### SCP

scp — OpenSSH secure file copy

scp copies files between hosts on a network.

It uses ssh(1) for data transfer, and uses the same authentication and provides the same security as a login session.

scp will ask for passwords or passphrases if they are needed for authentication.

Syntax:

#### Copy a Local File to a Remote System with the scp Command

To copy a file from a local to a remote system run the following command:

`scp file.txt remote_username@10.10.0.2:/remote/directory`

scp file_from_local file_to_remote