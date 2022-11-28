% Usando este módulo torna tudo muito mais fácil e evita os erros de
% Arguments are not sufficiently instantiated dados por is/2

:- use_module(library(clpfd)).
% factorial(+N,?F)
factorial(0, 1).
factorial(N, F):- 
    N #> 0,
    N1 #= N -1,                     
    F #= F1 * N,                    
    factorial(N1, F1).             

% somaRec(+N,?Sum)
somaRec(0,0).
somaRec(N,Sum):-
    N #> 0,
    N1 #= N -1,
    Sum1 #= Sum - N,
    somaRec(N1,Sum1).

%fibonacci(+N,?F)
fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,F):-
    N #> 0,
    N1 #= N -1,
    N2 #= N- 2,
    fibonacci(N1,F1),
    fibonacci(N2,F2),
    F #= F1 + F2.



% isPrimeHelper(+X,C)
% Aqui é um bom lugar para se usar o cut pois quando passarmos a raiz de X já
% temos a certeza se é ou não primo.
isPrimeHelper(X,C):- C*C > X,!.
isPrimeHelper(X,C):-format("isPrime(~d,~d) resto é ~d \n",[X,C,X mod C]),
    (X mod C) #\= 0,
    C1 #= C+1,
    isPrimeHelper(X,C1).

% isPrime(+X)
isPrime(1).
isPrime(N):- N > 1,isPrimeHelper(N,2).
