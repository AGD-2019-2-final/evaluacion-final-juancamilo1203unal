import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
if __name__ == "__main__":
    for line in sys.stdin:
        bandera = 0
        for palabra in line.split(','):
            if bandera == 2:
                sys.stdout.write("{}\t1\n".format(palabra))
            bandera+=1