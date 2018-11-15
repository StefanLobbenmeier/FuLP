module Kapitel_3.CFloat (
    CFloat(..),(*),(+),show,re,im
    ) where

    data CFloat 
        = C Float Float

    instance Show CFloat where
        show (C r i) = "(" ++ show r ++ "+" ++ show i ++ "I)"

    instance Eq CFloat where 
        (==) (C r1 i1) (C r2 i2) = (r1 == r2) && (i1 == i2)
        
    instance Num CFloat where 
        (+) (C r1 i1) (C r2 i2) = C (r1+r2) (i1+i2)
        (-) (C r1 i1) (C r2 i2) = C (r1-r2) (i1-i2)
        (*) (C r1 i1) (C r2 i2) = C (r1*r2-i1*i2) (r1*i2+r2*i1)

        abs (C r i) = C (sqrt(r^2+i^2)) 0
        signum _ = 0

        fromInteger i = C (fromInteger i) 0
    
    instance Fractional CFloat where 
        (/) (C r1 i1) (C r2 i2) = (C ((r1*r2+i1*i2) / (r2^2+i2^2)) ((i1*r2-r1*i2) / (r2^2+i2^2)) 
        fromRational f = C (fromRaional f) 0

    
    re :: CFloat -> Float
    re (C r _) = r
    im :: CFloat -> Float
    im (C _ i) = i

