% red cut: beendet weitere Suche, verändert Programmfluss
not(Ziel) :- call(Ziel),!,fail.
not(_Ziel).

% Green cut: beendet weitere Suche, erhöht Performance
max(X,Y,Y) :- X =< Y,!.
max(X,Y,X) :- X > Y.