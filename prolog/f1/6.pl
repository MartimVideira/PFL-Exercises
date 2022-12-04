pairs(X, Y):- d(X), q(Y).
pairs(X, X):- u(X).
u(1).
d(2).
d(4).
q(4).
q(16).

% The Out Put will Be
% X = 2,  Y = 4
% X = 2,  Y = 16
% X = 4,  Y = 4
% X = 4,  Y = 16
% X = 1 , Y = 1
