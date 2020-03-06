import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
if __name__ == "__main__":
    for line in sys.stdin:
        col2 = ''
        line = line.strip()

        splits = line.split("  ")

        if len(splits) != 2: 
            col2 = splits[1] 
        for x in col2:
            col2S = col2.split("-")
        print(col2S[1]+ '\t1')
        