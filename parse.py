import scipy,numpy
from scipy import io

# reads in a .mat, 
# currectly does a linear substitution parse
# more to come!!
# writes a .tex file!

#decoding the code!!
#0: \\forall
#1  \\exists
#2  \\neg
#3  \\left(
#4  \\right)
#5  x
#6  y
#7  z
#8  \\neq
#9 \\in
#10 \\wedge
#11 \\vee
#12 \\rightarrow
#13 \\leftrightarrow
#14 \\subset
#15 F
#16 R
#17 0
#18 1
#19 2
#20 3
#21 4
#22 5
#23 6
#24 7
#25 8
#26 9
#-1 OTHER ERROR!!!!
  code = [
          ' \\forall ',
          ' \\exists',
          ' \\neg',
          ' \\left(',
          ' \\right)',
          ' x',
          ' y',
          ' z',
          ' \\neq',
          ' \\in',
          ' \\wedge',
          ' \\vee',
          ' \\rightarrow',
          ' \\leftrightarrow',
          ' \\subset',
          ' F',
          ' R',
          '0',
          '1',
          '2',
          '3',
          '4',
          '5',
          '6',
          '7',
          '8',
          '9',
          '^{',
          '}',
          '_{',
          '\\sum',
          '\\int',
          '+',
          '-',
          '*'
         ]

#open for appending, creates if doesn't already exist
f = open('test.tex', 'a+')

startDoc = '\\documentclass[a4paper,12pt]{article} \n \\begin{document}\n $'
endDoc = '$\n \\end{document}'

f.write(startDoc)



#returns dict with key as matrix name, matrix as val
labels = scipy.io.loadmat('parse.mat')
#labels = scipy.io.loadmat('parseTILDE.mat')
#labels = scipy.io.loadmat('mat/parse50train_tildeNeg.mat')
mat = labels['parse']#[0]
#print mat
#mat = range(1,17)
#mat = [0,5,1,6,16,5,6]
#mat = [5,14,6, 13, 0,7, 3, 7,9,5,12,7,9,6,4,10,1,7,3,7,9,6,10,2,3,7,9,6,4,4] 

posMat = [8,7,6]

i = 0
while i < len(mat):

  if posMat[i] == 7: #if top right
    f.write('^{')
    print '^{'
    f.write(code[mat[i]])
    print code[ mat[i] ]
    i += 1


    while i < len(posMat) and posMat[i] == 6: # right, so still in superscript
      f.write(code[mat[i]])
      
      print code[ mat[i] ]

      if i < len(posMat):
        i += 1
      
    f.write('}')
    print '}'

  if i < len(posMat):
    f.write(code[ mat[i] ])
    print code[ mat[i] ]
    i += 1

  #print symbol

f.write(endDoc)
