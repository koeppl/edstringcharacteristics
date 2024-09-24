#!/usr/bin/env python3
""" convert a matrix of strings into readable format for clingo """
# pylint: disable=bad-indentation,line-too-long,invalid-name

import sys


ifilename=sys.argv[1]
outfilename=sys.argv[2]
with open(outfilename, mode='w', encoding='utf-8') as ofile: # b is important -> binary
	with open(ifilename, "rb") as ifile:
		lines = ifile.read().splitlines()
	for i in lines[0]:
		print(f'a("{chr(i)}").', file=ofile)

	print(f'#const r={len(lines)-1}.', file=ofile)
	print(f'#const n={len(lines[1])}.', file=ofile)

	for (textid,text) in enumerate(lines[1:]):
		for (index, val) in enumerate(text):
			print(f't({textid+1},{index+1},"{chr(val)}").', file=ofile)
