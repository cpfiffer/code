-- Where x is one side of the square, e.g. 25 for a 25x25 box.
corners :: Int -> [Int]
corners x =
  if x == 1 then [1]
  else [tr, tl, bl, br]
  where offset = x-1
        tr = x*x
        tl = tr - offset
        bl = tl - offset
        br = bl - offset

answer :: Int
answer = sum . concat $ [corners x | x <- [1..1001], odd x]

