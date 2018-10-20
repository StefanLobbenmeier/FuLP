#!/usr/bin/env runhaskell

import System.Environment
import Data.Char

main = interact head3

head3 :: String -> String
head3 input = unlines (take 3 (lines input))