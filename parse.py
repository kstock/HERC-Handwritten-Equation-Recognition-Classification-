import scipy,numpy
from scipy import io

# reads in a .mat, 
# currectly does a linear substitution parse
# more to come!!
# writes a .tex file!

#decoding the code!!
#1: \\forall
#2  \\exists
#3  \\neg
#4  \\left(
#5  \\right)
#6  x
#7  y
#8  z
#9  \\neq
#10 \\in
#11 \\wedge
#12 \\vee
#13 \\rightarrow
#14 \\leftrightarrow
#15 \\subset
#16 F
#17 R
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
labels = scipy.io.loadmat('parse2.mat')
mat = labels['pred'][0]
print mat
#mat = range(1,17)
for symbol in mat:
  f.write(code[symbol])
  print code[symbol]


f.write(endDoc)
