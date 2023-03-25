# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

<!---
## TOC Classes

---

1. [Functions](#id-class12)

<div id='id-class12'/>
--->
## Class 12: Functions

---

Functions allow us to define a set of tasks and call them whenever we need them. They work very much like functions in programming languages.

Recall the `/usr/local/bin/update` script we wrote in previous chapters:

##### **`update`**
```bash
#!/bin/bash

release_file=/etc/os-release
logfile=/var/log/updater.log
errorlog=/var/log/updater_errors.log

if grep -q "Arch" $release_file; then
    # The host is based on Arch, run the pacman update command
    sudo pacman -Syu 1>> $logfile 2>> $errorlog
    if [ $? -ne 0 ]; then
        echo "An error occurred. Please, check the $errorlog file."
    fi
fi

if grep -q "Debian" $release_file || grep -q "Ubuntu" $release_file; then
    # The host is based on Debian or Ubuntu, run the apt version of the command
    sudo apt update  1>> $logfile 2>> $errorlog
    if [ $? -ne 0 ]; then
        echo "An error occurred. Please, check the $errorlog file."
    fi

    sudo apt dist-upgrade -y 1>> $logfile 2>> $errorlog
    if [ $? -ne 0 ]; then
        echo "An error occurred. Please, check the $errorlog file."
    fi
fi
```

We could rewrite this script using functions, to reduce space and repetition, as follows:

##### **`update`**
```bash
#!/bin/bash

# Define a function to check the exit code
check_exit_status() {
    if [ $? -ne 0 ]; then
        echo "An error occurred. Please, check the $errorlog file."
    fi
}

release_file=/etc/os-release
logfile=/var/log/updater.log
errorlog=/var/log/updater_errors.log

if grep -q "Arch" $release_file; then
    # The host is based on Arch, run the pacman update command
    sudo pacman -Syu 1>> $logfile 2>> $errorlog
    check_exit_status
fi

if grep -q "Debian" $release_file || grep -q "Ubuntu" $release_file; then
    # The host is based on Debian or Ubuntu, run the apt version of the command
    sudo apt update  1>> $logfile 2>> $errorlog
    check_exit_status

    sudo apt dist-upgrade -y 1>> $logfile 2>> $errorlog
    check_exit_status
fi
```

The `check_exit_status` is checking the status instead of writing the `if` statements. So, we wrote the same thing once, and then use it over and over again. This also helps in reducing the debugging time. NOTE: I guess the exit code variable has sort of a global scope.

