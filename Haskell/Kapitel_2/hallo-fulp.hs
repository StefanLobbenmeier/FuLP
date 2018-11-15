#!/usr/bin/env runhaskell

import Data.Char

main = do
    putStr "Anmeldung: "
    username <- getLine
    putStr ("Willkommen im FuLP-Kurs, " ++ username ++
        ", deine Zeichensumme ist " ++
        (show (zsumme username)) ++ ".\n")

zsumme :: [Char] -> Int
zsumme [] = 0
zsumme (a:rest) = (ord a) + zsumme rest