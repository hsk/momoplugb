構文

```
e ::= i | e+e | e-e
```

足し算と引き算ができるだけの言語です。 

評価規則

```prolog
eval(I,I)    :- integer(I).                          % 整数
eval(E1+E2,I):- eval(E1,I1),eval(E2,I2),I is I1+I2.  % 加算
eval(E1-E2,I):- eval(E1,I1),eval(E2,I2),I is I1-I2.  % 減算
```

評価規則は Prolog で書きました。
