#!/bin/bash

for prefix in $(seq 10 10 1000); do 
	for nprocs in 1 4 8 16 32 48 64; do
		[[ $nprocs -gt $(nproc) ]] && continue
		for algo in maw mus; do
			output=$(clingo --time-limit=3600 -t ${nprocs} encoding/${algo}.lp sample/random.lp --const n=${prefix})
			if echo $output | grep -q 'OPTIMUM FOUND'; then
				time=$(echo "$output" | grep 'CPU Time' | sed 's@CPU Time     : @@')
				echo "RESULT algo=${algo} n=${prefix} procs=${nprocs} seconds=$time"
			else
				echo "RESULT algo=${algo} n=${prefix} procs=${nprocs} seconds=timeout"
			fi
		done
	done
done
