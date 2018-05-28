#purpose: (for OSX) find songs based on query, display them (max. 50), allow user selection for playing
#author: rms
#date: 09Feb17
#!/bin/bash
while [ 1 ]
do
	clear
	printf "\n===== QUICK SONG SEARCH & PLAY (^C to QUIT/ABORT) =====\n"
	printf "\nWHICH SONG? (Enter keywords): "
	read input

	SONGSDIR=~/FREEAGENT-2/SONGS
	MAX=50 		#maximum number for songs to be listed
	#printf "Searching under : $SONGSDIR"
	printf "\nSearching "
	for t in {1..6}
	do
		sleep 0.1
		printf "..."
	done
	printf "..."
	cd $SONGSDIR 
	array=()
	while IFS= read -r ; do 
		array+=("$REPLY"); 
	done < <(mdfind -onlyin $SONGSDIR ${input} | egrep '\.mp')

	len=${#array[*]}

	if [ $len -eq 0 ]; then
		printf "\n\nFOUND NONE"
		sleep 1.2
	elif [ $len -eq 1 ]; then
		i=0
		onlySong=`basename "${array[$i]}"`
		printf "\n\nFOUND AND PLAYING: $onlySong\n\n"
		#printf "Yes, its 1"
		sleep 2
		#printf "Playing ...\n"
		mpg123 -Cv "${array[$i]}"
	elif [ $len -le $MAX ]; then
		printf "\n\nFOUND (${len})\n"
		newSearchRequired=false
		firstTimeResults=true
		while [ "$newSearchRequired" = false ]
		do
			if [ "$firstTimeResults" = false ]; then
				if [ $numChosen -gt 0 ]; then
					let songChoice=$numChosen-1
					while [ $songChoice -lt $len ] 
					do
						clear
						mpg123 -Cv "${array[$songChoice]}" 
						let songChoice++
						printf "====================================\n"
						read -t 5 -p "PRESS 's' to re-select OR 'n' for new search (in 5secs): " interimChoice
						echo $interimChoice
						if [ "$interimChoice" == 's' ]; then
							break
						fi 
						if [ "$interimChoice" == 'n' ]; then
							newSearchRequired=true
							break
						fi
					done
				fi
			fi
			if [ "$newSearchRequired" = false ]; then
				i=0
				while [ $i -lt $len ] 
				do
					songName=`basename "${array[$i]}"`
					let i++
					printf "\n($i) $songName" 
				done
				printf "\n\nSELECT (1,2...) or SEARCH AGAIN (0): "
				read numChosen
				if [ "$numChosen" -eq "0" ]; then
					newSearchRequired=true
				fi
				#if [ "$numChosen" == "d" ]; then
				#	read -p "WHICH SONG TO DELETE?: " delSongNumber
				#	echo "Delete :";printf "${array[$i]}\n"
				#fi
			fi
			firstTimeResults=false
		done
	else
		printf "\n\nFOUND ($len), TOO MANY SONGS, SEARCH AGAIN, WAIT ...!"
		sleep 2.5	
	fi
done

### RMS: if you wish to use 'find' command then use the block:
# while IFS=  read -r -d $'\0'; do
#    array+=("$REPLY")
#done < <(find . -name ${input} -print0)

# How it works
# 
# The first line creates an empty array: array=()
# Every time that the read statement is executed, a null-separated file name is read from standard input. The -r option tells read to leave backslash characters alone. The -d $'\0' tells read that the input will be null-separated.
# The array+=("$REPLY") statement appends the new file name to the array array.
# The final line combines redirection and command substitution to provide the output of find to the standard input of the while loop.
# Why use process substitution?
# 
# If we didn't use process substitution, the loop could be written as:
# 
# array=()
# find . -name ${input} -print0 >tmpfile
# while IFS=  read -r -d $'\0'; do
#     array+=("$REPLY")
# done <tmpfile
# rm -f tmpfile



