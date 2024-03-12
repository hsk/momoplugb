eval(I,I)    :- integer(I).                          % 整数
eval(E1+E2,I):- eval(E1,I1),eval(E2,I2),I is I1+I2.  % 加算
:- eval(1+2+3+4,R),writeln(R).
:- eval((10+20)-(3+4)-2,R),writeln(R).
:- halt.

