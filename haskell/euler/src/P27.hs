import           Data.Numbers.Primes

data Cof = Cof Int Int Int deriving (Show)

nullcof :: Cof
nullcof = Cof 0 0 0

getN :: Cof -> Int
getN (Cof _ _ n) = n

getA :: Cof -> Int
getA (Cof a _ _) = a

getB :: Cof -> Int
getB (Cof _ b _) = b

numPrimes :: (Int -> Int) -> Int
numPrimes x = consecutiveTrue $ map (isPrime . x) [0..999]

consecutiveTrue :: [Bool] -> Int
consecutiveTrue (x:xs) =
  if x then 1 + consecutiveTrue xs
  else 0

euler :: Int -> Int
euler n = n^2 + n + 41

form2 :: Int -> Int
form2 n = n^2 - (79*n) + 1601

formula :: Int -> Int -> Int -> Int
formula a b n = n^2 + a * n + b

findBest :: [Cof]
findBest = [Cof a b (numPrimes $ formula a b) | a <- aList, b <- bList]
  where aList = [-999..999]
        bList = [-999..999]

highest :: [Cof] -> Cof -> Cof
highest [] best = best
highest (cof:cofList) best =
  if cofn > bestn then highest cofList cof
  else highest cofList best
  where cofn = getN cof
        bestn = getN best

answer = highest (findBest) nullcof
