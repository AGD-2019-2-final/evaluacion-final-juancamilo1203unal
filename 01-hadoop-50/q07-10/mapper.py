import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
if __name__ == "__main__":
    for line in sys.stdin:
        col1 = ''
        col2 = ''
        col3 = ''
        line = line.strip()

        splits = line.split("  ")

        if len(splits) != 2:
            col1 = splits[0]
            col2 = splits[1] 
            col3 = splits[2]
        print(col1 + '\t' + col2 + '\t' + col3)
