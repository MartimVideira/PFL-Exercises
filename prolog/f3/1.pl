s(1).
s(2):- !.
s(3).

% a) ?- s(X).
%      /   \
%      1    2
%           ! (Stop the Backtracking)
%   X= 1, X = 2


% b)   ?- s(X),s(Y).
%        /        \
%       X=1         X=2
%                    ! (Stop the Backtracking in chosing X
%      /   \        /  \
%    Y=1   Y=2    Y=1   Y=2
%           !            ! 
%       (Stop Backtracking in choosing Y)
%   X=1 Y=1, X=1 Y=2 , X=2 Y=1, X=2 Y=2


% c)  ?- s(X),!,s(Y).
%            |
%           X=1
%            !  (Stop The Backtracking in chosing X)
%           / \
%        Y=1   Y=2
%               ! (Stop the Backtracking in chosing Y) 
%    X=1 Y=1, X=1 Y=2.
