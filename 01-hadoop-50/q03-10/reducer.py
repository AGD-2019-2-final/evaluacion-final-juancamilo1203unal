#!/usr/bin/env python

import sys
if __name__ == '__main__':

    for line in sys.stdin:

        key, val = line.split("\t")
        key= int(key)
        val= str(val)
        sys.stdout.write("{},{}\n".format(val.rstrip(), key))
