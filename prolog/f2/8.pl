:- use_module(library(clpfd)).

% a) list_to(+N, ?List), que unifica List com uma lista com todos os números inteiros entre 1 e N
list_to(N,List):- list_to(N,List,1).
list_to(N,[N],N):-!.
list_to(N,[C|List],C):- C1 is C + 1, list_to(N,List,C1).

% b) list_from_to(+Inf, +Sup, ?List), que unifica List com uma lista com todos
% os inteiros entre Inf e Sup (ambos incluídos).
list_from_to(Sup,Sup,[Sup]):-!.
list_from_to(Inf,Sup,Result):- Sup < Inf,list_from_to_step(Sup,1,Inf,Partial),reverse_list(Partial,Result),!.
list_from_to(Inf,Sup,[Inf|Rest]):- Inf < Sup,Inf1 is Inf + 1,list_from_to(Inf1,Sup,Rest).

% c) list_from_to_step(+Inf, +Step, +Sup, ?List), que unifica List com uma
% lista contendo os inteiros entre Inf e Sup, em incrementos de Step.
list_from_to_step(Inf,Step,Sup,[]):- Inf is Sup + Step,!.
list_from_to_step(Inf,Step,Sup,Result):- Sup < Inf,list_from_to_step(Sup,Step,Inf,Partial),reverse_list(Partial,Result),!.
list_from_to_step(Inf,Step,Sup,[Inf|Rest]):- Inf1 is Inf + Step,list_from_to_step(Inf1,Step,Sup,Rest).

% d) A segunda linha de b) e c) são as respetivas implementacoes do que é pedido em d)
reverse_list(List,Reversed):- reverse_list(List,[],Reversed).
reverse_list([],Reversed,Reversed).
reverse_list([X|XS],Reversing,Reversed):- reverse_list(XS,[X|Reversing],Reversed).

% e) primes(+N, ?List), que unifica List com uma lista contendo todos os números primos até N
isPrime(N,C):- (C * C) > N,!.
isPrime(N,C):- (N mod C) #\= 0,C1 is C +1 ,isPrime(N,C1).
isPrime(N):- N > 1,isPrime(N,2).

filterPrimes([],[]):-!.
filterPrimes([X|XS],[X|YS]):- isPrime(X),filterPrimes(XS,YS).
filterPrimes([_|XS],YS):- filterPrimes(XS,YS).

primes(N,List):- list_to(N,Range),filterPrimes(Range,List).

% f) fibs(+N, ?List), que unifica List com uma lista com todos os números de Fibonacci de ordem 0 até N
fib(0,0):-!.
fib(1,1):-!.
fib(N,F):- N1 is N - 1, N2 is N - 2,
           fib(N1,F1),fib(N2,F2),
           F is F1 + F2.

fibs(N,[F],N):-fib(N,F),!.
fibs(N,[F|FS],C):-fib(C,F),C1 is C +1 ,fibs(N,FS,C1).
fibs(N,List):- fibs(N,List,0).
