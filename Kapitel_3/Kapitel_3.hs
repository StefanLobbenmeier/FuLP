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

