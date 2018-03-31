module P20
    ( someFunc,
      factorialSum
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

factorialSum :: Integer -> Integer
factorialSum x = sumDigits $ factorial x

factorial :: Integer -> Integer
factorial 1 = 1
factorial x = x * factorial (x-1)

sumDigits :: Integer -> Integer
sumDigits 0 = 0
sumDigits x = (x `mod` 10) + sumDigits (x `div` 10)
