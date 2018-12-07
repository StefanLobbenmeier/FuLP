% Verneinung
verein(fc_iserlohn).
verein(fc_hagen).
verein(fc_meschede).

paarung(X, Y) :- verein(X), verein(Y), \+ X=Y.

% Implementation mit red cut:
not(Ziel) :- call(Ziel),!,fail.
not(_Ziel).

eq(X,X).

alt_paarung(X, Y) :- verein(X), verein(Y), not(X=Y).

% Green cut:
max(X,Y,Y) :- X =< Y,!.
max(X,Y,X) :- X > Y.

% asserta, assertz
fast_fibu(0, 0).
fast_fibu(1, 1).
fast_fibu(N, FibN) :-
    N > 1,
    A is N-1, B is N-2,
    fast_fibu(A, FibA), fast_fibu(B, FibB),
    FibN is FibA + FibB,
    asserta(fast_fibu(N, FibN)).

% findall
p(a,b). p(a,c). p(b,e). q(c). q(d).
r(A,B) :- q(A), q(B).

% findall((X,Y),r(X,Y),Results).
% Results = [(c, c),  (c, d),  (d, c),  (d, d)].

% Syso: write('Hallo Welt').
% sysin: read(_X). _X 

% catch(undefiniert(X),Error,true).

% sortieung:
% sort([funktionale,und,logische,programmierung],Liste).
% Liste = [funktionale, logische, programmierung, und].

% Vergleich von Atomen: @<
% 44 ?- "asf" @< "asd".
% false.

% 45 ?- "asf" @> "asd".
% true.

% if: (test_ziel -> ja_ziel ; nein_ziel ).


% infix etc.
:- op(100, xf, ist_muede).
:- op(100, xf, hatte_wenig_schlaf).
:- op(100, xf, hatte_keinen_kaffee).

X ist_muede :- X hatte_wenig_schlaf, X hatte_keinen_kaffee.
tim hatte_keinen_kaffee.
klara hatte_keinen_kaffee.
markus hatte_wenig_schlaf.
klara hatte_wenig_schlaf.