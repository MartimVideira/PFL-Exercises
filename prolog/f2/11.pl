% pascal(+N, ?Lines), em que Lines é uma lista com as primeiras N linhas do
% triângulo de Pascal.
%
%       1
%      1 1
%     1 2 1
%    1 3 3 1
%   1 4 6 4 1
% 1 5 10 10 5 1

% A primira linha do Triangulo é [1]
% O resto das linhas são [1,Ln-1[j] + Ln-1[j+1],1], j <- [0..(len(Ln-1) -1)]
% Bastante Ineficiente Memoization would be noice

pascal(N,Lines):- pascal(N,Lines,1),!.
pascal(N,[NLine],N):- pascalN(N,NLine),!.
pascal(N,[N1Lines|Lines],C):- pascalN(C,N1Lines),C1 is C + 1,pascal(N,Lines,C1).


pascalN(1,[1]):-!.
pascalN(2,[1,1]):-!.
pascalN(N,X):- N1 is N -1 ,pascalN(N1,Y),buildNextLine(Y,X).

buildNextLine([1],[1,1]):-!.
buildNextLine([1,1],[1,2,1]):-!.
buildNextLine([N,1],[Pn,1]):- Pn is 1 + N,!.
buildNextLine([1,N|Rest],[1,Pn|PRest]):- Pn is 1 + N,buildNextLine([N|Rest],PRest).
buildNextLine([N,N1|Rest],[Pn|PRest]):- Pn is N + N1 ,buildNextLine([N1|Rest],PRest).
