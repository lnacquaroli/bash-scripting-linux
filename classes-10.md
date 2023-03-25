# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

<!---
## TOC Classes

---

1. [Where to store scripts](#id-class10)

<div id='id-class10'/>
--->
## Class 10: Where to store scripts

---

The Linux file system has a lot of directories. Consider the script of Class 8, the Universal Update Script.

##### **`update`**
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

The best way to run a script is not the $HOME directory, because the script depends on the user to be available to run it. A better choice is an open directory with several permissions on it. (The File Hierarchy System states the purpose of each Linux file system.)

The `/usr/local/bin` is the place to keep the scripts. It requires `sudo` permission to write on it, but it can be accessed by any user (but not modified unless access is given). You can even give `root` privileges to the file by doing:

```bash
:~$ sudo mv update /usr/bin/local

:~$ sudo chown root:root /usr/bin/local/update
```

Notice that the extension was removed as it is not mandatory to have it in Linux systems. It is in fact not recommended using one, and let the shebang decide what interpreter to use the right program.

The good about placing the scripts in `/usr/local/bin` is that it can be used combined with other commands such as `which`, because this directory lies inside the system `$PATH` (env).

```bash
:~$ which update
/usr/bin/local/update
```

If for some weird reason the directory is not available in the `$PATH`, we can add it as follows:

```bash
# Make sure is not there
:~$ echo $PATH

# If it is not, you can add it
:~$ eport PATH=/usr/local/bin:$PATH
```

