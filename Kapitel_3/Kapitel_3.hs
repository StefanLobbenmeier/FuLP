betrag :: (Num a, Ord a) => a -> a
betrag x
  | x >= 0 = x
  | x < 0 = -x

safeHead :: [a] -> Maybe a
safeHead (x:_) = Just x
safeHead [] = Nothing

wrap :: (a -> b) -> (Maybe a -> Maybe b)
wrap f Nothing = Nothing
wrap f (Just x) = Just (f x)

data Grob = Grob Float deriving Show
instance Eq Grob where 
    (==) (Grob a) (Grob b) = (abs (a-b) < 0.01)

a = Grob 42.000
b = Grob 42.006
c = Grob 42.012

liste_abc = [a, b, c]

import Data.Char

instance Num Char where 
    x+y = chr(ord(x)+ord(y))
    x-y = chr(ord(x)-ord(y))
    x*y = 0
    abs x = x
    signum x = 0
    negate x = if isUpper x
        then toLower x
        else toUpper x
    fromInteger x = chr((fromInteger x)`mod`256)

