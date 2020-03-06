#!/usr/bin/env python

import sys
if __name__ == '__main__':

    curkey = None
    lista = []

    for line in sys.stdin:

        key, val = line.split("\t")
        val = int(val)
        
        
        if key == curkey:
            
            lista.append(val)
            
        else:
            
            if curkey is not None:
                sys.stdout.write("{}\t".format(curkey))
                b = 1
                for y in lista:
                    if b == 1:
                        b = 0
                        sys.stdout.write("{}".format(y))
                    else:
                        sys.stdout.write(",{}".format(y))
                sys.stdout.write("\n".format())
            curkey = key
            lista =[val]
            
    #sys.stdout.write("{}\t{}\n".format(curkey, lista))
    
    sys.stdout.write("{}\t".format(curkey))
    b = 1
    for y in lista:
        if b == 1:
            b = 0
            sys.stdout.write("{}".format(y))
        else:
            sys.stdout.write(",{}".format(y))
    sys.stdout.write("\n".format())
