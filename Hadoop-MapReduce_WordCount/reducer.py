#!/usr/bin/env python
# % Course     : Cloud Computing
# % Description: Reducer For Word Count
# % Author     : Sanchit Aggarwal
# % Date       : 18-August-2012
# % Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.
from operator import itemgetter
import sys
curr_word = None
curr_count = 0
word = None

for readline in sys.stdin:
    line = readline.strip()
    word, count = line.split('\t', 1)
    try:
        count = int(count)
    except ValueError:
        continue
    if curr_word == word:
        curr_count += count
    else:
        if curr_word:
            print '%s\t%s' % (curr_word, curr_count)
        curr_count = count
        curr_word = word
if curr_word == word:
    print '%s\t%s' % (curr_word, curr_count)
