# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

<!---
## TOC Classes

---

1. [Data Streams](#id-class11)

<div id='id-class11'/>
--->
## Class 11: Data Streams

---


Data streams allow us to control where the output goes where errors are present. There are three types of data streams:
- **Standard output (stdout)**, such as `ls`. *A standard output prints to the screen if it is **not** an error*. (An output with exit code `0`).
- **Standard error (stderr)**. *A standard error prints to the screen if it is an error*. (An output with exit code different from `0`).
- **Standard input (stdin)**. This is the case when we are waiting input from the user.

Let's consider the `find` command to exemplify the standard output and error, by listing every object that is a file inside the `etc` directory.

```bash
# Print standard output and standard error
:~$ find /etc -type f
... stdout and stderr
```

This command will probably error some findings due to permission denied. If you try using `sudo` you would not receive these errors at all.

To avoid the output mixing the two types of standard output and error, you can add an option to the `find` command as follows:

```bash
# Print only standard output
:~$ find /etc -type f 2> /dev/null
... only stdout
```

The `2> /dev/null` redirects text having an exit code that constitutes a standard error to the specific place `/dev/null`, which is a particular direction in Linux that makes whatever you send to it to be completely wiped out (like a black hole). If we remove the `2` it will print out everything standard error while sending all the standard output to `/dev/null`, the same happens if you use `1>`.

```bash
# Print only standard error
:~$ find /etc -type f > /dev/null
... only stderr

:~$ find /etc -type f 1> /dev/null
... only stderr
```

The number means what you want to be redirected:
- If you use `1>`, then the `stdout` is redirected.
- If you use `2>`, then the `stderr` is redirected.
- If you don't use any number, just `>`, then `1>` is used by default. Then `stdout` is redirected.
- If you use `&>`, then both, `stdout` and `stderr`, will be redirected.

In the same way, you can redirect to a file or any other place useful for the process. This is particularly useful if you want to flag a problem to someone else for instance.

You can also split what you redirect to different files for the different standards. For example, the command below will redirect `stdout` to one file and `stderr` to another:

```bash
:~$ find /etc -type f 1> stdout.log 2> stderr.log
```

Notice that:
- `>` will overwrite the specific file with what you redirect to it.
- `>>` will append to the specific file with what you redirect to it.

Let's modify the Universal Update Script, `/usr/local/bin/update`, as follows, to send messages depending on the exit codes. (Adding a lot of redundancy, yes...).

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

There might be errors associated to the privileges accessing to the var directory. If that is the case, you can run

```bash
:~$ sudo su -

root@hpc:~# /usr/local/bin/update
...
```

Let's consider an example for the standard input using the following script asking information from the user and store it into a variable using the `read` command.

##### **`myscript.sh`**
```bash
#!/bin/bash

echo "Please enter your name:"
read myname
echo "Your name is $myname."
```
