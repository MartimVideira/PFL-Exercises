:- use_module(library(clpfd)).
% list_size(+List, ?Size) 
% Determina o Size de List
list_size([],0):-!.
list_size([_|XS],Size):-
    list_size(XS,Size1),
    Size is Size1 + 1.

% list_sum(+List,?Sum)
% Soma Todos os valores contidos em List
list_sum([],0):-!.
list_sum([X|XS],Sum):-
    list_sum(XS,Sum1),
    Sum is Sum1 + X.

% list_prod(+List,?Prod)
% Multiplica Todos os valores contidos em List
list_prod([],1):-!.
list_prod([X|XS],Prod):-
    list_prod(XS,Prod1),
    Prod is Prod1 * X.

% inner_product(+List,+List1,?Prod)
% Calcula o produto escalar entre os dois vetores 
inner_product([],[],0):-!.
inner_product([X|XS],[Y|YS],Result):-
    inner_product(XS,YS,Result1),
    Result is X*Y + Result1.


% count(+Elem,+List,?N).
% Devolve em N o número de ocorrencias de Elem em List
count(_,[],0):-!.
count(Elem,[Elem|XS],N):-
    count(Elem,XS,N1),!,
    N is N1 + 1.
count(Elem,[_|XS],N):- count(Elem,XS,N).
