--
--An implementation of financial contract evaluation.
import Data.Time

format = iso8601DateFormat Nothing
date = readSTime True defaultTimeLocale format "1/10/2017"
date2 = readSTime True defaultTimeLocale format "1/13/2017"

print date

