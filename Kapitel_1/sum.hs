sum1 :: [Int] -> Int
sum1 [] = 0
sum1 [x] = x
sum1 (a:b:rest) = sum1 ((a+b):rest)

sum2 :: [Int] -> Int
sum2 [] = 0
sum2 (a:rest) = a + sum2 rest

