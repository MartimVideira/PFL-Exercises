:- use_module(library(clpfd)).
% a)rle(+List1, ?List2), que faça a compressão run-length de List1 colocando o
% resultado em List2 usando pares de valores.

rle([],[_Y-0]):-!.
rle([X|XS],[Y-0,X-N|Rest]):- X \= Y,rle([X|XS],[X-N|Rest]).
rle([X|XS],[X-N|Rest]):- N1 #= N - 1,rle(XS,[X-N1|Rest]).
%
% b) un_rle(+List1, ?List2), que faça a descompressão de List1.
un_rle([_X-0],[]):-!.
un_rle([X-0,Y-N|Rest],[Y|XS]):- X\= Y,un_rle([Y-N|Rest],[Y|XS]).
un_rle([X-N|Rest],[X|XS]):- N1 #= N -1,un_rle([X-N1|Rest],XS).

