module Timestuff (getDate, dateTime, dateFromInt, utcMod, numDays, numYears) where

import           Data.Time

getDate :: String -> Day
getDate x = day
    where day = parseTimeOrError True defaultTimeLocale "%Y-%-m-%-d" x

-- | Date string -> hours -> minutes
dateTime :: String -> Integer -> Integer -> UTCTime
dateTime str hrs mins = UTCTime day t
    where day = getDate str
          t = realToFrac (hrs * 3600 + mins * 60)

dateFromInt :: Integer -> Integer -> Integer -> UTCTime
dateFromInt year month day = dateTime datestr 0 0
    where datestr = show year ++ "-" ++ show month ++ "-" ++ show day

utcMod :: Integer -> Integer -> Integer -> Integer
utcMod hours minutes seconds = hours * 3600 + minutes * 60 + seconds

numDays :: UTCTime -> UTCTime -> NominalDiffTime
numDays t1 t2 = x
    where x = (diffUTCTime t1 t2) / nominalDay

numYears :: UTCTime -> UTCTime -> Integer
numYears t1 t2 = x
    where x = truncate $ (diffUTCTime t1 t2) / (nominalDay * 365)
