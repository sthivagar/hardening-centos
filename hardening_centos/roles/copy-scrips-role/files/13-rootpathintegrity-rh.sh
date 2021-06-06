#!/bin/bash
Ensure root PATH Integrity - CentOS or Red Hat Enterprise Linux distribution
for x in $(echo $PATH | tr ":" " ") ; do
  if [ -d "$x" ] ; then
    ls -ldH "$x" | awk '
$9 == "." {print "PATH contains current working directory (.)"}
$3 != "root" {print $9, "is not owned by root"}
substr($1,6,1) != "-" {print $9, "is group writable"}
substr($1,9,1) != "-" {print $9, "is world writable"}'
  else
    echo "$x is not a directory"
  fi
done
