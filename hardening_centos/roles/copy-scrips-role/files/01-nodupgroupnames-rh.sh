#!/bin/bash
## Ensure no duplicate group names exist - CentOS or Red Hat Distribution
cut -d: -f1 /etc/group | sort | uniq -d | while read x
do echo "Duplicate group name ${x} in /etc/group"
done
