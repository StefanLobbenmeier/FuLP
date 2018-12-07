diff(X,X,1).
diff(N,_X,0) :- number(N).
diff(Y,X,0) :- atom(Y), X \= Y.

diff(sin(X),X,cos(X)).
diff(sin(Y),X,0) :- atom(Y), X \= Y.
diff(cos(X),X,-sin(X)).
diff(cos(Y),X,0) :- atom(Y), X \= Y.

diff(e^X,X,e^X).
diff(e^Y,X,0) :- atom(Y), X \= Y.

diff(X^2,X,2*X).
diff(Y^2,X,0) :- atom(Y), X \= Y.

diff(X^N,X,N*X^Nminus1) :- N > 2, Nminus1 is N-1.
diff(Y^_N,X,0) :- atom(Y), X \= Y.

diff(C*F,X,C*DF) :- number(C), diff(F,X,DF).
diff(F+G,X,DF+DG) :- diff(F,X,DF), diff(G,X,DG).
diff(F-G,X,DF-DG) :- diff(F,X,DF), diff(G,X,DG).
diff(F*G,X,F*DG+DF*G) :- not(number(F)), diff(F,X,DF), diff(G,X,DG).

% Quotientenregel:
diff(F/G,X,(G*DF-F*DG)/G^2) :- diff(F,X,DF), diff(G,X,DG).




% diff(F+G,X,DF+DG)=diff(x^2+2*x+sin(x),x,A).
% F = x^2+2*x,
% G = sin(x),
% X = x,
% A = DF+DG.

% diff(2*x^2*y^3 + x*y,x,A) = diff(2*x^2*y^3 + x*y,y,A)

