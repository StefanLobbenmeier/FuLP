taketwo :: [a] -> [a]
taketwo (x:y:rest) = [x,y]
taketwo [] = []
-- taketwo [1] is not defined

takelasttwo :: [a] -> [a]
takelasttwo [a,b] = [a,b]
takelasttwo (_:rest) = takelasttwo rest
-- takelasttwo [] and [1] is not defined

rekursion :: [a] -> [a]
rekursion [a,b,c] = rekursion [a,b,c] ++ rekursion [b,c,a]
rekursion _ = []
-- infinite loop for  [1,2,3], but [] for anything else

