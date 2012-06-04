
# -----------------------------------------------------------------------------
# calc.py
#
# A simple calculator with variables -- all in one file.
# -----------------------------------------------------------------------------


tokens = (
    'BINOP','POW',
    'NAME',#'NUMBER',
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

t_PLUS    = r'\+'
t_MINUS   = r'-'
t_TIMES   = r'\*'
t_DIVIDE  = r'/'
t_EQUALS  = r'='
t_LPAREN  = r'3'
t_RPAREN  = r'4'
t_BINOP = r' 12 | 13 | 14 | 10 | 11 | 9 '
t_QUANT = r'[01]'
t_VAR = r'[5678]| 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 '
#t_NUMBER = '17'
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
        '9'
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

precedence = (
    ('left','PLUS','MINUS'),
    ('left','TIMES','DIVIDE'),
    ('right','UMINUS'),
    )

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
    if len(t) < 3:
      t[0] = ('EXP',[t[1]])
    else:
      print 'FUCK'
      t[1][1].append(t[2])
      t[0] = t[1]

def p_expression_binop(t):
    '''expression : expression BINOP expression '''
                    #| expression BINOP expression
#expression
#                    | BINOP'''
    #global foo
    #foo =  t[1] + code[int(t[2])] + t[3] +foo     
    #t[0] = foo#t[1] + code[12] + t[3] +foo
    
    t[0] = ('BINOP',code[int(t[2])], t[1],t[3])



def p_expression_uminus(t):
    'expression : MINUS expression %prec UMINUS'
    global foo
    foo += code[1]
    t[0] = foo#str(-t[2])

def p_expression_group(t):
    'expression : LPAREN expression'
    global foo
    foo = code[3] + foo 
    t[0] = foo

def p_expression_group2(t):
    'expression : RPAREN '
    global foo
    global bar
    
    bar = code[4]
    t[0] = foo 



#def p_expression_number(t):
#    'expression : NUMBER'
#    t[0] = t[1]

def p_expression_quant(t):
    '''expression : QUANT VAR
                  | QUANT VAR expression '''
    global foo
    foo = code[int(t[1])] + code[int(t[2])] + foo
    t[0] = foo 
    if len(t) < 4:
      t[0] = ('QUANT',code[int(t[1])], code[int(t[2])] )
    else:
      print 'expressions!!'
      t[0] = ('QUANT',code[int(t[1])], code[int(t[2])] ,t[3])

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


def p_error(t):
    print("Syntax error at '%s'" % t.value)

import ply.yacc as yacc
yacc.yacc()

while 1:
    try:
        s = input('calc > ')   # Use raw_input on Python 2
    except EOFError:
        break

    foo = ''
    yay = yacc.parse(s)
    print yay
