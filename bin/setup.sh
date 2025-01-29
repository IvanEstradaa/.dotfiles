
sudo find $PWD/bin/ -mindepth 1 -maxdepth 1 -type f ! -name 'setup.sh' ! -exec test -e /usr/local/bin/$(basename {}) \; -exec ln -s {} /usr/local/bin/ \;

# This is a simple script that will symlink all the files in the bin/ directory to /usr/local/bin/
# The script will ignore the setup.sh file and symlink all the other files in the bin/ directory to /usr/local/bin/
# The script will also ignore any subdirectories in the bin/ directory, thats why we use the -mindepth 1 -maxdepth 1 flags
# The -mindepth 1 flag tells find to start searching from the bin/ directory and not include the bin/ directory itself
# The -maxdepth 1 flag tells find to only search one level deep, so it will not include any subdirectories in the bin/ directory
# The -type f flag tells find to only include files in the search
# The ! -name 'setup.sh' flag tells find to exclude the setup.sh file from the search
# The -exec ln -s {} /usr/local/bin/ \; flag tells find to execute the ln -s command on each file found, creating a symlink in /usr/local/bin/ for each file
# The {} is a placeholder for the file found by find, and the \; tells find that the command is finished
# The sudo command is used to run the find command with root privileges, as creating symlinks in /usr/local/bin/ requires root access
# The script can be run by executing the bin/setup.sh command in the terminal from the project root directory