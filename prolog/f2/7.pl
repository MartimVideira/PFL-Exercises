% list_length(?List,?Length) calcula em tamanho da lista
list_length([],0).
list_length([_|XS],N):- list_length(XS,N1), N is N1 +1.

% list_append(?L1, ?L2, ?L3) em que L3 é constituída pela concatenação das listas L1 e L2.
list_append([],L2,L2).
list_append(L1,[],L1).
list_append([X|XS],L2,[X|YS]):- list_append(XS,L2,YS).

% list_member(?Elem, ?List) que verifica se Elem é membro de Lista usando unicamente o predicado append uma só vez.
% Se elem pertence há lista existem duas listas que concatenadas com elem dá a lista original
list_member(Elem,List):- list_append(_Esquerda,[Elem|_Direita],List).

% c) list_last(+List, ?Last) que unifica Last com o último elemento de List, usando unicamente o predicado append uma só vez
list_last(List,Last):- list_append(_Inicio,[Last],List).

% d) list_nth(?N, ?List, ?Elem), que unifica Elem com o N-ésimo elemento de Lista, usando apenas os predicados append e length.
list_nth(N,List,Elem):- list_append(Inicio,[Elem|_Fim],List),list_length(Inicio,N).

% e) list_append(+ListOfLists, ?List) que concatena uma lista de listas.
list_append([],[]).
list_append([XS|XSS],Result):- list_append(XS,NextResult,Result),list_append(XSS,NextResult).

% f) list_del(+List, +Elem, ?Res), que elimina uma ocorrência de Elem de List,
% unificando o resultado com Res, usando apenas o predicado append duas vezes.
list_del(List,Elem,Res):- list_append(Inicio,[Elem|Fim],List),list_append(Inicio,Fim,Res).

% h) list_before(?First, ?Second, ?List) que sucede se os dois primeiros
% argumentos forem membros de List, e First ocorrer antes de Second, usando
% unicamente o predicado append duas vezes.
list_before(First,Second,List):- list_append(_Inicio,[First|Resto],List),list_append(_Meio,[Second|_Fim],Resto).

% h) list_replace_one(+X, +Y, +List1, ?List2) que substitui uma ocorrência de X
% em List1 por Y, daí resultando List2, usando unicamente o predicado append
% duas vezes.
list_replace_one(X,Y,List1,List2):- list_append(Inicio,[X|Fim],List1),list_append(Inicio,[Y|Fim],List2).

% i) list_repeated(+X, +List) que sucede se X ocorrer repetidamente (pelo menos
% duas vezes) em List, usando unicamente o predicado
% append duas vezes
list_repeated(X,List):- list_before(X,X,List).

% j) list_slice(+List1, +Index, +Size, ?List2), que extrai uma fatia de tamanho
% Size de List1 começando no índice Index, resultando em List2, usando apenas
% os predicados append e length.
list_slice(List1,Index,Size,List2):-
    list_length(List2,Size),
    list_length(PreSlice,Index),
    list_append(PreSlice,SliceAndRest,List1),
    list_append(List2,_Rest,SliceAndRest).

% k) list_shift_rotate(+List1, +N, ?List2), que rode List1 N elementos para a
% esquerda, resultando em List2, usando apenas os predicados append e length.
list_shift_rotate(List1,N,List2):- 
    list_length(List1,L1Len),TrueN is N mod L1Len,
    list_length(ToRotate,TrueN),
    list_append(ToRotate,Rest,List1),
    list_append(Rest,ToRotate,List2).
    

