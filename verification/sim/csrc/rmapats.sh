#!/bin/sh -f
cd "/home/users15/mu832615/ECE698C/addressing_implmentation/verification/sim"
PIDS=""
cd "/home/users15/mu832615/ECE698C/addressing_implmentation/verification/sim/csrc/"
make  -f Makefile.hsopt -j 8 rmapats.so &
PIDS+=" $!"
cd "/home/users15/mu832615/ECE698C/addressing_implmentation/verification/sim"

STATUS=""
for pid in ${PIDS[@]}; do
	wait ${pid}
	STATUS+=" $?"
done

for st in ${STATUS[@]}; do
	if [[ ${st} -ne 0 ]]; then
		exit -1
	fi
done

PIDS=""

exit 0
