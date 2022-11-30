% invert(+List1, ?List2)
% Inverte a lista
invert(List1,List2):- invertRec(List1,[],List2).

invertRec([X|XS],Reversing,Reversed):- invertRec(XS,[X|Reversing],Reversed).
invertRec([],Reversed,Reversed).

% del_one(+Elem, +List1, ?List2)
% Apaga uma ocorrência de Elem de List1, resultando em List2.
del_one(_,[],[]).
del_one(Elem,[Elem|XS],XS).
del_one(Elem,[X|XS],[X|YS]):- Elem \=X ,del_one(Elem,XS,YS).

% del_all(+Elem, +List1, ?List2)
% Apaga todas ocorrências de Elem de List1, resultando em List2.
del_all(_,[],[]).
del_all(Elem,[Elem|XS],YS):- del_all(Elem,XS,YS). 
del_all(Elem,[X|XS],[X|YS]):- Elem \=X,del_all(Elem,XS,YS).

% del_all_list(+ListElems, +List1, ?List2)
% apaga de List1 todas as ocorrências de todos os elementos de ListElems, resultando em List2
del_all_list([], List1, List1).
del_all_list([X|XS], List1, List2):- del_all(X,List1,YS),del_all_list(XS,YS,List2).

% del_dups(+List1, ?List2), que elimina valores repetidos de List1.
del_dups([],[]).
del_dups([X|XS],[X|YS]):- del_all(X,XS,Z),del_dups(Z,YS).

% length(+List1,?len) determina o tamanho da lista
my_length([],0).
my_length([_|XS],Len):- length(XS,Len1), Len is Len1 + 1.

% list_perm (+L1, +L2) que sucede se L2 for uma permutação de L1.
list_perm([],[]).
list_perm([X|XS],L2):- my_length(XS,LenXS),
    my_length(L2,LenL2),
    LenL2 is LenXS +1,
    del_one(X,L2,Z),list_perm(XS,Z).

% g) replicate(+Amount, +Elem, ?List) que gera uma lista com Amount repetições de Elem.
replicate(0,_,[]):-!.
replicate(N,Elem,[Elem|Rest]):- N1 is N - 1, replicate(N1,Elem,Rest).

% h) intersperse(+Elem, +List1, ?List2) que intercala Elem entre os elementos de List1, devolvendo o resultado em List2.
intersperse(_,[X],[X]).
intersperse(Elem,[X|XS],[X,Elem|YS]):- intersperse(Elem,XS,YS).

% i)  insert_elem(+Index, +List1, +Elem, ?List2), que insere Elem em List1 no índice Index, daí resultando List2.
insert_elem(0,List1,Elem,[Elem|List1]).
insert_elem(Index,[X|XS],Elem,[X|YS]):- Index1 is Index - 1, insert_elem(Index1,XS,Elem,YS).

% j) delete_elem(+Index, +List1, ?Elem, ?List2), que remove o elemento no
% índice Index de List1 (que é unificado com Elem), resultando em List2.
delete_elem(0,[X|XS],X,XS).
delete_elem(Index,[X|XS],Elem,[X|YS]):- Index1 is Index - 1,delete_elem(Index1,XS,Elem,YS).

% j1) Só um predicado para realizar estas funcoes, distinguimos as funcoes por mais um parametro
insert_or_delete_elem(0,[X|XS],X,XS,delete).
insert_or_delete_elem(0,XS,Elem,[Elem|XS],insert).
insert_or_delete_elem(N,[X|XS],Elem,[X|YS],Mode):- N1 is N - 1,insert_or_delete_elem(N1,XS,Elem,YS,Mode).

% k) replace(+List1, +Index, ?Old, +New, ?List2), que substitui o elemento Old,
% localizado no índice Index de List1, por New, resultando em List2.
replace([Old|XS],0,Old,New,[New|XS]).
replace([X|XS],N,Old,New,[X|YS]):- N1 is N - 1, replace(XS,N1,Old,New,YS).

