module P21 (properDivisors, sumDivisors, sumAmicable, isAmicable, amicableList) where

properDivisors :: Int -> [Int]
properDivisors x = [xs | xs <- [1..highest], x `mod` xs == 0]
    where highest = x `div` 2

sumDivisors :: Int -> Int
sumDivisors x = sum $ properDivisors x

sumAmicable = sum [x | x <- [1..10000], isAmicable x]

amicableList = [x | x <- [1..10000], isAmicable x]

isAmicable x = if sumDivisors otherNumber == x && not (x == otherNumber) then True else False
    where otherNumber = sumDivisors x

isAbundant :: Int -> Bool
isAbundant n = if val > n then True
               else False
    where val = sumDivisors n

abundantList :: [Int]
abundantList = [x | x <- [1..28123], isAbundant x]

numTrue :: [Bool] -> Int
numTrue x = sum [1 | xs <- x, xs == True]

hasAbundantSum :: Int -> Bool
hasAbundantSum x = or $ map (isAbundantPair) points
    where points = zip [midpoint1..x] [midpoint2, (midpoint2-1)..1]
          midpoint1 = if even x then x `div` 2 else (x + 1) `div` 2
          midpoint2 = if even x then x `div` 2 else (x - 1) `div` 2

isAbundantPair (x, y) = isAbundant x && isAbundant y

nonAbundant y = [x | x <- [1..y], not $ hasAbundantSum x]

allAbundant y = [x | x <- [1..y], hasAbundantSum x]

answer = sum $ nonAbundant 20161
