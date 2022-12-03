% a) is_ordered(+List) que sucede se List é uma lista de inteiros ordenados de
% forma ascendente.
is_ordered([]).
is_ordered([_]).
is_ordered([X,X1|XS]):- X =< X1, is_ordered([X1|XS]).

% b) insert_ordered(+Value, +List1, ?List2), que insere Value em List1,
% mantendo a ordenação dos elementos, colocando o resultado em List2.
insert_ordered(V,[],[V]):-!.
insert_ordered(V,[X|XS],[V,X|XS]):- V =< X,!.
insert_ordered(V,[X|XS],[X|YS]):- V > X,insert_ordered(V,XS,YS).

% c) insert_sort(+List,?OrderedList) ordena List e devolve em OrderedList

insert_sort([],[]):-!.
insert_sort([X],[X]):-!.
insert_sort([X|XS],Sorted):- insert_sort(XS,SortedRec),insert_ordered(X,SortedRec,Sorted).

% Um sort á prolog
% Del One that fails whenever it can't delete the value
del_one(X,[X],[]).
del_one(X,[X|XS],XS).
del_one(X,[Y|XS],[Y|YS]):- X\=Y,del_one(X,XS,YS).


same_elements([],[]).
same_elements([X|XS],YS):- del_one(X,YS,YS1),same_elements(XS,YS1). 

prolog_sort(toSort,Sorted):-
    same_elements(toSort,Sorted),
    is_ordered(Sorted).

prolog_sort2([X|XS],Sorted):-
    del_one(X,Sorted,Sorted1),
    is_ordered(Sorted),
    prolog_sort2(XS,Sorted1).
