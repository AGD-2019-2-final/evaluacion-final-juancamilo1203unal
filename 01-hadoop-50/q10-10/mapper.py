import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
if __name__ == "__main__":
    for line in sys.stdin:
        col1 = ''
        col2 = ''
        
        line = line.strip()
        splits = line.split("\t")
        
        if len(splits) != 1: 
            col1 = splits[0].rjust(4)
            col2 = splits[1].split(",")
            
        for letra in col2:  
            print(letra + '\t' + col1)