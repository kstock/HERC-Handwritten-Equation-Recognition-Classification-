%INPUT: string
%OUTPUT: class number associated with it


%{

code!!
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
18 OTHER ERROR!!!!
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
    
    case 'neg'
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

end%function

