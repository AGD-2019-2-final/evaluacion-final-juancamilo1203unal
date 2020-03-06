#!/usr/bin/env python

import sys
if __name__ == '__main__':
    for line in sys.stdin:
        key, val1,val2 = line.split("\t")
        sys.stdout.write("{},{},{}\n".format(val1, key.strip(), val2.rstrip('\n').strip()))
