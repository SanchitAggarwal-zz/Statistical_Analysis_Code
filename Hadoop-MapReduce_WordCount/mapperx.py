#!/usr/bin/env python
# % Course     : Cloud Computing
# % Description: Mapper for Word Count
# % Author     : Sanchit Aggarwal
# % Date       : 18-August-2012
# % Copyright (c) 2014 Sanchit Aggarwal. All rights reserved.
import sys
for readline in sys.stdin:
    cleanline = readline.strip()
    words = cleanline.split()    
    for word in words:
	print '%s\t%s' % (word, 1)
