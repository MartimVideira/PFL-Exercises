% ancestor(?X,?Y)
% X é antepassado de Y 
ancestor(X,Y):- parent(X,Y).
ancestor(X,Y):- parent(X,Z),ancestor(Z,Y).

% descendant(?X,?Y)
% X é descendant de Y
descendant(X,Y) :- ancestor(Y,X).
