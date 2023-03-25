# Bash Scripting on Linux

---

This course is given by the Learn Linux TV channel on YouTube:

https://www.youtube.com/playlist?list=PLT98CRl2KxKGj-VKtApD8-zCqSaN2mD4w

<!---

## TOC Classes

---

16. [Backup Script](#id-class17)

<div id='id-class17'/>
--->
## Class 17: Backup Script

---

A more advanced script will be written in this final class. Let's create a script named `backup.sh`:

```bash
:~$ touch backup.sh
:~$ nano backup.sh
```

##### **`myscript.sh`**
```bash
#!/bin/bash

# Check to make sure the user input exactly two arguments
if [ $# -ne 2 ]; then
    echo "Usage: backup.sh <source_directory> <target_directory>"
    echo "Please try again."

    exit 1
fi

# Check to see if rsync is installed
if ! command -v rsync /dev/null 2>&1; then
    echo "This script requires rsync to be installed."
    echo "Please use your distribution package manager to install it and try again."

    exit 2
fi

# Capture the current date, and store it in the format YYYY-MM-DD
current_date=$(date +%Y-%m-%d)

rsync_options="-avb --backup_dir=$2/current_date --delete --dry-run"

$(which rsync) $rsync_options $1 $2/current >> backup$_current_date.log
```

The `! command -v` in the second `if` statement check if `rsync` is not installed. If it is installed, the statement send the `stdout` to the `/dev/null` without printing the output. The `!` is the negation operator.

The `-avb` are archive, verbose and the `b` means you can store many versions of a file as a backup. You can also have a backup directory `--backup-dir` in addition to `b`. The `rsync` command will create the directory if it does not exist. The `--delete` makes sure that the target directory is a clone of the source directory. Finally, the `--dry-run` option create a simulation what it would have done if you didn't have the option on: it's sort of a demo mode for the command. This option is useful the first time you run the script to make sure you don't blow things up or break anything in production stages.

In the last line, the command is executed with the options and arguments, appending a subfolder `current` to target directory. Then, it sends all the `stdout` to a log file that changes names according to the date. So, we will have different folder with dates and different log files with dates. Be aware that the `stdout` in the last line will be appended to the log file for the same day.

NOTE: A backup means a copy of data to another server and not to the same one.

When you executed the script as it is, you can see the log file with the `stdout`, and in the last line the `(DRY RUN)` message will output. This means that you are running with this mode. So the backup is not yet done, but the log files are created to check the script.

You want to run the script as well just with one input also, to make sure it catches the error.

When you are sure, remove the `--dry-run` option from the script and run it again for the real case.

If you make a change in the source directory and run the script again, you can see the files that actually changed in the source directory and were updated in the target directory. This will create a new subfolder `current/backup_date` with the updates.