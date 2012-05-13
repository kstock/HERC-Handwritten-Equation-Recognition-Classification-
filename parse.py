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
       ]


#open for appending, creates if doesn't already exist
f = open('test.tex', 'a+')

startDoc = '\\documentclass[a4paper,12pt]{article} \n \\begin{document}\n $'
endDoc = '$\n \\end{document}'

f.write(startDoc)



#returns dict with key as matrix name, matrix as val
labels = scipy.io.loadmat('parse.mat')
mat = labels['parse']#[0]
print mat
#mat = range(1,17)
#mat = [0,5,1,6,16,5,6]
for symbol in mat:
  f.write(code[symbol])
  print code[symbol]


f.write(endDoc)
