data Polynom 
  = Const Float
  | PowerOfX Float Int
  | Sum Polynom Polynom
  
p1 = Const 42.1
p2 = PowerOfX 3.1 2
p3 = PowerOfX 4.2 3
p4 = Sum p1 p2
p5 = Sum p4 p3

instance Show Polynom where
  show (Const x) = show x
  show (PowerOfX a n) = 
    if n == 1 then
      show a ++ "x"
    else 
      show a ++ " x^" ++ show n
  show (Sum p1 p2) = "(" ++ show p1 ++ " + " ++ show p2 ++ ")"

diff :: Polynom -> Polynom
diff (Const x) = Const 0
diff (PowerOfX a n) = 
  if n == 1 then 
    Const (a * (fromIntegral n)) 
  else 
    PowerOfX (a * (fromIntegral n)) (n-1)
diff (Sum p1 p2) = Sum (diff p1) (diff p2)

poly2list :: Polynom -> [Polynom]
poly2list (Const x) = [Const x]
poly2list (PowerOfX a n) = [PowerOfX a n]
poly2list (Sum p1 p2) = poly2list p1 ++ poly2list p2

list2poly :: [Polynom] -> Polynom
list2poly [] = Const 0.0
list2poly [p] = p
list2poly (p:r) = Sum p (list2poly r)

-- list2polyfr :: [Polynom] -> Polynom
-- list2polyfr polys = foldr (\p pr -> sum pr p) []
