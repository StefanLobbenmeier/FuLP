-- 3)

eingabe = "3 5 + 2 /"

convertEingabeToList :: [Char] -> [[Char]]
convertEingabeToList (a:[]) = [[a]]
convertEingabeToList (a:' ':rest) = [[a]] ++ convertEingabeToList rest

liste = convertEingabeToList eingabe

oneStep :: [Double] -> String -> [Double]
oneStep (a:b:rstack) "+" = (b + a):rstack
oneStep (a:b:rstack) "-" = (b - a):rstack
oneStep (a:b:rstack) "*" = (b * a):rstack
oneStep (a:b:rstack) "/" = (b / a):rstack
oneStep stack number = (read number):stack

machine :: [Double] -> [String] -> [Double]
machine stack [] = stack
machine stack (opOrNumber:rOpOrNumber) = machine (oneStep stack opOrNumber) rOpOrNumber

convertListToDouble :: [Double] -> Double
convertListToDouble (a:[]) = a

-- solveRPN = convertListToDouble . machine [] . convertEingabeToList

-- 4)
anotherWayToTheSolution = foldl oneStep [] liste

-- foldl oneStep [] ["3","5","+","2","/"] = 
-- foldl oneStep (oneStep [] "5") ["3", "+","2","/"]
-- foldl oneStep (oneStep [5] "3") ["+","2","/"]
-- foldl oneStep (oneStep [3, 5] "+") ["2","/"]
-- foldl oneStep (oneStep [8] "2") ["/"]
-- foldl oneStep (oneStep [2, 8] "/") []
-- foldl oneStep ([4]) []
-- [4]

solveRPN :: [String] -> Double
solveRPN = convertListToDouble . (foldl oneStep [])