### Searchsploit

NAME
SearchSploit - Exploit Database Archive Search

DESCRIPTION
Allow you to search through exploits and shellcodes using one or more terms from Exploit-DB

SYNOPSIS
`searchsploit [options] term1 [term2] ... [termN]`


EXAMPLE
       searchsploit afd windows local
       searchsploit -t oracle windows
       searchsploit -p 39446
       searchsploit linux kernel 3.2 --exclude="(PoC)|/dos/"
