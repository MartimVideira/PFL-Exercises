% a) | ?- [a | [b, c, d] ] = [a, b, c, d]
% True
% b) | ?- [a | b, c, d ] = [a, b, c, d]
% False
% c) | ?- [a | [b | [c, d] ] ] = [a, b, c, d]
% True
% d) | ?- [H|T] = [pfl, lbaw, redes, ltw]
%  H = pfl , T = [lbaw,redes,ltw]
% e) | ?- [H|T] = [lbaw, ltw]
%  H = lbaw , T = [ltw]
% f) | ?- [H|T] = [leic]
%  H = leic , T = []
% g) | ?- [H|T] = []
%  False
% h) | ?- [H|T] = [leic, [pfl, ltw, lbaw, redes] ]
%  H = leic T = [[pfl,ltw,lbaw,redes]]
% i) | ?- [H|T] = [leic, Two]
%  H = leic ,T = [Two]
% j) | ?- [Inst, feup] = [gram, LEIC]
%   Inst = gram , LEIC = feup.
% k) | ?- [One, Two | Tail] = [1, 2, 3, 4]
%   One = 1, Two= 2, Tail = [3,4]
% l) | ?- [One, Two | Tail] = [leic | Rest]
%  One = leic, Two = A , Rest = [A|Tail], não precisamos de usar a variável A
%  One = leic , Rest =[Two|Rest]
