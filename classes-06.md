# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

<!---
## TOC Classes

---

5. [Exit codes](#id-class6)

<div id='id-class5'/>
--->
## Class 6: Exit codes

---

When you run a command in Bash you would like to know whether the command is a fail or not. That's why the exit codes are useful: to determine if a command was successful or not without using our own judgement.

For instance, running

```bash
:~$ ls -l /etc
...
```

will return all the subdirectories and files inside `/etc`. Now, we can directly check, right after executing the above command, to check the exit code of it with the command `$?`:

```bash
:~$ echo $?
0
```

The exit code of `0` means success. If you run an exit code that shows a failure, it will print out a different number other than `0`. The `?` variable has the exit code of the last execution.

```bash
:~$ ls -l /misc
:~$ echo $?
2
```

This allows to automatically determine if something run successfully or if it went wrong.

Imagine you want to automatize the installation of a package:

##### **`myscript.sh`**
```bash
#!/bin/bash

package=htop

sudo apt install -y $package

echo "The exit code for the package $package is: $?".
```

Note: Only the exit code `0` means success, any other number of the exit code is a failure, no matter the number.

Let's run another example:

##### **`myscript.sh`**
```bash
#!/bin/bash

package=htop

sudo apt install -y $package

# Check the exit code output and execute accordingly
if [ $? -eq 0]; then
    echo "The installation of $package was successful."
    echo "The command line is available here:"
    which $package
else
    echo "$package failed to install."
fi
```

Another useful technique is to send the information of the output to a file log using the redirect command `>>`:

##### **`myscript.sh`**
```bash
#!/bin/bash

package=htop

sudo apt install -y $package >> package_install_results.log

# Check the exit code output and execute accordingly
if [ $? -eq 0]; then
    echo "The installation of $package was successful."
    echo "The command line is available here:"
    which $package
else
    echo "$package failed to install." >> package_install_failure.log
fi
```

This helps to clean the output and keep verbosity at minimum in the terminal by sending all the information to files.

Let's check another example.

##### **`myscript.sh`**
```bash
#!/bin/bash

directory=/etc

if [ -d directory ]; then
    echo "The directory $directory exists."
else
    echo "The directory $directory does not exists."
fi

echo "The exit code for this script is: $?."
```

This will print an exit code of `0`, which seems fine. The problem is that the exit code is taken from the `echo` command after the `if` statement and not from the `if` statement itself. Try this and see the difference:

##### **`myscript.sh`**
```bash
#!/bin/bash

directory=/etc

if [ -d directory ]; then
    echo "The exit code for this script is: $?."
    echo "The directory $directory exists."
else
    echo "The exit code for this script is: $?."
    echo "The directory $directory does not exists."
fi
```

It is important not to use exit codes after `echo` statement because this command will run fine, always. A way to handle this situation is to manipulate the exit code with the `exit` command:

##### **`myscript.sh`**
```bash
#!/bin/bash

echo "Hello World!"
# Force the exit code to be nonzero
exit 1
echo $?
```

Now the other way around:

##### **`myscript.sh`**
```bash
#!/bin/bash

sudo apt install -y notexists
# Force the exit code to be zero
exit 0
echo $?
```

Let's see another example:

##### **`myscript.sh`**
```bash
#!/bin/bash

directory=/etc

if [ -d directory ]; then
    echo "The directory $directory exists."
    exit 0
else
    echo "The directory $directory does not exists."
    exit 1
fi

echo "The exit code for this script is: $?."
echo "You didn't see that statement."
echo "You won't see this one either."
```

The `exit` command is sort of global scope; it does not matter whether is inside an `if` statement. The last three echoes won't be printed if the `if` the statement is true.