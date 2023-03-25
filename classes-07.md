# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

<!---
## TOC Classes

---

5. [While loops](#id-class7)

<div id='id-class5'/>
--->
## Class 7: While loops

---

A while loop allows us to continuously do something until a condition is met and then stop running. See the following example, where a while loop changes values from one to ten, it prints the results and then stops. The new variable `myvar` replaces the first one adding one to it.

##### **`myscript.sh`**
```bash
#!/bin/bash

myvar=1

while [ $myvar -le 10 ]; do
    echo $myvar
    myvar=$(( $myvar + 1 ))
    sleep 0.5
done
```

Another example to test if a file exists inside the loop. If the file exists, it will print the `echo` inside the loop until the file is removed.

##### **`myscript.sh`**
```bash
#!/bin/bash

while [ -f ~/testfile ]; do
    echo "The test file exists."
done

echo "The file no longer exists. Exiting."
```

Let's make the script more useful, where the time is shown for each condition. Notice that the `date` command is inside a subshell.

##### **`myscript.sh`**
```bash
#!/bin/bash

while [ -f ~/testfile ]; do

    echo "As of $(date), the test file exists."

    # Show echoes every 5 seconds.
    sleep 5

done

echo "As of $(date), the file no longer exists. Exiting."
```

Let's print a countdown script using a while loop.

##### **`myscript.sh`**
```bash
#!/bin/bash

myvar=17

while [ $myvar -gt 0 ]; do
    echo $myvar
    myvar=$(( $myvar - 1 ))
    sleep 0.5
done
```