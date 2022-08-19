### steganography


binwalk

`binwalk image.jpg`

```
┌──(kali㉿kali)-[~/ken/MoonShine/CTF/Agent-sudo]
└─$ binwalk cutie.png

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             PNG image, 528 x 528, 8-bit colormap, non-interlaced
869           0x365           Zlib compressed data, best compression
34562         0x8702          Zip archive data, encrypted compressed size: 98, uncompressed size: 86, name: To_agentR.txt
34820         0x8804          End of Zip archive, footer length: 22

                
```

how to extract files


`binwalk image.jpg -e`

- -e = extract

