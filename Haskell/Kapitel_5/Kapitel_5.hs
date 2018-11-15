import Data.List

--5.2
getHead = unlines . (take 3) . lines 
getHeadOfFile filename = fmap getHead (readFile filename)

getRevLine = fmap reverse getLine

--5.3
meinDiv :: Double -> Double -> Maybe Double
meinDiv x 0 = Nothing
meinDiv x y = Just (x / y)

meinHead :: [Double] -> Maybe Double
meinHead [] = Nothing
meinHead (x:_) = Just (x)

meinAdd :: Double -> Double -> Double
meinAdd = (+)

meinAddMaybe :: Maybe Double -> Maybe Double -> Maybe Double
-- meinAddMaybe (Just x) (Just y) = Just (x + y)
-- meinAddMaybe _ _ = Nothing
-- meinAddMaybe x y = pure meinAdd <*> x <*> y
meinAddMaybe x y = meinAdd <$> x <*> y

data Wrapped a = W a
    deriving Show
instance Functor Wrapped where 
    fmap f (W a) = W (f a)
instance Applicative Wrapped where 
    pure a = W a
    (W f) <*> (W a) = W (f a)


x = W 10
y = W 20
f = W (+5)
g = W (+)

-- f <*> x =  W 15
-- g <*> x <*> y = W 30

-- f <*> pure 3 = pure ($ 3) <*> f

-- pure (.) <*> f <*> f <*> x
-- f <*> (f <*> x)

testList0 = [2 * x | x <- [1..5]]
testListTooBig = testList0 ++ [200]
testListUnsorted = [10] ++ testList0
testListUneven = [1] ++ testList0

maybePP :: Maybe [Integer] -> Maybe [Integer] -> Maybe [Integer]
maybePP Nothing _ = Nothing
maybePP _ Nothing = Nothing
maybePP (Just list1) (Just list2) = Just (list1 ++ list2)

cSmallEnough :: [Integer] -> Maybe [Integer]
cSorted :: [Integer] -> Maybe [Integer]
cEven :: [Integer] -> Maybe [Integer]


cSmallEnough (x:xs) = if (x < 100) then maybePP (Just [x]) (cSmallEnough xs) else Nothing
cSmallEnough [] = Just []
cSorted (x:y:xs) = if (x < y) then maybePP (Just [x]) (cSorted (y:xs)) else Nothing
cSorted (y:[]) = Just (y:[])
cSorted [] = Just []
cEven (x:xs) = if ((mod x 2) == 0) then maybePP (Just [x]) (cEven xs) else Nothing
cEven [] = Just []

listen = [testList0, testListTooBig, testListUneven, testListUnsorted]
criteria = [cSmallEnough, cSorted, cEven]

(>=>) :: Eq b => (a -> Maybe b) -> (b -> Maybe c) -> (a -> Maybe c)
(f >=> g) x = helper (f x) where 
    helper Nothing = Nothing
    helper (Just y) = g y
    
    
maybeSum :: [Integer] -> Maybe Integer
maybeSum list = Just (sum list)

maybeSumButOnlyIfAllCrit = cSmallEnough >=> cSorted >=> cEven >=> maybeSum
maybeSumButOnlyIfAllCritResult = map maybeSumButOnlyIfAllCrit listen

--crossListenCriteria = criteria <*> listen

doppelt x = [x, x]
doppelteList = [1..3] >>= doppelt
doppelteList2 = doppelt =<< [1..3] 

nd_sqrt :: Float -> [Float]
nd_sqrt x
    | x<0       = []
    | otherwise = [sqrt x, -sqrt x]

nd_plus1 x = [x + 1]

-- nd_sqrt =<< return 4
-- return 4 >>= nd_sqrt >>= nd_plus1 
-- return 4 >>= nd_sqrt >>= nd_plus1 >>= nd_sqrt

-- Uebungsaufgaben
-- 14)
-- a) >>= wendet auf eine Monade (e.g.) [4] eine Funktion a -> m b an (z.b. \x -> [x, x])
example14a = [1..3] >>= (\x -> [x,x])

-- b) (++) verbindet 2 Listen, hat allerdings keine allgemeine Bedeutung für andere Typen

-- c) <*> wendet eine in einem Applicative gekapselte Funktion auf ein in einem Applicative gekapselten Wert an:
example14c = [(\x -> x / 2), (\x -> x * 2)] <*> [1..4] -- = [0.5,1.0,1.5,2.0,2.0,4.0,6.0,8.0]

-- d) (.) macht Funktionskomposition: f . g x = f(g(x))

-- e) >=> verbindet 2 Funktionen der Form a -> m b und b -> m c, sodass diese auf eine Monade angewendet werden können, ist aber in Haskell nicht definiert
example14eNothing = Just 1 >>= ((\x -> Just (x - 2)) >=> (\x -> if x < 0 then Nothing else Just (sqrt x)))
example14eJust1 = Just 3 >>= ((\x -> Just (x - 2)) >=> (\x -> if x < 0 then Nothing else Just (sqrt x)))

-- f) <$> gehört zur Funktorklasse, und ist eine infix variante von fmap
example14f = (\x -> 2 * x) <$> [1..5]


-- 15)
join :: (Monad m) => m (m a) -> m a
join x = x >>= id

example15a = join [[1]]
example15b = join [[[1]]]
example15c = join [[1,2], [3,4]]
-- join [[1]] = [[1]] >>= id = concatMap id [[1]] = foldr ((++) . id) [] [[1]] = foldr (((++) . id)) ([] ++ id ([1])) [] = [1]

example15d = join (Just (Just 3))
example15e = join (Just (Just (Just 3)))
-- join (Just (Just 3)) = (Just (Just 3)) >>= id = (id >=> id) (Just (Just 3)) = helper (id (Just (Just 3))) = id (id (Just  3)) = Just 3

-- >>= erwarted eine Funktion, die etwas "normales" in eine andere Monade kapselt. Die Implementation entnimmt daher den Inhalt der Monade
-- Da die Funktion id nicht wieder kapselt, kann man so den Inhalt der Monade entnehmen

-- Zusatzfrage: es gibt keienen Weg eine Funktion [a] -> a zu definieren, die auch [[a]] -> a erfüllt. In Haskell muss die Typdefinition eindeutig sein.

