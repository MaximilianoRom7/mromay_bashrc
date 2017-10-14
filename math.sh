. $home/mromay_bashrc/imports.sh
import logging
import process

function ratio() {
    : '
    GIVEN TWO ARGUMENTS A AND B RETURNS THE RATIO BETWEEN THEM
    '
    a=$(cut -d ':' -f1 <<< $1)
    b=$(cut -d ':' -f2 <<< $1)
    if [ $bin_exists_bc ]
    then
	# sed is used to replace .75 for 0.75
	echo $(bc <<< "scale=2; $a / $b" | sed 's/^\./0./g')
    else
	if [ $bin_exists_python ]
	then
	    python2 -c "a="$a"; b="$b"; print round(a/float(b), 2)"
	else
	    echo cannot compute operation
	fi
    fi
}

function sum_column() {
    : '
    GIVEN A TABLE AND TWO ARGUMENTS USES THE FIRST ARGUMENT
    TO SPLIT THE COLUMNS OF THE TABLE
    AND THE SECOND ARGUMENT TO GET THE NTH COLUMN
    THEN ASUMING THIS COLUMN HAS ONLY NUMBERS TRIES TO SUM IT UP
    FOR EXAMPLE
    echo $table | sum_column ' ' 2
    AND IF THE TABLE IS THE FOLLOWING
    a 1 x
    b 2 x
    c 3 x
    THIS FUNCTIONS GETS THE SECOND COLUMN AND SUM IT UP
    1+2+3 = 6
    RETURNS 6
    ANOTHER EXAMPLE
    du -s ~/* | sum_column $"\t" 1
    RETURNS THE SUM OF ALL THE FILES AND FOLDERS FROM MY HOME DIRECTORY
    '
    cut -d $1 -f $2  | paste -sd + | bc
}

loaded math
