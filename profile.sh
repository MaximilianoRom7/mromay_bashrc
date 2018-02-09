import logging

if [ $(which tmux) ] && [ -z "$TMUX" ]
then
	tmux a 2> /dev/null
	if [ ! "$?" -eq 0 ]
	then
		tmux
	fi
fi

loaded profile
