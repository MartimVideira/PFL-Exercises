:- use_module(library(clpfd)).
% a)
rle([],[Y-0]).
rle([X|XS],[X-N|Rest]):- N1 #= N - 1,rle(XS,[X-N1|Rest]).
rle([X|XS],[Y-0,X-N|Rest]):- X \= Y,rle([X|XS],[X-N|Rest]).
