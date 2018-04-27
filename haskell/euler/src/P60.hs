import           Control.Monad
import           Data.List
import           Data.Numbers.Primes

comb :: Int -> [a] -> [[a]]
comb 0 _      = [[]]
comb _ []     = []
comb m (x:xs) = map (x:) (comb (m-1) xs) ++ comb m xs

comb' :: Int -> [Int] -> [[Int]] -> [[Int]]
comb' 0 _  _    = [[]]
comb' _ [] _    = []
comb' m (x:xs) rm = next ++ comb' m xs rm
  where next = if or $ map (not . listHasTwo rm) ps then ps
               else [[]]
        ps = map (x:) (comb' (m-1) xs rm)

plist :: [Int]
plist = [3, 7, 109, 673]

concatPair :: [Int] -> Int
concatPair (x:(xs:_)) = read $ show x ++ show xs :: Int

canConcatAll :: [Int] -> Bool
canConcatAll ls = and $ map (isPrime . concatPair) combinations
  where combinations = concat [permutations x | x <- comb 2 ls]

whichFail :: [[Int]] -> [[Int]] -> [[Int]]
whichFail [] fails = fails
whichFail ls fails =
  if canConcatAll $ head ls then whichFail (tail ls) (fails)
  else whichFail (tail ls) ((head ls):fails)
  --combinations = concat [permutations x | x <- comb 2 ls]

canConcatAllV :: [Int] -> IO Bool
canConcatAllV ls = do
  when ans $ putStrLn (show ls ++ " => " ++ (show ans))
  return (ans)
  where combinations = concat [permutations x | x <- comb 2 ls]
        ans = and $ map (isPrime . concatPair) combinations

nextCombination :: [[Int]] -> Int -> ([[Int]], Int, [[Int]])
nextCombination [] best = ([], best, [])
nextCombination (x:xs) best =
  if xSum < best then
    if length failure > 0 then (trimList, best, failure)
    else (trimList, xSum, failure)
  else (trimList, best, failure)
  where xSum = sum x
        trimList = [z | z <- wean xs failure, sum z < best]
        failure = whichFail [] $ concat [permutations pl | pl <- comb 2 x]

nextCombination' :: [[Int]] -> Int -> ([[Int]], Int, [[Int]])
nextCombination' [] best = ([], best, [])
nextCombination' (x:xs) best =
  if xSum < best then
    if length failure > 0 then (trimList, best, failure)
    else (trimList, xSum, failure)
  else (trimList, best, failure)
  where xSum = sum x
        trimList = [z | z <- wean xs failure, sum z < best]
        failure = whichFail [] $ concat [permutations pl | pl <- comb 2 x]

wean biglist []     = biglist
wean biglist (y:rmlist) = wean nextList rmlist
  where nextList = rmLists y biglist

rmLists :: [Int] -> [[Int]] -> [[Int]]
rmLists remove x = [z | z <- x, criteria z]
  where fail1 sublist = elem (remove !! 0) sublist
        fail2 sublist = elem (remove !! 1) sublist
        criteria sublist = not $ (fail1 sublist) && (fail2 sublist)

rmLists' :: [[Int]] -> [[Int]] -> [[Int]]
rmLists' remove x = [z | z <- x, listHasTwo remove z]

listHasTwo :: [[Int]] -> [Int] -> Bool
listHasTwo rm sublist = (not . or) $ map (fails sublist) rm
    where fails sub r = (elem (r !! 0) sub) && (elem (r !! 1) sub)

loud x best iteration = do
  putStrLn $ "\n=====Iteration " ++ (show iteration) ++ "====="
  let combo = nextCombination x best
      len1 = length x
      len2 = length $ first combo
      change = len1 - len2
  putStrLn $ "Length: " ++ (show $ len1)
  putStrLn $ "Next Length: " ++ (show $ len2)
  putStrLn $ "Change: " ++ (show $ change)
  putStrLn $ "Best: " ++ (show $ (second combo))
  putStrLn $ "Removed: " ++ show (third combo)
  if len2 > 0 then loud (first combo) (second combo) (iteration + 1)
  else putStrLn $ "Done, the best sum is " ++ (show $ second combo)

loud' x best iteration = do
  putStrLn $ "\n=====Iteration " ++ (show iteration) ++ "====="
  let combo = nextCombination x best
      len1 = length x
      len2 = length $ first combo
      change = len1 - len2
  putStrLn $ "Length: " ++ (show $ len1)
  putStrLn $ "Next Length: " ++ (show $ len2)
  putStrLn $ "Change: " ++ (show $ change)
  putStrLn $ "Best: " ++ (show $ (second combo))
  putStrLn $ "Removed: " ++ show (third combo)
  if len2 > 0 then loud' (first combo) (second combo) (iteration + 1)
  else putStrLn $ "Done, the best sum is " ++ (show $ second combo)

first  (x,_,_) = x
second (_,x,_) = x
third  (_,_,x) = x

concatablePairs' :: [[Int]]
concatablePairs' = [ x | x <- comb' 4 (take amount changedPrimes) failures]
  where failures = whichFail [z | z <- comb 2 (take amount changedPrimes)] []
        amount = 250

concatablePairs :: [[Int]]
concatablePairs = [ x | x <- comb 4 (take amount changedPrimes), listHasTwo failures x]
  where failures = whichFail [z | z <- comb 2 (take amount changedPrimes)] []
        amount = 250

concatablePairs2 :: [[Int]]
concatablePairs2 = [ x | x <- comb 4 (take amount changedPrimes)]
  where amount = 250

changedPrimes :: [Int]
changedPrimes = filter (/=2) (filter (/=5) primes)

answer = loud concatablePairs2 10101010 0
