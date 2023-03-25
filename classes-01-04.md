# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

## TOC Classes

---

1. [Introduction](#id-class1)
2. [Hello World](#id-class2)
3. [Variables](#id-class3)
4. [Basic math](#id-class4)

<div id='id-class1'/>
## Class 1: Introduction

---

Bash allows us to interact with the shell using the terminals in Linux and Unix systems via commands.

Bash could be thought of as a programming language, but it is an interpreter or a shell. You can write down scripts though to execute commands.

<div id='id-class2'/>
## Class 2: Hello World

---

To detect what shell we have we could use the command `echo`:

```bash
:~$ echo $SHELL
/bin/bash
```

There are a lot of reserved commands that can be run inside the shell using Bash. For instance, `ls` to list the content of a directory:

```bash
:~$ ls
```

To turn this command into a script we can create an empty text file named `myscript.sh`:

##### **`myscript.sh`**
```bash
ls
```

After creating the file we need to mark it as executable (not sure if you need `sudo` permissions):

```bash
:~$ chmod +x myscript.sh
```

Once executable, to run the script we do:

```bash
:~$ ./myscript.sh
```

To view the content of the file we can do:

```bash
:~$ cat myscript.sh
ls
```

The `.sh` extension is not mandatory, you can avoid the extension altogether.

We can add more lines to the script to run in sequence, one after the other:

##### **`myscript.sh`**
```bash
ls
pwd
```

The command `pwd` is the command that shows the path to the directory that we are working on.


To properly write a Bash script, we need to add a header (also called a shebang or hashbang), which will tell the file what type of interpreter that is supposed to use:

##### **`myscript.sh`**
```bash
#!/bin/bash

echo "Hello World!"

echo "My current working directory is:"
pwd
```

This would be an official way to write a bash script.

<div id='id-class3'/>
## Class 3: Variables

---

Variables allow using some information in different parts of the code.

To declare a variable in the shell:

```bash
:~$ myname="Lestat"
:~$ echo $myname
Lestat
```

We need to use the dollar sign to tell Bash that what follow is a reference to a variable. It also avoids name collision with reversed commands.

Variables by default do not persist: they do not survive a logoff of the terminal.

To declare variables inside a script, we can do:

##### **`myscript.sh`**
```bash
#!/bin/bash

myname="Lestat"
myage="346"

echo "Hello, my name is $myname"

echo "I'm $myage years old."
```

**Notice the double quotes for the strings. If we use single quotes, it will not print the content of the string but the name of the variable.**

To use single quotes and print variable names, we need to escape the single quote: `'I\'m $myage ...'`.

Variables are useful because they avoid retyping, for instance:

##### **`myscript.sh`**
```bash
#!/bin/bash

#word="awesome"
word="fun"

echo "Linux is $word."
echo "Videogames are $word."
echo "Sunny days are $word."
```

We can use variables to capture the output of a command. For instance, we want to capture the result of the `ls` commands:

```bash
:~$ files=$(ls)
:~$ echo files
```
The `$()` is a subshell that allows to execute commands in the background and grab the results. Another example:

```bash
:~$ path=$(pwd)
:~$ echo path
```

Another useful command is `date`. Inside a script we can do:

##### **`myscript.sh`**
```bash
#!/bin/bash

now=$(date)

echo "The system time and date is:"
echo $now
```

We can also use environmental variables available in the system:

##### **`myscript.sh`**
```bash
#!/bin/bash

name="Lestat"
now=$(date)

echo "Hello $name."

echo "The system time and date is:"
echo $now

echo "Your username is $USER".
```

Here, `USER` is an environmental variable available in the system that we can use. There are many environmental variables, which are all declared in upper cases. (Avoid naming user defined variables with upper case format).

```bash
:~$ env
(list of environmental variables...)
```

<div id='id-class4'/>
## Class 4: Basic math functions

---

There are basic math functions available that Bash can handle. Basic math operations work with expressions, unlike regular programming languages. To add two numbers together we can create expressions:

```bash
:~$ expr 30 + 10
40
```

However,

```bash
:~$ expr 30 * 2
ERROR...
```

The `*` is a wildcard (means all or everything) in Bash so can't be used as an operation. To do a multiplication we need to escape the operator:

```bash
:~$ expr 30 \* 2
60
```

To work with variables we can also evaluate expressions:

```bash
:~$ mynum1=100
:~$ expr $mynum1 + 50
150

:~$ mynum2=88
:~$ expr $mynum1 + $mynum2
188

:~$ expr $mynum1 - 50
50
```
