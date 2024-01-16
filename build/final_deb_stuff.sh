#!/usr/bin/env bash
#/usr/sbin/ldconfig
if [ "$XDG_SESSION_TYPE" == 'tty' ]
then
    if sudo /usr/sbin/ldconfig
    then
        echo "ldconfig failed to run"
    else
        echo "ldconfig succeeded"
    fi
else
    if pkexec /usr/sbin/ldconfig
    then
        echo "ldconfig failed to run"
    else
        echo "ldconfig succeeded"
    fi
fi
#echo '' >> /home/grizzlysmit/Projects/C++/gzzReadline/build/cmake_install.cmake
#echo 'execute_process(COMMAND "bash" "-c" "ldconfig")' >> /home/grizzlysmit/Projects/C++/gzzReadline/build/cmake_install.cmake
