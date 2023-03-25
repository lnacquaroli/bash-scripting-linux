# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

## TOC Classes

---

14. [Scheduling jobs with at (part 1)](#id-class14)
15. [Scheduling jobs with cron (part 2)](#id-class15)

<div id='id-class14'/>
## Class 14: Scheduling jobs with at (part 1)

---

Sometimes you want to execute something at a specific time. Let's see one way with an example that uses the `at` command which allows us to schedule a command to run at any later time. Check if you have the command otherwise, install it.

```shell
:~$ which at
:~$ sudo apt install at
...
:~$ which at
/usr/bin/at

:~$ touch myscript.sh
:~$ chmod +x myscript.sh
```

##### **`myscript.sh`**
```bash
#!/bin/bash

logfile=job_results.log

echo "The script run at the following time: $(date)." > $logfile
```

At this point, the script does not do much but helps us to make sure we can run the file and creates the `logfile`.

We can schedule the script to run at a specific time as follows by using the `at` command:

```shell
:~$ at 15:32 -f ./myscript.sh
warning: commands will be executed using /bin/sh
job 2 at Thu Mar 31 15:32:00 2022
```

Now, we can check that something we schedule is actually going to be executed by inspecting the queue of the `at` command, which is `atq`:

```shell
:~$ atq
2   Thu Mar 31 15:32:00 2022 a user
```

You can also delete the schedule job as follows:

```shell
:~$ atrm 2
:~$ atq
```

We can specify a date for the script to run along with the time:

```shell
:~$ at 18:00 081622 -f ./myscript.sh
warning: commands will be executed using /bin/sh
job 4 at Tue Aug 16 18:00:00 2022
:~$ atq
4   Tue Aug 16 18:00:00 2022 a user
:~$ atrm 4
```

<div id='id-class15'/>
## Class 15: Scheduling jobs with cron (part 2)

---

In the first part we schedule jobs using the `at` command. In this second part, we will look at the `cron` jobs.

Recall the script we wrote above, we will make sure that all the commands are available at the right place, by adding the absolute path to them in the script (`which`).

##### **`myscript.sh`**
```bash
#!/bin/bash

logfile=job_results.log

/usr/bin/echo "The script run at the following time: $(/usr/bin/date)." > $logfile
```

We could have used `command1=$(which command)` also to automatically inside the script, but we need to make sure it actually runs before scheduling a job. The `cron` will probably work OK, but it may not run in the same shell environment as we think it will and may negatively impact the scheduled job. Also, there are security reasons for using qualified commands: name matching that executes different malicious scripts.

To schedule a `cron` job we can edit or create a `crontab` file using the desired editor:

```shell
:~$ crontab -e
...
Choose editor:
```

Then the `crontab` file is inside a `/tmp` directory, where we can create and check is OK and then move it to the right place. Inside the file let's type some information to be run:

##### **`/tmp/crontab.qW01Mq/crontab`**
```bash

# For more information see the manual pages of crontab(5) and cron(8)

# m h   dom mon dow     command
30 1 * * 5 /usr/local/bin/script
```
This script will every Friday at 01:30 using the `/usr/local/bin/script`:
- `m` minute, `h` hour (in military time).
- `dom` the day of the month (`*` indicates any month).
- `mon` month (from 1 to 12, or any).
- `dow` days of the week in numbers (5 for Friday, starting from Monday.).
- `command` the full path of the script.

When you exit the file you will see in the terminal:

```shell
:~$ crontab -e
...
Choose editor:
crontab: installing new crontab
```

The last line means is checking the syntax and will install the `crontab` we created.

You can create crontab for other users if you have `sudo` privileges.