# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

<!---
## TOC Classes

---

1. [Case statements](#id-class13)

<div id='id-class13'/>
--->
## Class 13: Case statements

---

We can use a case statement to create a sort of menu and check expressions over that menu. Let's create a script:

```shell
:~$ touch myscript.sh
:~$ chmod +x myscript.sh
```

##### **`myscript.sh`**
```bash
#!/bin/bash

# First present the user some options
echo "What is your favorite Linux distribution?"

echo "1 - Arch"
echo "2 - CentOS"
echo "3 - Debian"
echo "4 - Mint"
echo "5 - Ubuntu"
echo "6 - Something else..."

# Read the input from the user into the distro variable
read distro;

# Build a case statement
case $distro in
    1) echo "Arch is a rolling release.";;
    2) echo "CentOS is popular on servers";;
    3) echo "Debian is a community distribution";;
    4) echo "Mint is popular on desktops and laptops.";;
    5) echo "Ubuntu is popular on both servers and computerrs.";;
    6) echo "There are many distributions out there.";;
    *) echo "The entered choice is not valid."
esac
```

In this way you can show a particular message (but you can execute whatever you want) depending on the distribution chosen by the user. The last sentence with the `*` will catch all the other options that are not listed. All the sentences in the `case` statement end with a semicolon, except the last one.

Let's modify the script to allow the user to enter a valid input and see the description of the distribution and exit the script.

##### **`myscript.sh`**
```bash
#!/bin/bash

finished=0

while [ $finished -ne 1 ]; do

    # First present the user some options
    echo "What is your favorite Linux distribution?"

    echo "1 - Arch"
    echo "2 - CentOS"
    echo "3 - Debian"
    echo "4 - Mint"
    echo "5 - Ubuntu"
    echo "6 - Something else..."
    echo "7 - Exit the script"

    # Read the input from the user into the distro variable
    read distro;

    # Build a case statement
    case $distro in
        1) echo "Arch is a rolling release.";;
        2) echo "CentOS is popular on servers";;
        3) echo "Debian is a community distribution";;
        4) echo "Mint is popular on desktops and laptops.";;
        5) echo "Ubuntu is popular on both servers and computerrs.";;
        6) echo "There are many distributions out there.";;
        7) finished=1 ;;
        *) echo "The entered choice is not valid."
    esac

done

echo "Thanks for using the script."
```