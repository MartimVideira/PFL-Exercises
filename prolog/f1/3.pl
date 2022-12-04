% X is a pilot
% pilot(X).
pilot("Lamb").
pilot("Besenyei").
pilot("Chambliss").
pilot("MacLean").
pilot("Mangold").
pilot("Jones").
pilot("Bonhomme").

% X is in the Y team
% team(X,Y)
team("Lamb","Breitling").
team("Besenyei","Red Bull").
team("Chambliss","Red Bull").
team("MacLean","Mediterranean Racing Team").
team("Mangold","Cobra").
team("Jones","Matador").
team("Bonhomme","Matador").

% X's plane is a Y
% plane(X,Y)
plane("Lamb","MX2").
plane("Besenyei","Edge540").
plane("Chambliss","Edge540").
plane("MacLean","Edge540").
plane("Mangold","Edge540").
plane("Jones","Edge540").
plane("Bonhomme","Edge540").

% X is a circuit
% circuit(X)
circuit("Istanbul").
circuit("Budapest").
circuit("Porto").

% Pilot X Won circuit Y
% winner(X,Y)
winner("Jones","Porto").
winner("Mangold","Budapest").
winner("Mangold","Istanbul").

% circuit X has y gates
% gates(X,Y)
gates("Istanbul",9).
gates("Budapest",6).
gates("Porto",5).

% Team Team won race Circuit
teamWinner(Team,Circuit) :- team(Pilot,Team),winner(Pilot,Circuit).

% b)
% i) ?- winner(Piloto,"Porto").
% ii) ?- teamWinner(Team,"Porto).
% iii) ?- gates(Y,X), X > 8.
% iv) ?- plane(X,Y),Y\="Edge540"
% v) ?-  winner(X,Z),winner(X,Z1),Z\=Z1
% vi) ?- plane(Pilot,Plane),winner(Pilot,"Porto").
