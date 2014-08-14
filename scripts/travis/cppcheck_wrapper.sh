#!/usr/bin/env bash

# The goal is to remove the suppressed checks stepwise and fix the issues
# in the same commit. Use cppcheck --inline-suppr for false positives.
sup_warn="--suppress=nullPointer"
sup_info="--suppress=ConfigurationNotChecked"
suppress="$sup_warn $sup_info"
enabled="--enable=warning --enable=information --enable=performance \
         --enable=portability --enable=missingInclude --enable=style"
# Travis kills the check if he does not see output for some time
( while true; do sleep 300; echo "cppcheck in progress ..."; done) &
# Exit code '1' is returned if arguments are not valid or if no input
# files are provided. Compare 'cppcheck --help'.
cppcheck -f -q --inline-suppr --error-exitcode=2 $enabled $suppress "$@"
