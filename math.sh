. $home/mromay_bashrc/imports.sh
import logging

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
