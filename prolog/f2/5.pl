:- use_module(library(clpfd)).
% list_size(+List, ?Size) 
% Determina o Size de List
list_size([],0).
list_size([_|XS],Size):- Size1 #= Size - 1 ,list_size(XS,Size1).

% list_sum(+List,?Sum)
% Soma Todos os valores contidos em List
list_sum([],0).
list_sum([X|XS],Sum):- SumTail #= Sum - X,list_sum(XS,SumTail).

% list_prod(+List,?Prod)
% Multiplica Todos os valores contidos em List
list_prod([],1).
list_prod([X|XS],Prod):- Prod #= ProdTail * X,list_prod(XS,ProdTail).


% inner_product(+List,+List1,?Prod)
% Calcula o produto escalar entre os dois vetores 
inner_product([],[],0).
inner_product([X|XS],[Y|YS],Prod):-
    Prod #= ProdRest + Y*X,
    inner_product(XS,YS,ProdRest).


% count(+Elem,+List,?N).
% Devolve em N o número de ocorrencias de Elem em List
count(_,[],0).
count(Elem,[Elem|XS],N):- N1 #= N -1, count(Elem,XS,N1).
count(Elem,[X|XS],N):- Elem \= X,count(Elem,XS,N).
