import Kapitel_3.YesNo

tests = [
    True,
    False
    ]

main = do
    {- map (\test -> 
        putStrLn (
        show test ++
        " = " ++ 
        show (yesno test)
        )
        ) tests -}
    
    -- https://stackoverflow.com/a/5289853
    mapM_ printYesNo tests
    

printYesNo :: (YesNo a, Show a) => a -> IO()
printYesNo a = putStrLn (show a ++ " = " ++ show (yesno a))