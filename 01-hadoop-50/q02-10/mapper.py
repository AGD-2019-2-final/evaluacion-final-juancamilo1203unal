import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
if __name__ == "__main__":
    for line in sys.stdin:
        p = ""
        a = ""
        
        line = line.strip()
        splits = line.split(",")

        if len(splits) != 20:
            p = splits[3]
            a = splits[4] 
        print(p + '\t' + a)
