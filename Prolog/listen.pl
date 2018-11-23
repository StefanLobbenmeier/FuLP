mylen([], 0).
mylen([_X|Xs], Len) :- mylen(Xs, N), Len is N + 1.

% mylen([], 0).
% true.

% mylen([1,2], 2).
% true.

% X is 2 + 3.
% X = 5.

% mylen(X,N).
% X = [],
% N = 0 ;
% X = [_22828],
% N = 1 ;
% X = [_22828, _22834],
% N = 2 ;

reverse(Xs, Ys) :-
    reverse_mit_akku(Xs, [], Ys).

reverse_mit_akku([], R, R).
reverse_mit_akku([X|Xs], T, R) :- 
    reverse_mit_akku(Xs, [X|T], R).