import Data.List 
import Data.Char
import Text.Printf

addfun z = \ x -> x + z

inc = addfun 1
dec = addfun (-1)

tupeladd (x,y) = x+y


sumavg :: Fractional a => [a] -> (a,a)
sumavg liste =
  let s = sum liste
      avg = s / (fromIntegral (length liste))
  in (s,avg)

instance Num w => Num (d->w) where 
    f + g = \ x -> f x + g x 
    f - g = \ x -> f x - g x 
    f * g = \ x -> f x * g x 
    abs f = \ x -> abs (f x)
    signum f = \ x -> signum (f x)
    fromInteger z = \ x -> fromInteger z

-- instance Ord w => Ord (d->w) where 
--     compare f g = \ x -> compare (f x) (g x)

instance Fractional w => Fractional (d->w) where 
    f / g = \ x -> f x / g x 
    fromRational z = \ x -> fromRational z

f x = 3 * x
g x = 2 * x
h = f + g
z = f ^ 2 + g ^ 2

nonsense :: (Foldable t, Num a, Ord a, Fractional a) => t a -> a
nonsense = 1.2 * maximum - 0.7 * minimum + sum^2

explicitplus :: Num w => (d -> w) -> (d -> w) -> (d -> w)
explicitplus f g = \x -> f x + g x

add_AAA_to_front = (++) "AAA"
add_BBB_to_end = flip (++) "BBB"

-- (**) = flip (++)

teilbar_durch_3 x = (x `mod` 3) == 0
filter_t_d_3 = filter teilbar_durch_3

namen = ["Thomas","Jan","Anna","Kristina"]

myfilter :: (d-> Bool) -> [d] -> [d]
myfilter filter_func list = [x | x <- list, filter_func x]



sortnormal = sortBy compare
sortrev = sortBy (flip compare)
namen_sortiert = sortnormal namen
namen_sortiert_za = sortrev namen

sortByAbs = sortBy (\x y -> compare (abs x) (abs y))

sortByLengthOfList :: [[a]] -> [[a]]
sortByLengthOfList = sortBy (\x y -> compare (length x) (length y))

buchstabenUndZahlenSalat = zip [1..26] ['a'..'z']

-- This one will only go from (a to e) because the numbers are shorter:
buchstabenUndZahlenSalatKurzUndLang = zip [1..5] ['a'..'z'] 

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f [] _ = []
myZipWith f _ [] = []
myZipWith f (a:arest) (b:brest) = (f a b):(myZipWith f arest brest)

buchstabenUndZahlenSalatPrintf = myZipWith (\x y -> printf "%4d: %s" x y :: String) ([1..]::[Integer]) ["ab", "cd", "ef"]

data LispList a
    = Nil
    | Cons a (LispList a) 
    deriving Show

-- (@@) :: a -> LispList a -> LispList a
-- (@@) a b = Cons a b

listMap :: (a -> b) -> LispList a -> LispList b
listMap f Nil = Nil
listMap f (Cons x rest) = Cons (f x) (listMap f rest)

lispListExample = Cons 1 (Cons 2 (Cons 3 Nil))
listMapExample = (*5) listMapExample

instance Functor LispList where
    fmap = listMap

data Tree basistyp
    = Leaf basistyp
    | InnerNode basistyp (Tree basistyp) (Tree basistyp)
    deriving Show


treeMap :: (a -> b) -> Tree a -> Tree b
treeMap f (Leaf x) = Leaf (f x)
treeMap f (InnerNode x y z) = InnerNode (f x) (treeMap f y) (treeMap f z)

instance Functor Tree where
    fmap = treeMap
    
treeExample = InnerNode 5 (Leaf 4) (Leaf 6)


-- Kontrollaufgaben
transform = map (\x -> head x) . sortBy (\x y -> compare (map toUpper x) (map toUpper y)) . map (\x -> [x])
-- this wraps each character of the string in an array, sorts the array of arrays and finally converts each inner array back to a char

-- without wrapping it can be easier:
bettertransform = sortBy (\x y -> compare (toUpper x) (toUpper y)) 


-- 11

curry3 :: ((a, b, c) -> d) -> a -> b -> c -> d
curry3 f a b c = f (a,b,c)

uncurry3 :: (a -> b -> c -> d) -> (a, b, c) -> d
uncurry3 f (a,b,c) = f a b c

f1 :: (Int,Int,Int) -> Int
f1 (x,y,z) = x + y + z

f2 :: Int -> Int -> Int -> Int
f2 x y z = x + y + z

testCurry3 = curry3 f1 1 2 3
testUncurry3 = uncurry3 f2 (1,2,3)

-- 12

data CommentList a 
    = NilCL
    | ConsCL (a, String) (CommentList a)
    -- deriving Show

a = NilCL
b = ConsCL (20,"Kommentar") a
c = ConsCL (10,"") b
d = ConsCL (5,"Fuenf") c

instance Show a => Show (CommentList a) where
    show x = "[" ++ showinside x ++ "]" where
        showtextifnecessary text = (if text == "" then "" else "<" ++ text ++ ">")
        showinside NilCL = ""
        showinside (ConsCL (number, text) NilCL) = show number ++ showtextifnecessary text  
        showinside (ConsCL (number, text) rest) = show number ++ showtextifnecessary text ++ "," ++ showinside rest 