#!/usr/bin/env python

import sys
if __name__ == '__main__':

    curkey = None
    suma = 0
    promedio = 0
    cont=0
    
    for line in sys.stdin:
        key, val = line.split("\t")
        val = float(val)
        if key == curkey:
            suma+=val
            cont = cont + 1    
        else:
            if curkey is not None:
                promedio = suma / cont
                sys.stdout.write("{}\t{}\t{}\n".format(curkey, suma, promedio))
            cont=1
            curkey = key
            suma = val
            
    promedio = suma / cont
    sys.stdout.write("{}\t{}\t{}\n".format(curkey, suma, promedio))
