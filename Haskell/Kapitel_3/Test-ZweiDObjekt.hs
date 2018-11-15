import Kapitel_3.ZweiDObjekt

p1 = Punkt 1.0 1.0
p2 = Punkt 2.0 2.0
p3 = Punkt 1.0 2.0

r = Rechteck p1 p2
d = Dreieck p1 p2 p3

main = do
    putStrLn ("Recheck: " ++ show r)
    putStrLn ("Flaeche: " ++ show (flaeche r))
    putStrLn ("Dreieck: " ++ show d)
    putStrLn ("Flaeche: " ++ show (flaeche d))