% factorial(+N,?F)
fatorial(0,1):-!.
fatorial(N,F):-
    N > 0,
    N1 is N - 1,
    fatorial(N1,F1),
    F is N * F1.

% somaRec(+N,?Sum)
somaRec(0,0):-!.
somaRec(N,Sum):-
    N > 0,
    N1 is N - 1,
    somaRec(N1,Sum1),
    Sum is Sum1 + N.

%fibonacci(+N,?F)
fibonacci(0,0):-!.
fibonacci(1,1):-!.
fibonacci(N,Fib):-
    N > 0,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1,Fib1),
    fibonacci(N2,Fib2),
    Fib is Fib1 + Fib2.

% isPrimeHelper(+X,C)
% Aqui é um bom lugar para se usar o cut pois quando passarmos a raiz de X já
% temos a certeza se é ou não primo.
isPrimeHelper(X,N):- N * N > X,!.
isPrimeHelper(X,N):-
    \+( 0 is X mod N),
    N1 is N + 1,
    isPrimeHelper(X,N1).

% isPrime(+X)
isPrime(X):- 
    X > 1,
    isPrimeHelper(X,2).

