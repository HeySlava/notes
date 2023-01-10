[Good source with examples](https://www.tecmint.com/rsync-local-remote-file-synchronization-commands/)
Some common options used with rsync commands

    -v : verbose
    -r : copies data recursively (but don’t preserve timestamps and permission while transferring data.
    -a : archive mode, which allows copying files recursively and it also preserves symbolic links, file permissions, user & group ownerships, and timestamps.
    -z : compress file data.
    -h : human-readable, output numbers in a human-readable format.

To sync remote folder I have to have rsync on my remote machine


--delete is option to delete file on destination If I deleted it from source



to work
https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories
https://linuxhint.com/rsync_copy_files/
https://linuxize.com/post/how-to-use-rsync-for-local-and-remote-data-transfer-and-synchronization/
https://phoenixnap.com/kb/rsync-command-linux-examples
