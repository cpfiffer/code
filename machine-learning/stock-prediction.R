# Setup
library(keras)
library(tidyquant)
library(rsample)

# Conversion
clean <- function(df) {
  return(df %>% as.matrix() %>% normalize(1))
}

clean_straight <- function(df) {
  return(df %>% as.matrix())
}

prices$y <- lead(prices$close)

split <- initial_split(prices, prop = 0.8)

train <- training(split) %>% drop_na()
test <- testing(split) %>% drop_na()

train_y <- train$y %>% 
  clean_straight()

test_y <- test$y %>% 
  clean_straight()

train <- train %>% 
  select(-c(y, date)) %>% 
  clean()

test <- test %>% 
  select(-c(y, date)) %>% 
  clean()

model <- keras_model_sequential() 
model %>% 
  layer_dense(units = 128, activation = 'relu', input_shape = c(6)) %>% 
  layer_dropout(rate = 0.4) %>% 
  layer_dense(units = 64, activation = 'relu') %>% 
  layer_dropout(rate = 0.2) %>% 
  layer_dense(units = 32, activation = 'relu') %>% 
  layer_dropout(rate = 0.1) %>% 
  layer_dense(units = 16, activation = 'relu') %>% 
  layer_dense(units = 1, activation = 'relu')

model %>% compile(
  loss = loss_mean_absolute_error,
  optimizer = optimizer_rmsprop(),
  metrics = metric_mean_absolute_error
)

history <- model %>% fit(
  train, train_y, 
  epochs = 10, batch_size = 1,
  validation_split = 0.2
)

tail(predict(model, train))
tail(train_y)

tail(predict(model, test))
tail(test_y)
