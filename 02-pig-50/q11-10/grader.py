
##! /usr/local/bin/python3
r"""Test cases
>>> run_answer() # doctest: +NORMALIZE_WHITESPACE
Boyer,BOYER,boyer
Coffey,COFFEY,coffey
Conway,CONWAY,conway
Crane,CRANE,crane
Diaz,DIAZ,diaz
Estes,ESTES,estes
Fry,FRY,fry
Garrett,GARRETT,garrett
Guy,GUY,guy
Hamilton,HAMILTON,hamilton
Holcomb,HOLCOMB,holcomb
Jarvis,JARVIS,jarvis
Kinney,KINNEY,kinney
Klein,KLEIN,klein
Knight,KNIGHT,knight
Noel,NOEL,noel
Sexton,SEXTON,sexton
Silva,SILVA,silva
<BLANKLINE>

"""
import doctest
import subprocess
import os

def run_answer():
    '''Codigo especifico para ejecutar la respuesta'''
    #----------------------------------------------------------------------------------------------
    # Ejecuta el código del estudiante
    #----------------------------------------------------------------------------------------------
    result = os.popen("pig -execute 'run question.pig'").read()
    result = os.popen("cat output/*").read()
    print(result)

#--------------------------------------------------------------------------------------------------
# Grader (generic)
#--------------------------------------------------------------------------------------------------
subprocess.run(['rm', '-f', '_SUCCESS']) # borra el flag de exito de la corrida
RESULT = doctest.testmod()               # ejecuta el doctest
FAIL, _ = RESULT                         # fail, total
if FAIL == 0:                            # grading
    open('_SUCCESS', 'a').close()        #
else:
    print('\n')
#--------------------------------------------------------------------------------------------------
