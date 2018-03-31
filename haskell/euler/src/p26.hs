import           Data.Numbers.Primes

-- Remove factors of 2,5 from a number.
reduceNum :: Integer -> Integer
reduceNum x = y
  where y = product reducedFactors
        reducedFactors = filter (not . twoOrFive) factors
        factors = primeFactors x

twoOrFive :: Integer -> Bool
twoOrFive x = if x == 2 || x == 5 then True
  else False

patternLength :: Integer -> Integer
patternLength x = patLeng 1 x

patLeng :: Integer -> Integer -> Integer
patLeng pow digits = if reducedDigit == 1 then 0
                     else if ans == 1 then pow
                         else patLeng (pow + 1) reducedDigit
  where ans = (10^pow) `mod` reducedDigit
        reducedDigit = reduceNum digits

loudLength x = putStrLn $ show (x) ++ " => " ++ show (patternLength x)

answer  = maximum $ map (patternLength) [1..1000]
answerL = mapM_ (loudLength) [1..1000]
