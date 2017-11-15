: '
  TRYING TO CREATE A REPL IN BASH ...
'
import logging

function relp() {
    : '
    READ EVAL LOOP PRINT... IN BASH
    THIS IS MENT FOR USING FUNCTIONS THAT ARE NOT IN BASH
    THAT MEANS THAT WHEN CALLING A FUNCTION THAT IS NOT DEFINED
    IN BASH INSTEAD OF FAILING TRIES TO CALL THE FUNCTION
    FROM OTHER SOURCES LIKE PYTHON O JAVASCRIPT
    '
    while $(true)
    do
	echo -n $PS1":::  "
	read code
	result=$(eval "$code")
	echo $?
	sleep 0.1
    done
}

loaded eval
