vater_kind(alois, martin).
vater_kind(martin, thomas).
mutter_kind(christina, anna).
mutter_kind(anna, thomas).

eltern_kind(A, B) :- vater_kind(A, B).
eltern_kind(A, B) :- mutter_kind(A, B).

vorfahr_person(A, B) :- eltern_kind(A, B).
vorfahr_person(A, C) :- eltern_kind(A, B), vorfahr_person(B, C).

nachfahr_person(A, B) :- vorfahr_person(B, A).

% vater_kind(alois, martin). true
% vater_kind(alois, kristof). false
% vorfahr_person(alois, alois). false
% vorfahr_person(alois, thomas). true