#!/usr/bin/env python

import sys
if __name__ == '__main__':

    curkey = None
    listakey = []
    listafecha = []
    listaval = []

    for line in sys.stdin:
        key, fecha, val = line.split("\t")
        val = int(val)
        if key == curkey:
            listakey.append(key)
            listafecha.append(fecha)
            listaval.append(val)
        else:
            if curkey is not None:
                sl = sorted(listaval)
                lista2 = []
                for x in sl:
                    lista2.append(listaval.index(x))
                for y in lista2:
                    sys.stdout.write("{}\t{}\t{}\n".format(listakey[y], listafecha[y], listaval[y]))
            curkey = key
            listakey = [key]
            listafecha = [fecha]
            listaval = [val] 
    sl = sorted(listaval)
    lista2 = []
    for x in sl:
        lista2.append(listaval.index(x))
    for y in lista2:
        sys.stdout.write("{}\t{}\t{}\n".format(listakey[y], listafecha[y], listaval[y]))
            
