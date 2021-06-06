#!/bin/bash
## Ensure no duplicate GIDs exist -- CentOS or Red Hat distributions only
cut -d: -f3 /etc/group | sort | uniq -d | while read x ; do
echo "Duplicate GID ($x) in /etc/group"
done
