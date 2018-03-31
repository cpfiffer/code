double :: Int -> Int
double x = x * 2

-- Order   = ID, Size, Price, Side
data Order = Order Int Double Double Side deriving (Show)
data Side  = Bid | Ask deriving (Show, Eq)
data Orderbook = Orderbook

test = Order 0 10.0 15.0 Bid

value :: Order -> Double
value (Order _ size price side) = (signedSide side) * val
  where val = size * price

signedSide :: Side -> Int
signedSide (Side kind)
  | kind == Bid = 1
  | kind == Ask = -1


