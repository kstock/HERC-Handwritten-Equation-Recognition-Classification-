# parse2.parse2('19 19 19 19',[8, 7, 6, 5])
#0 Top 
#1 Top Left 
#2 Left 
#3 Bottom Left 
#4 bottom
#5 bottom right
#6 right
#7 top right
#8 start?

def addSuper(s,pos):
  tokens = s.split()
  lastTok = len(tokens)

  offset = 0
  unbalanced = 0
  i = 0
  while i < lastTok :
    
    if pos[i] == 7:#top right
      tokens.insert(i+offset,'27')
      offset += 1
      unbalanced += 1

    elif pos[i] == 4:#bottom
      if pos[i-1] == 7 : 
      tokens.insert(i+offset,'29')
      offset += 1
      unbalanced += 1


    elif pos[i] == 5:#bottom right
      tokens.insert(i+offset,'28')
      offset += 1
      unbalanced -= 1

    elif i + 1 > lastTok and unbalanced > 0:
      tokens.insert(i+offset,'28')

    i+=1
    
  return ' '.join(tokens)



def parse2(s,pos):

  bar = []
#2 2 2 2 2 -> 2^{22}22    
#8 7 6 5 6 -> 


    



  def traver(tup):
    if hasattr(tup,'__iter__'):
      for subtup in tup:
        traver(subtup)
    else:
      if not tup.isupper():
        #print tup
        bar.append(tup)
        #print bar



  tokens = (
      'BINOP','POW','NEG','TRASH',
      'NAME','NUMBER',
      'PLUS','MINUS','TIMES','DIVIDE','EQUALS',
      'LPAREN','RPAREN','QUANT','VAR',
      )

# Tokens
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
#27 ^{
#28 }
#29 _{
#30 \sum
#31 \int
#32 +
#33 - 
#34 *



  t_PLUS    = r'\+'
  t_MINUS   = r'-'
  t_TIMES   = r'\*'
  t_DIVIDE  = r'/'
  t_EQUALS  = r'='
  t_LPAREN  = r'3| 27 | 29 '
  t_RPAREN  = r'4| 28 '
  t_NEG = r'2'
  t_BINOP = r' 12 | 13 | 14 | 10 | 11 | 9 '
  t_QUANT = r'[01]'
  t_VAR = r'[5678]| 16'
  t_NUMBER = r'17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 '
  t_NAME    = r'[a-zA-Z_][a-zA-Z]*'
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


#def t_NUMBER(t):
#    r'\d+'
#    try:
#        t.value = int(t.value)
#    except ValueError:
#        print("Integer value too large %d", t.value)
#        t.value = 0
#    return t

# Ignored characters

  t_ignore = " \t"

  def t_newline(t):
      r'\n+'
      t.lexer.lineno += t.value.count("\n")
      
  def t_error(t):
      print("Illegal character '%s'" % t.value[0])
      t.lexer.skip(1)
      
# Build the lexer
  import ply.lex as lex
  lex.lex()

# Parsing rules

#precedence = (
#    ('left','PLUS','MINUS'),
#    ('left','TIMES','DIVIDE'),
#    ('right','UMINUS'),
#    )

# dictionary of names
  names = { }
  global foo
  foo = ''


  def p_statement_assign(t):
      'statement : NAME EQUALS expression'
      names[t[1]] = t[3]

  def p_statement_expr(t):
      'statement : expression'
      #print(t[1])
      t[0] = ('EXP',t[1])
      
#if len(t) < 3:
#      t[0] = ('EXP',[t[1]])
#    else:
#      print 'FUCK'
#      t[1][1].append(t[2])
#      t[0] = t[1]

  def p_expression_binop(t):
      '''expression : expression BINOP expression '''
                      #| expression BINOP expression
#expression
#                    | BINOP'''
      #global foo
      #foo =  t[1] + code[int(t[2])] + t[3] +foo     
      #t[0] = foo#t[1] + code[12] + t[3] +foo
      
      t[0] = ('BINOP', t[1],code[int(t[2])],t[3])



  def p_expression_uminus(t):
      'expression : NEG expression' # %prec UMINUS'
      #global foo
      #foo += code[1]
      #t[0] = foo#str(-t[2])
      t[0] = ('NEG',code[int(t[1])],t[2])  

  def p_expression_group(t):
      '''expression : LPAREN expression RPAREN
                    | LPAREN expression RPAREN expression '''

      if len(t) < 5:
        t[0] = ('PAREN', code[int(t[1])] , t[2], code[int(t[3])] )
      else:
        t[0] = ('PAREN', code[int(t[1])] , t[2], code[int(t[3])],t[4] )


#def p_expression_number(t):
#    'expression : NUMBER'
#    t[0] = t[1]

  def p_expression_quant(t):
      '''expression : QUANT VAR
                    | QUANT VAR expression '''
      if len(t) < 4:
        t[0] = ('QUANT',code[int(t[1])], code[int(t[2])] )
      else:
        print 'expressions!!'
        t[0] = ('QUANT',code[int(t[1])], code[int(t[2])] ,t[3])

  def p_expression_number(t):
      '''expression : NUMBER
                    | NUMBER expression '''

      line = t.lexpos(1)

      print (line,line)
      if len(t) < 3: #NUMBER 

      #  if pos[line] == 6 and paren[0] > 0:
      #    t[0] = ('NUMBER',code[int(t[1])], '}')
      #    paren[0] -= 1
      #  else:
        t[0] = ('NUMBER',code[int(t[1])])

      else: #NUMBER expression 
     #   if pos[line] == 7:
     #     t[0] = ('NUMBER',code[int(t[1])], '^{', t[2])
     #     paren[0] += 1
     #   else:
        t[0] = ('NUMBER',code[int(t[1])], t[2])


  def p_expression_var(t):
      'expression : VAR '
      global foo
      t[0] = ('VAR',code[int(t[1])])


  def p_expression_pow(t):
      'expression : VAR POW expression '
      global foo
      t[0] = ('POW',code[int(t[1])],t[3])



  def p_expression_name(t):
      'expression : NAME'
      try:
          t[0] = names[t[1]]
      except LookupError:
          print("Undefined name '%s'" % t[1])
          t[0] = 0


#def p_empty(p):
#    'empty :'
#    pass

  def p_expression_trash(t):
      'expression : TRASH expression'
      print 'HERE'
      t[0] = ('TRASH', t[2])

  def find_column(input_str, token):
      last_cr = input_str.rfind('\n',0,token.lexpos)
      if last_cr < 0:
          last_cr = 0
      column = (token.lexpos - last_cr) + 1
      return column


  def p_error(t):
    #  t = 'TRASH'
#      print 'fuck'
   #   yacc.restart()
    print("Syntax error at '%s'" % t.value)



  import ply.yacc as yacc
  yacc.yacc()

  #while 1:
      #try:
      #    s = input('calc > ')   # Use raw_input on Python 2
      #except EOFError:
      #    break

  foo = ''
  #pos = [1,2,3]
  paren = [0]
  s = addSuper(s,pos)
  print s
  yay = yacc.parse(s,tracking=True)
  traver(yay)
  print ''.join(bar)

  
#open for appending, creates if doesn't already exist
  f = open('test.tex', 'w+')

  startDoc = '\\documentclass[a4paper,12pt]{article} \n \\begin{document}\n $'
  endDoc = '$\n \\end{document}'

  f.write(startDoc)
  

  f.write(''.join(bar))

  f.write(endDoc)
  
  f.close()

