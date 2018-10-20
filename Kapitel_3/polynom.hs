import Data.List  -- enthaelt sortBy

data Polynom
  = Const Float
  | PowerOfX Float Int
  | Sum Polynom Polynom

instance Show Polynom where
  show (Const x) = show x
  show (PowerOfX a n) = 
    if n > 1 then
      show a ++ " x^" ++ show n
    else
      show a ++ "x"
  show (Sum a b) = "(" ++ show a ++ " + " ++ show b ++ ")"

diff :: Polynom -> Polynom
diff (Const x) = Const 0
diff (PowerOfX a n) = 
  if n > 1 then
    PowerOfX (a*(fromIntegral n)) (n-1)
  else
    Const a
diff (Sum a b) = Sum (diff a) (diff b)

p1 = Const 42.1
p2 = PowerOfX 3.1 2
p3 = PowerOfX 4.2 3
p4 = Sum p1 p2
p5 = Sum p4 p3
p6 = Sum p5 p5

poly2list :: Polynom -> [Polynom]
poly2list (Const a) = [Const a]
poly2list (PowerOfX a n) = [(PowerOfX a n)]
poly2list (Sum a b) = poly2list a ++ poly2list b

list2poly :: [Polynom] -> Polynom
list2poly [] = Const 0.0
list2poly [a] = a
list2poly (a:rest) = Sum a (list2poly rest)



-- Aufgabe a)

compPoly :: Polynom -> Polynom -> Ordering
-- implementier mich!
compPoly (Const _) (Const _) = EQ
compPoly (Const _) (PowerOfX _ _) = LT
compPoly (PowerOfX _ _) (Const _) = GT
compPoly (PowerOfX _ n1) (PowerOfX _ n2) = compare n1 n2




-- Aufgabe b)

simplify :: Polynom -> Polynom
simplify p = list2poly unifiedList
  where
    sortedList = sortBy compPoly (poly2list p)
    unifiedList = unify sortedList 

unify :: [Polynom] -> [Polynom]
unify [] = []
unify [einPoly] = [einPoly]
unify (a:b:rest) = 
  if compPoly a b == EQ then
    unify ((add a b) : rest)
  else 
    a:unify (b:rest)


add :: Polynom -> Polynom -> Polynom
add (Const c1) (Const c2) = (Const (c1 + c2))
add (PowerOfX a1 n1) (PowerOfX a2 n2) = (PowerOfX (a1 + a2) n1)



-- Aufgabe c)

instance Eq Polynom where
  a == b  = litequal (simplify a) (simplify b)

litequal :: Polynom -> Polynom -> Bool
litequal (Const c1) (Const c2) = (c1 == c2)
litequal (PowerOfX a1 n1) (PowerOfX a2 n2) = a1 == a2 && n1 == n2
litequal (Sum p11 p12) (Sum p21 p22) = (litequal p11 p21) && (litequal p12 p22)
litequal else1 else2 = False



-- Schon fertig?
-- Zusatzaufgabe: Mit apply spielen -- was macht es? 

-- es berechnet aus f und x den Wert f(x)

apply :: Polynom -> Float -> Float
apply (Const a) x = a
apply (PowerOfX a n) x = a*x^(fromIntegral n)
apply (Sum a b) x = (apply a x) + (apply b x)

