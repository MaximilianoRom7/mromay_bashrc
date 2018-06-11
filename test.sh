import logging

test_dir=tests

function trial_log() {
    : '
    RUNS A PYTHON UNITTEST USIGN THE LIBRARY TWISTED TRIAL
    '
    mkdir -p $test_dir
    trial $1 | tee $test_dir/test_$1_$(date +%Y%m%d_%H%M%S).log
}

function trial_log_full() {
    : '
    RUNS A PYTHON UNITTEST USIGN THE LIBRARY TWISTED TRIAL
    '
    mkdir -p $test_dir
    trial $1 2>&1 | tee $test_dir/test_$1_$(date +%Y%m%d_%H%M%S).log
}

function test_pylinks() {
    : '
    FOR EVERY .PY FILE IN THIS DIRECTORY CREATES A SYMBOLIC LINK
    LIKE THIS TEST_<NAME>.PY -> NAME.PY
    FOR EXAMPLE TEST_WSFE1.PY -> WSFE1.PY
    ALL THE PYTHON TESTS USING TWISTED MUST BEGIN WITH TEST_...PY
    AND THE TEST IN ODOO DO NOT HAVE THIS CONSTRAINT SO THIS FUNCTION
    CREATES THIS LINKS AND FIXES THE PROBLEM
    '
    ls *.py | while read l
    do
        ln -s "$l" test_"$l"
    done
}

loaded test
