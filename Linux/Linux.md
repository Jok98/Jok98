| Command | Usage | Description |
|---|---|---|
| `sudo` | `sudo [command]` | Run a command with administrator privileges. |
| `ls` | `ls [options] [directory]` | List the contents of a directory. | 
| `cd` | `cd [directory]` | Change the current directory. |
| `mkdir` | `mkdir [options] [directory]` | Create a new directory. |
| `rmdir` | `rmdir [options] [directory]` | Delete an empty directory. |
| `touch` | `touch [file]` | Create a new empty file. |
| `cat` | `cat [file]` | Display the contents of a file. |
| `nano` | `nano [file]` | Open a text editor to edit a file. |
| `cp` | `cp [options] <source> <destination>` | Copy a file or directory. |
| `mv` | `mv [options] <source> <destination>` | Move or rename a file or directory. |
| `rm` | `rm [options] <file>` | Delete a file or directory. |

### File Management and Manipulation
| Command | Usage | Description |
|---|---|---|
| `grep` | `grep [pattern] [file]` | Search for text patterns within files. |
| `find` | `find [path] [options] [expression]`  | Locate files based on various criteria. |
| `head` | `head [file]` | Display the first few lines of a file. |
| `tail` | `tail [file]` | Display the last few lines of a file. |
| `sort` | `sort [file]` | Sort the lines of a file. |
| `chmod` | `chmod [permissions] [file]` | Change file and directory permissions. |
| `chown` | `chown [user:group] [file]` | Change file ownership. |


### Networking
| Command | Usage | Description |
|---|---|---|
| `ping` | `ping [hostname or IP]` | Check connectivity to a host. |
| `ifconfig` | `ifconfig` | Display network interface configuration. |
| `ip` | `ip [object] [command]` |  Modern replacement for `ifconfig`.
| `wget` | `wget [URL]` | Download files from the web. |
| `curl` | `curl [URL]` | Transfer data to/from a server. |

### System Information & Processes
| Command | Usage | Description |
|---|---|---|
| `top` | `top` | Real-time view of processes and system resources. |
| `htop` | `htop` | Interactive process viewer |
| `ps` | `ps [options]` | List running processes. |
| `kill` | `kill [PID]` | Send a signal to terminate a process. |
| `df` | `df -h` | Display disk space usage (human-readable). |
| `du` | `du -sh [directory]` | Estimate disk space usage of a directory. | 
| `free` | `free` | Show memory usage information. |

### Compression and Archiving
| Command | Usage | Description |
|---|---|---|
| `tar` | `tar [options] [archive] [files]` | Create and manipulate tar archives. |
| `gzip` | `gzip [file]` | Compress files (gzip format). |
| `gunzip` | `gunzip [file.gz]` | Decompress gzip files. |

### Add an alias for a command
```bash
nano ~/.bashrc
```
Add the following line to the end of the file:
```bash
alias k='kubectl'
```