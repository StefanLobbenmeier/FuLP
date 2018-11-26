osternabasis(datum(19, 4, 2019)).

feiertag(datum(1,1,_X)).
feiertag(datum(1,5,_X)).
feiertag(datum(3,10,_X)).
feiertag(datum(25,12,_X)).
feiertag(datum(26,12,_X)).
feiertag(datum(31,12,_X)).

feiertag(Datum) :- 
    osternabasis(Datum).
feiertag(datum(Tag,Monat,Jahr)) :- 
    osternabasis(datum(TT,Monat,Jahr)),
    Tag is TT + 3.