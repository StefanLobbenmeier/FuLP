data Baum 
  = Blatt Float 
  | Innenknoten Float Baum Baum

instance Show Baum where 
  show (Blatt x) = "[" ++ show x ++ "]"
  show (Innenknoten x links rechts) =
    "[" ++ show x ++ "," ++ show links ++ "," ++ show rechts ++ "]"

a = Blatt 1.2
b = Innenknoten 1.3 a a
c = Innenknoten 1.5 b (Blatt 42.0)

baumsumme :: Baum -> Float
baumsumme (Blatt x) = x
baumsumme (Innenknoten x links rechts) =
  x + baumsumme links + baumsumme rechts

gdi3baum = 
  Innenknoten 1
    (Innenknoten 2
      (Innenknoten 4 (Blatt 8) (Blatt 9)
      )
      (Innenknoten 5 (Blatt 10) (Blatt 11)
      )
    )
    (Innenknoten 3
      (Innenknoten 6 (Blatt 12) (Blatt 13)
      )
      (Innenknoten 7 (Blatt 14) (Blatt 15)
      )
    )

tiefensuche :: Baum -> [Float]
tiefensuche (Blatt x) = [x]
tiefensuche (Innenknoten x links rechts) =
  [x] ++ tiefensuche links ++ tiefensuche rechts

breitensuche :: Baum -> [Float]
breitensuche baum = bfs [baum]


bfs :: [Baum] -> [Float]
bfs [] = []
bfs baumliste =
  map hole_wurzel_wert baumliste ++
  bfs (hole_unterbaeume baumliste)

hole_wurzel_wert :: Baum -> Float
hole_wurzel_wert (Blatt x) = x
hole_wurzel_wert (Innenknoten x _ _) = x

hole_unterbaeume :: [Baum] -> [Baum]
hole_unterbaeume [] = []
hole_unterbaeume ((Blatt x):rest) = []
hole_unterbaeume ((Innenknoten _ rechts links):rest)
  = [rechts, links] ++ hole_unterbaeume rest
  

infixbaum = 
  Innenknoten 8
    (Innenknoten 4
      (Innenknoten 2 (Blatt 1) (Blatt 3)
      )
      (Innenknoten 6 (Blatt 5) (Blatt 7)
      )
    )
    (Innenknoten 12
      (Innenknoten 11 (Blatt 9) (Blatt 10)
      )
      (Innenknoten 14 (Blatt 13) (Blatt 15)
      )
    )

infixsuche :: Baum -> [Float]
infixsuche (Blatt x) = [x]
infixsuche (Innenknoten x links rechts) =
  infixsuche links ++ [x] ++ infixsuche rechts

umdrehen :: Baum -> Baum
umdrehen (Blatt x) = Blatt x
umdrehen (Innenknoten x links rechts) =
  Innenknoten x (umdrehen rechts) (umdrehen links)

postfixsuche :: Baum -> [Float]
postfixsuche (Blatt x) = [x]
postfixsuche (Innenknoten x links rechts) =
  postfixsuche links ++ postfixsuche rechts ++ [x]

-- Parametrisierte Typen 
data Tree basistyp
  = Leaf basistyp
  | InnerNode basistyp (Tree basistyp) (Tree basistyp)

instance Show z => Show (Tree z) where
  show (Leaf x) = "["++ show x ++"]"
  show (InnerNode x links rechts) =
    "[" ++ show x ++ ", " ++ show links ++ ", " ++ show rechts ++ "]"

aa = Leaf 1.2
bb = InnerNode 1.3 aa aa
cc = InnerNode 1.5 bb (Leaf 42.0)

mathe = InnerNode "x"
  (InnerNode "+"
    (Leaf "3") (Leaf "4")
  )
  (InnerNode "+"
    (Leaf "5") 
    (InnerNode "-"
      (Leaf "3") (Leaf "4")
    )
  )

postfixsearch :: Tree typ -> [typ]
postfixsearch (Leaf x) = [x]
postfixsearch (InnerNode x links rechts) =
  postfixsearch links ++ postfixsearch rechts ++ [x]
  
  

