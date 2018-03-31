module P25 where

-- Find a fibonacci number by number of digits.
fib :: Int -> [Integer] -> [Integer]
fib x fiblist = if numdigits (fiblist!!0) < x then fib x $ nextfib fiblist
                else fiblist

numdigits :: Integer -> Int
numdigits x = length $ show x

nextfib :: [Integer] -> [Integer]
nextfib x = y:x
  where fib1 = x!!0
        fib2 = x!!1
        y = fib1 + fib2

answer = putStrLn $ show $ length ls
  where ls = fib 1000 [1,1]

