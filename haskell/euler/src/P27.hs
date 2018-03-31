import           Data.Numbers.Primes

numPrimes :: (Int -> Int) -> Int
numPrimes x = consecutiveTrue $ map (isPrime . x) [0..1000]

consecutiveTrue :: [Bool] -> Int
consecutiveTrue (x:xs) =
  if x then 1 + consecutiveTrue xs
  else 0

euler n = n^2 + n + 41

form2 n = n^2 - (79*n) + 1601
