#!/usr/bin/env runhaskell

import System.Environment
import Data.Char

main = interact tail3

tail3 :: String -> String
tail3 input = unlines (reverse (take 3 (reverse (lines input))))