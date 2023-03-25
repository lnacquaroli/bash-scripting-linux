# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

<!---

## TOC Classes

---

1.  [Arguments](#id-class16)

<div id='id-class16'/>
--->
## Class 16: Arguments

---

Sometimes is useful to run a script with an input argument, so you can change just the input argument and have a different result or behavior.

Let's see the following simple script:

##### **`myscript.sh`**
```bash
#!/bin/bash

echo "You entered the argument: $1"
```

The `$1` is a reference to the first argument instead to a variable. So, if you type:

```shell
:~$ ./myscript.sh Linux
You entered the argument: Linux
```

You can also have more than one argument and those will be used in the following numbers: `$1`, `$2`, `$3`, `$4`, and so on.


##### **`myscript.sh`**
```bash
#!/bin/bash

echo "You entered the argument: $1, $2, $3, $4"
```

```shell
:~$ ./myscript.sh Linux Pizza Books Games
You entered the argument: Linux, Pizza, Books, Games
```

Arguments are useful and most of the time we used them without notice. For instance, the command `ls -l`. You can also pass an argument in the script to partial commands: `ls -l $1`, for instance. Let's see another example:

##### **`myscript.sh`**
```bash
#!/bin/bash

# This is a variable
lines=$(ls -lh $1 | wc -l)

echo "You have $(($lines - 1)) objects in the $1 directory."
```

And now run it:
```shell
:~$ ./myscript.sh /etc
You have 247 objects in the etc directory.
```

The variable `lines` in the script is a subshell of the command `ls` along combined with the `wc`. The command `wc` is useful to count words, lines, bytes, and characters. We removed the first line with the `-1` since it is related to statistics and not actual lines (try `ls -l /etc | head`).


One problem with the script so far is that passing empty arguments will default to the current directory. This would be fine or not.

```shell
:~$ ./myscript.sh
You have 10 objects in the directory.
```

But most of the time it is useful to give an option to the default.

##### **`myscript.sh`**
```bash
#!/bin/bash

# This is a variable
lines=$(ls -lh $1 | wc -l)

if [ $# -ne 1 ]; then
    echo "This script requires exactly one directory path passed to it."
    echo "Please try again."
    # Return error
    exit 1
fi

echo "You have $(($lines - 1)) objects in the $1 directory."
```

The `$#` is a reference to the number of arguments that the user input when running the script. Let's run it with different options:

```shell
:~$ ./myscript.sh /etc
You have 247 objects in the /etc directory.

:~$ ./myscript.sh
This script requires exactly one directory path passed to it.
Please try again.

:~$ ./myscript.sh /etc /home / var
This script requires exactly one directory path passed to it.
Please try again.
```