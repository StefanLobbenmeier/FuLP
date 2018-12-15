% 8.a)
meinbetrag(X,X):- X > 0,!.
meinbetrag(X,Y):- Y is -X.

falscheretrag(X,-X):- X =< 0.
% falscheretrag(-1, X).
% X = - -1.

maximum(X,Y,Y) :- Y>X, !.
% maximum(X,_Y,X). doesnt work correctly for maximum(3,5,3).
maximum(X,Y,X) :- X>Y, !.

% 9. Split einer Liste in Positive und Negative Elemente
split([],[],[]) :- !.
% split([Pos],[Pos],[]) :- Pos >= 0.
% split([Neg],[],[Neg]) :- Neg < 0.
split([HP|List],[HP|PosList],NegList) :- HP >= 0, split(List,PosList,NegList),!.
split([HN|List],PosList,[HN|NegList]) :- HN < 0, split(List,PosList,NegList).

% 10. Automat
accept(Xs) :- 
    initial(Q),
    accept(Xs,Q,[]).
accept([X|Xs],Q,S) :-
    delta(Q,X,S,Q1,S1),
    accept(Xs,Q1,S1).
accept([],Q,[]) :- final(Q).


% Automat erkennt a^n b^n
% initial(q0).
% final(q1).
% delta(q0,a,S,q0,[a|S]).
% delta(q0,b,[a|S],q1,S).
% delta(q1,b,[a|S],q1,S).

% Automat erkennt Palindrome
initial(q0).
final(q1).
delta(q0,X,S,q0,[X|S]).
delta(q0,X,S,q1,[X|S]).
delta(q1,X,[X|S],q1,S).