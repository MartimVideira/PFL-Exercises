data(one).
data(two).
data(three).
cut_test_a(X):- data(X).
cut_test_a(five).
cut_test_b(X):- data(X), !.
cut_test_b(five).
cut_test_c(X, Y):- data(X), !, data(Y).
cut_test_c(five,five).

% a) | ?- cut_test_a(X), write(X), nl, fail.
% One two three five  will be printed,fail doesn't stop backtracking, it stops
% any more "depth search",though the expression will be false

% b) | ?- cut_test_b(X), write(X), nl, fail.
%                    |
%                   X= one
%                     |
%                     ! (No more backtracking in choosing X)
%                one will be printed and the result is false.
%
% c) | ?- cut_test_c(X, Y), write(X-Y), nl, fail.
%                       |
%                      X = one
%                       |
%                       !  (No more backtracking in choosing X)
%                /      |      \ 
%            Y=one     Y=two   Y=three
%             |         |         |
%  Printed: one-one   one-two   one-three   
%               (All False will be returned because of the fail)
