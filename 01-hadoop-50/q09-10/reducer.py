#!/usr/bin/env python

import sys
if __name__ == '__main__':

    for line in sys.stdin:
        key, val1, val2 = line.split("\t")
        key= int(key)
        if key == 1 or key == 2 or key == 4 or key == 5 or key == 6:
            sys.stdout.write("{}\t{}\t{}\n".format(val2.rstrip(), val1, key ))
      
