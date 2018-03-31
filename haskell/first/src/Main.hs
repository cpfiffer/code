module Main where

import           Currency
import           Timestuff

main = putStrLn "Test"



t0 = dateFromInt 2017 1 1
t1 = dateFromInt 2017 6 1
d1 = numDays t1 t0
