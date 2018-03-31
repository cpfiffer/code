library(tidyquant)
prices <- tq_get("AAPL", get = "stock.prices", from = "1990-01-01")