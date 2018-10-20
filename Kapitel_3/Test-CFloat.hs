import Kapitel_3.CFloat

eins = C 1 0
zwei = eins * 2
zwei2 = eins * 2.0
zwei3 = eins + eins

i = C 0 1
i2 = 2.0 * i
isqr = i*i

main = do
    putStrLn ("eins = " ++ show eins)
    putStrLn ("zwei = " ++ show zwei)
    putStrLn ("zwei2 = " ++ show zwei2)
    putStrLn ("zwei3 = " ++ show zwei3)
    putStrLn ("i = " ++ show i)
    putStrLn ("i2 = " ++ show i2)
    putStrLn ("isqr = " ++ show isqr)
    putStrLn ("Re i = " ++ show (re i))
    putStrLn ("Im i = " ++ show (im i))