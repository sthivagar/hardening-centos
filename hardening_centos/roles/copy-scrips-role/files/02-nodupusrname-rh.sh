#!/bin/bash
## Ensure no duplicate user names exist - CentOS or Red Hat Distributions
cut -d: -f1 /etc/passwd | sort | uniq -d | while read x
do echo "Duplicate login name ${x} in /etc/passwd"
done
