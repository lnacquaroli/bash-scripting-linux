# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

<!---
## TOC Classes

---

1. [For loops](#id-class9)

<div id='id-class9'/>
--->
## Class 9: For loops

---

The `for` loops allow us to repeat a task using for certain number of times (set). For instance,

##### **`myscript.sh`**
```bash
#!/bin/bash

for number in 1 2 3 4 5 6 7 8 9 10; do
    echo $number
    sleep 0.5
done

echo "The loop is done."

# Now try the set with a more concise expression
for n in {1..10}; do
    echo $n
    sleep 0.5
done

echo "The loop with set is done."
```

The set can be defined more efficiently using the `{1..10}` expression, which will make a set of number from 1 to 10 with steps of 1.

Let's see another example that will look for log files inside the `logfiles` directory, and will create a tarball file for each log. This will print for each step the file that is being processed.

##### **`myscript.sh`**
```bash
#!/bin/bash

for file in logfiles/*.log; do
    tar -czvf $file.tar.gz $file
done

echo "The loop is done."
```
