module Kapitel_3.YesNo (YesNo, yesno, yesnoIf) where 
    class YesNo a where
        yesno :: a -> Bool
        
    instance YesNo Int where 
        yesno 0 = False
        yesno _ = True
    instance YesNo Integer where 
        yesno 0 = False
        yesno _ = True
    instance YesNo Float where 
        yesno 0.0 = False
        yesno _ = True
    instance YesNo Double where 
        yesno 0.0 = False
        yesno _ = True
    instance YesNo Bool where 
        yesno = id
    instance YesNo [a] where 
        yesno [] = False
        yesno _ = True
    instance (YesNo a) => YesNo (Maybe a) where 
        yesno (Just a) = yesno a
        yesno Nothing = False
    {- instance YesNo (Maybe a) where 
        yesno (Just a) = True
        yesno Nothing = False
        -}

    yesnoIf :: (YesNo a) => a -> b -> b -> b
    yesnoIf x yes no = if yesno x then yes else no

