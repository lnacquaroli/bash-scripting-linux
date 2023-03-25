# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

<!---
## TOC Classes

---

1. [Universal Update Script](#id-class8)

<div id='id-class8'/>
--->
## Class 8: Universal Update Script

---

This would be a more realistic way of making use of Bash scripting. The following script updates the repositories from the servers depending on whether the system is based on Arch or Debian distributions. This script will ask for `sudo` permission to execute the commands upon checking on the existence of specific folders particular to each distro.

##### **`myscript.sh`**
```bash
#!/bin/bash

if [ -d /etc/pacman.d ]; then
    # The host is based on Arch, run the pacman update command
    sudo pacman -Syu
fi

if [ -d /etc/apt ]; then
    # The host is based on Debian, run the apt version of the command
    sudo apt update
    sudo apt dist-upgrade
fi
```

The problem with the above example is that you can create the folder and crash the system by running the wrong command. Let's try again more appropriately.

##### **`myscript.sh`**
```bash
#!/bin/bash

# This file is present in almost every distribution.
release_file=/etc/os-release

if grep -q "Arch" $release_file; then
    # The host is based on Arch, run the pacman update command
    sudo pacman -Syu
fi

if grep -q "Pop" $release_file; then
    # The host is based on Debian, run the apt version of the command
    sudo apt update
    sudo apt dist-upgrade
fi
```

The `grep` command is a standard Linux command with the option `-q` for quite mode avoiding any verbosity from this command in the `if` statement. The test command was removed as we are using the `grep` command directly.

This script has another problem though, regression: it will work for some Debian-based distros but not for others. So we can include another statement with more options:

##### **`myscript.sh`**
```bash
#!/bin/bash

# This file is present in almost every distribution.
release_file=/etc/os-release

if grep -q "Arch" $release_file; then
    # The host is based on Arch, run the pacman update command
    sudo pacman -Syu
fi

if grep -q "Debian" $release_file; then
    # The host is based on Debian, run the apt version of the command
    sudo apt update
    sudo apt dist-upgrade
fi

if grep -q "Ubuntu" $release_file; then
    # The host is based on Ubuntu, run the apt version of the command
    sudo apt update
    sudo apt dist-upgrade
fi
```

This will work for both Debian and Ubuntu, but we are repeating a lot of code. A better way would be as follows:

##### **`myscript.sh`**
```bash
#!/bin/bash

# This file is present in almost every distribution.
release_file=/etc/os-release

if grep -q "Arch" $release_file; then
    # The host is based on Arch, run the pacman update command
    sudo pacman -Syu
fi

if grep -q "Debian" $release_file || grep -q "Ubuntu" $release_file; then
    # The host is based on Debian or Ubuntu, run the apt version of the command
    sudo apt update
    sudo apt dist-upgrade
fi
```

The double pipe means `or`. The `&&` means and.