#!/usr/bin/env runhaskell

import System.Environment
import Data.Char

main = do
  argsv <- getArgs
  let readFilepath = argsv!!0 --"test.txt"
  let writeFilepath = argsv!!1 --"test2.txt"

  input <- readFile readFilepath
  let inputlines = lines input

  let outputLines = transformEverySecondLine inputlines
  let output = unlines outputLines

  writeFile writeFilepath output

transformEverySecondLine :: [String] -> [String]
transformEverySecondLine ([]) = []
transformEverySecondLine (line:r) = [line] ++ transformEverySecondLine1 r

transformEverySecondLine1 :: [String] -> [String]
transformEverySecondLine1 ([]) = []
transformEverySecondLine1 (line:r) = [transform line] ++ transformEverySecondLine r

transform :: String -> String
transform (line) = map toUpper line