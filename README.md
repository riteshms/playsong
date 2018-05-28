# playsong
For OS X: a simple bash script to help quick keyword search and play mp3 songs

beets
=====

Playsong is ...

The purpose of playsong is ...
It provides ... 

Here's an example of how playsong works::

  $ playsong

- Uses the underlying Mac indexed search mechanism
- Displays a list of songs for selection
- Provides hot keys for `basic song play manipulation` (viz. Pause, Forward, Next, Previous ...)


Install
-------

You can install playsong by simply copying the playsong.sh file and making it executable.
Add this to your system path for anywhere access.

.. _Other links


Other configuration
--------------------


Other notes
-----------
If you wish to use 'find' command then use the block:
 while IFS=  read -r -d $'\0'; do
    array+=("$REPLY")
done < <(find . -name ${input} -print0)

 How it works
 
 The first line creates an empty array: array=()
 Every time that the read statement is executed, a null-separated file name is read from standard input. The -r option tells read to leave backslash characters alone. The -d $'\0' tells read that the input will be null-separated.
 The array+=("$REPLY") statement appends the new file name to the array array.
 The final line combines redirection and command substitution to provide the output of find to the standard input of the while loop.
 Why use process substitution?
 
 If we didn't use process substitution, the loop could be written as:
 
 array=()
 find . -name ${input} -print0 >tmpfile
 while IFS=  read -r -d $'\0'; do
     array+=("$REPLY")
 done <tmpfile
 rm -f tmpfile


Authors
-------
Ritesh SHAH

