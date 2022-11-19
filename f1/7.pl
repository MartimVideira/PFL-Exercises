a(a1, 1).
a(A2, 2).
a(a3, N).
b(1, b1).
b(2, B2).
b(N, b3).
c(X, Y):- a(X, Z), b(Z, Y).
d(X, Y):- a(X, Z), b(Y, Z).
d(X, Y):- a(Z, X), b(Z, Y).

% b)
% i. a(A, 2).
% true.
% ii. b(A, foobar).
% false
% iii. c(A, b3) :- a(A,Z), b(Z,b3)
%  - A = a1
%  - A = A2 qualquer coisa
%  - A = a3
% iv. c(A, B).
%      - A qualquer coisa B qualquer coisa -> sempre verdade
%      - A = a1 , B = b1
%      - A = a1, B = b3
%      - A = a3 , B = b3
% v. d(A, B)
%    - X = Qualquer coisa, Y = b3
%    - X = 2 , Y = qualquer coisa
