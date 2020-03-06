#!/usr/bin/env python

import sys
if __name__ == '__main__':

    curkey = None
    total1 = 0
    total2 = 0

    for line in sys.stdin:
        key, val = line.split("\t")
        val = float(val)
        if key == curkey:
            if total1 > val:
                total1 = total1
            else:
                 total1 = val
                    
            if total2 < val:
                total2 = total2
            else:
                 total2 = val
        else:
            if curkey is not None:
                sys.stdout.write("{}\t{}\t{}\n".format(curkey, total1, total2))
            curkey = key
            total1 = val
            total2 = val

    sys.stdout.write("{}\t{}\t{}\n".format(curkey, total1, total2))
