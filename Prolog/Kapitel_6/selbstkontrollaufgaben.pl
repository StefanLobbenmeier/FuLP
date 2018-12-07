% 16. o bildet eine bekannte Variable auf eine frische ab. o^-1 bildet diese frische (und damit jetzt bekannte) Variable auf eine bereits bekannte Variable ab.
% Daher ist o^-1 keine Subsitution

% 17.   a) mgu(t1, t2) = {g(X,Y)/A, h(B,100)/h(Z,W)}
%       b) mgu(t1, t2) = N/A
%       c) mgu(t1, t2) = {g(X)/X, h(Z)/Y}
%       d) mgu(t1, t2) = N/A

% 18.
vokabel(hund,dog).
vokabel(hund,hound).
vokabel(katze,cat).
vokabel(vogel,bird).

vokabeln([], []).
vokabeln([De|Des], [En|Ens]) :- vokabel(De, En), vokabeln(Des, Ens).

% vokabeln(X, [cat, bird]).
%  vokabel(X0, cat), vokabeln(XS1, [bird]).
%   vokabel(katze, cat), vokabeln(XS1, [bird]).
%    vokabel(katze, cat), vokabel(X1, bird), vokabeln(XS2, []).
%     vokabel(katze, cat), vokabel(vogel, bird), vokabeln(XS2, []).
%      vokabel(katze, cat), vokabel(vogel, bird), vokabeln([], []).

% vokabeln([hund, katze], X).
%  vokabel(hund, X0), vokabeln([katze], XS1), X = [X0|XS1].
%   vokabel(hund, dog), vokabeln([katze], XS1), X = [dog|XS1].
%    vokabel(hund, dog), vokabel(katze, X1), vokabeln([], XS2), X = [dog|[X1|XS2]].
%     vokabel(hund, dog), vokabel(katze, cat), vokabeln([], XS2), X = [dog|[katze|XS2]].
%      vokabel(hund, dog), vokabel(katze, X1), vokabeln([], []), X = [dog|[katze|[]]].
%   vokabel(hund, hound), vokabeln([katze], XS1), X = [hound|XS1].
%    vokabel(hund, hound), vokabel(katze, X1), vokabeln([], XS2), X = [hound|[X1|XS2]].
%     vokabel(hund, hound), vokabel(katze, cat), vokabeln([], XS2), X = [hound|[katze|XS2]].
%      vokabel(hund, hound), vokabel(katze, X1), vokabeln([], []), X = [hound|[katze|[]]].