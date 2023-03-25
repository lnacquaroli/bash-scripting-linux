# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

<!---
## TOC Classes

---

5. [If statements](#id-class5)

<div id='id-class5'/>
--->
## Class 5: If statements

---

The `if` statement in Bash can be thought of in the same way as in a programming language. For instance,

##### **`myscript.sh`**
```bash
#!/bin/bash

mynum=200

if [ $mynum -eq 200 ]
then
    echo "The condition is true."
fi
```

Notice the spaces between the brackets in the `if` statement. This is important to be there, but it may not always have brackets. The `-eq` flag is the equal operator. The same statement can be written more concisely:

##### **`myscript.sh`**
```bash
#!/bin/bash

mynum=200

if [ $mynum -eq 200 ]; then
    echo "The condition is true."
fi
```

Remember to change the mode to give executable permission to the file and run it. Another example with `if-then-else` to efficiently reduce the number of comparisons:

##### **`myscript.sh`**
```bash
#!/bin/bash

mynum=200

if [ $mynum -eq 200 ]; then
    echo "The condition is true."
else
    echo "The variable does not equal 200."
fi
```

If you add an exclamation mark `!` before the variable negates the comparison. It can be read as if `$mynum` is not equal to 200. Another way to accomplish this more consistently is to use `-ne` flag:

##### **`myscript.sh`**
```bash
#!/bin/bash

mynum=200

if [ ! $mynum -eq 200 ]; then
    echo "The variable does not equal 200."
else
    echo "The condition is true."
fi

if [ $mynum -ne 200 ]; then
    echo "The variable does not equal 200."
else
    echo "The condition is true."
fi
```

Other common comparison operators are:
- `-gt` (greater than).
- `-lt` (less than).


One useful function of the `if` statement is that allows to check the existence of a file in the system with the `-f` option:

##### **`myscript.sh`**
```bash
#!/bin/bash

if [ -f ~/myfile ]; then
    echo "The file exists."
else
    echo "The file does not exists."
fi
```

Then you call it as follows:

```bash
# Go to home directory
:~$ cd

# Create the file
:~$ touch myfile
:~$ ./myscript.sh
The file exists.

# Remove the file
:~$ rm myfile
:~$ ./myscript.sh
The file does not exists.
```

The `which` command allows checking whether an application of program is available in the system. The following script will check that the existence of the program and if it cannot find the program it will install it.

##### **`myscript.sh`**
```bash
#!/bin/bash

command=/usr/bin/htop

if [ -f $command ]; then
    echo "$command is available, let's run it..."
else
    echo "$command is NOT available, installing it..."
    # This will work for Debian-based distros...
    sudo apt update && sudo apt install -y htop
fi

$command
```

We can improve the script above as follows:

##### **`myscript.sh`**
```bash
#!/bin/bash

command=htop

if command -v $command; then
    echo "$command is available, let's run it..."
else
    echo "$command is NOT available, installing it..."
    # This will work for Debian-based distros...
    sudo apt update && sudo apt install -y $command
fi

$command
```

There are no brackets in the `if command -v $command` statement. Brackets are only needed if you run a test commands (Whenever you put brackets in the statements Bash assumes you are using the `test` command to evaluate an expression in the background. Check `man test`.). The command `command -v` check the existence of a certain command, in this case `$command`. For instance, we can run this in the terminal:

```bash
:~$ command -v htop
/usr/bin/htop
```

This is why the dollar sign is important to reference a variable, to avoid name collision (although you can also use another name for the `command` variable).

