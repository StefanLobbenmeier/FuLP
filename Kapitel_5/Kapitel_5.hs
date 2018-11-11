import Data.Char

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