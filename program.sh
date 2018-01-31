import logging


user_safe=skyline

alias dolphin='ignore su -c "dbus-launch dolphin" -s /bin/sh $user_safe'
if [ $(which chromium-browser 2> /dev/null) ]
then
    chrome=chromium-browser
else
    chrome=chromium
fi
alias chrome='ignore $chrome --no-sandbox'

loaded program
