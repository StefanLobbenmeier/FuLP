% adventure.pl
% (c) 2018 Hans-Georg Eßer

% Autostart
:- initialization(go).

% Prädikate, die veränderlich sind
:- dynamic(position/2).
:- dynamic(objekt/2).
:- dynamic(position_anzeigen/0).
:- dynamic(weiter_spielen/0).
:- dynamic(fahrplan_haengt/0).

:- op(1000,fx,nimm).    % erlaube Syntax: nimm objekt.
:- op(1000,fx,lege).    % erlaube Syntax: lege objekt.
:- op(1000,fx,benutze). % erlaube Syntax: benutze objekte.

% Liste aller im Spiel bekannten Orte
ort(haus_eg).        ort(haus_og).
ort(vorm_haus).      ort(haltestelle).
ort(im_bus).

% Liste aller prinzipiell möglichen Richtungen
richtung(hoch).      richtung(runter).
richtung(raus).      richtung(rein).
richtung(norden).    richtung(sueden). 

% Verben
verb(nimm(_)).       verb(lege(_)).
verb(inventar).      verb(benutze(_)).
verb(info).          verb(ende).
verb(hilfe).

% Ortsbeschreibungen
beschreibung(haus_eg, 'Du stehst im Erdgeschoss eines kleinen Häuschens.').
beschreibung(haus_og, 'Du stehst im OG eines kleinen Häuschens. Es ist dunkel.').
beschreibung(vorm_haus, 'Du stehst auf der Straße, vor dem Eingang eines kleines Häuschens.').
beschreibung(haltestelle, 'Der Bus faehrt ein.') :- fahrplan_haengt.
beschreibung(haltestelle, 'Du stehst auf der Straße, an einer Haltestelle. Der Fahrplan ist abgefallen. In der Nähe gibt es ein kleines Häuschen.').

% Verbindungsgraph
verbunden(haus_eg,haus_og,hoch).
verbunden(haus_eg,vorm_haus,raus).

verbunden(haus_og,haus_eg,runter).

verbunden(vorm_haus,haus_eg,rein).

verbunden(vorm_haus,haltestelle,norden).
verbunden(haltestelle,vorm_haus,sueden).

verbunden(haltestelle,im_bus,rein) :- fahrplan_haengt.

% Objekte, initiale Positionen
objekt(hammer,haus_eg).
objekt(nagel,haus_og).

% Objekte benutzbar?
% entweder: Spieler am Ort, und Objekt liegt rum, ...
benutzbar(Obj) :- position(spieler,Ort), objekt(Obj,Ort).
% oder: Objekt im Inventar des Spielers
benutzbar(Obj) :- objekt(Obj,spieler).

% Initialisierung
position(spieler,haltestelle).
position_anzeigen.
weiter_spielen.   % Wird entfernt, wenn Spiel beendet ist.

% Information zum aktuellen Ort
info_objekte(Ort) :-
  findall(Obj,objekt(Obj,Ort),Objekte),
  Objekte \= [],
  write('Du siehst hier: '), write(Objekte), nl, !.
info_objekte(_Ort) :-
  write('Hier gibt es nichts zu sehen.'), nl.

info_falls_noetig :-
  position_anzeigen -> info ; true.

info :-
  position(spieler,Ort),
  beschreibung(Ort,Beschr),
  write(Beschr), nl,
  info_objekte(Ort),
  write('Richtungen: '),
  findall(Richtung,verbunden(Ort,_,Richtung),Richtungen),
  write(Richtungen),
  ( position_anzeigen -> retract(position_anzeigen); true ).

kann_nicht :- write('Da kann ich nicht hin gehen.'), nl.

verstehe_nicht :- write('Ich verstehe den Befehl nicht.'), nl.

eingabe_fehler :- print('Fehlerhafte Eingabe!'), nl.

% Richtungsbefehle verarbeiten
bewege(Person,Richtung) :-
  position(Person,AltPos),
  verbunden(AltPos,NeuPos,Richtung),
  retract(position(Person,AltPos)),
  asserta(position(Person,NeuPos)),
(NeuPos = im_bus -> write('Herzlichen Glückwunsch: Du hast das Spiel gelöst.'), nl,retract(weiter_spielen); true),
  asserta(position_anzeigen).

hoch :- bewege(spieler,hoch), !.
hoch :- kann_nicht.

runter :- bewege(spieler,runter), !.
runter :- kann_nicht.

raus :- bewege(spieler,raus), !.
raus :- kann_nicht.

rein :- bewege(spieler,rein), !.
rein :- kann_nicht.

norden :- bewege(spieler,norden), !.
norden :- kann_nicht.

sueden :- bewege(spieler,sueden), !.
sueden :- kann_nicht.

% Nehmen und Ablegen
nimm(Obj) :-
  position(spieler,Pos),
  objekt(Obj,Pos),
  retract(objekt(Obj,Pos)),
  asserta(objekt(Obj,spieler)),
  write('Du hast '), write(Obj), write(' genommen.'), nl, !.
nimm(_Obj) :-
  write('Das kann ich nicht nehmen.'), nl.

lege(Obj) :-
  position(spieler,Pos),
  objekt(Obj,spieler),
  retract(objekt(Obj,spieler)),
  asserta(objekt(Obj,Pos)),
  write('Du hast '), write(Obj), write(' abgelegt.'), nl, !.
lege(_Obj) :-
  write('Das besitzt Du nicht.'), nl.

% Inventar
inventar :-
  write('Du trägst: '),
  findall(Objekt,objekt(Objekt,spieler),Objekte),
  write(Objekte), nl.

% Aktionen
benutze(hammer+nagel) :-
  position(spieler,haltestelle),
  benutzbar(hammer),
  benutzbar(nagel),
  asserta(fahrplan_haengt)
  beschreibung(haltestelle,Beschr),
  write(Beschr), nl,.
benutze(nagel+hammer) :- benutze(hammer+nagel).

benutze(X+Y) :- write('Ich kann '), write(X),
  write(' und '), write(Y), write(' nicht benutzen.'), nl.
benutze(X) :- write('Ich kann '), write(X),
  write(' nicht benutzen.'), nl.

hilfe :-
  findall(X,verb(X),Verben),
  write('Befehle: '),
  write(Verben), nl.

ende :- write('Bis zum nächsten Mal!'), nl,
  retract(weiter_spielen).

% Eingabe verarbeiten 
eingabe_zulaessig(Eingabe) :- richtung(Eingabe).
eingabe_zulaessig(Eingabe) :- verb(Eingabe).

verarbeite(Eingabe) :-
  eingabe_zulaessig(Eingabe),
  call(Eingabe), !.
verarbeite(_Eingabe) :-
  verstehe_nicht.

% Hauptprogramm
go :-
  print('Willkommen bei adventure.pl'), nl, hilfe,
  repeat,
  info_falls_noetig,
  write(' >> '),
  catch(read(Eingabe),_Fehler,true),
  ( 
    ( var(Eingabe), _Fehler = error(_,_) )   % if...
    -> eingabe_fehler                        % then...
    ;  verarbeite(Eingabe)                   % else...
  ),
  ( weiter_spielen -> false; ! ).
