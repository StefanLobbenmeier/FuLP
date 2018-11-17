springerzuege :: [(Int, Int) -> (Int, Int)]
springerzuege = [
    \(x, y) -> ((x - 2), (y - 1)),
    \(x, y) -> ((x - 2), (y + 1)),
    \(x, y) -> ((x + 2), (y - 1)),
    \(x, y) -> ((x + 2), (y + 1)),
    \(x, y) -> ((x - 1), (y - 2)),
    \(x, y) -> ((x - 1), (y + 2)),
    \(x, y) -> ((x + 1), (y - 2)),
    \(x, y) -> ((x + 1), (y + 2))
    ]

validate :: (Int, Int) -> [(Int, Int)]
validate (x, y) = if x < 1 || y < 1 || x > 8 || y > 8 then [] else [(x, y)]

springerzug :: (Int, Int) -> [(Int, Int)]
springerzug (x, y) = springerzuege <*> [(x, y)] >>= validate

springer3 :: (Int, Int) -> [(Int, Int)]
springer3 (x, y) = pure (x, y) >>= springerzug >>= springerzug >>= springerzug

erreichbar3 :: (Int, Int) -> (Int, Int) -> Bool
erreichbar3 (startX, startY) (targetX, targetY) = elem (targetX, targetY) (springer3 (startX, startY)) 