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
        
    case 'zero'
        class = 17;
        
    case 'one'
        class = 18;
        
    case 'two'
        class = 19;
        
    case 'three'
        class = 20;
        
    case 'four'
        class = 21;
        
    case 'five'
        class = 22;
        
    case 'six'
        class = 23;
        
    case 'seven'
        class = 24;
        
    case 'eight'
        class = 25;
        
    case 'nine'
        class = 26;
    case 'sigma'
        class = 26;
    
    case 'nine'
        class = 30;
    case 'integral'
        class = 31;
    case 'plus'
        class = 32;
    case 'minus'
        class = 33;
    case 'star'
        class = 34;
    otherwise 
        class = -1;%error checking
        
        
end %switch

end %function

