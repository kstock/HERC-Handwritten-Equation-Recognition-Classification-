%INPUT: string
%OUTPUT: class number associated with it


%{

code!!
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
%}

function [ class ] = getClass( exp )

exp;
%if regex didn't match!
if length(exp) == 0
    exp = 0
end


switch exp
    case 'forAll'
        class = 0;
  
    case 'exist'
        class = 1;
        
    case 'neg'
        class = 2;
        
    case 'leftParen'
        class = 3;
        
    case 'rightParen'
        class = 4;
        
    case 'x'
        class = 5;
        
    case 'y'
        class = 6;
        
    case 'z'
        class = 7;
    
    case 'ne'
        class = 8;
            
    case 'elem'
        class = 9;
        
    case 'and'
        class = 10;
        
    case 'or'
        class = 11;
        
    case 'ifThen'
        class = 12;
        
    case 'iff'
        class = 13;
        
    case 'subset'
        class = 14;
        
    case 'F'
        class = 15;
        
    case 'R'
        class = 16;
        
    otherwise 
        class = -1;%error checking
        
        
end %switch

end %function

