# Setup
library(keras)
library(tidyquant)
library(rsample)

# Test data
source <- rnorm(120000)
dummy <- matrix(source, ncol = 6)
dummy_y <- matrix(rowSums(dummy))

# Conversion
clean <- function(df) {
  return(df %>% as.matrix() %>% normalize(1))
}

train <- dummy %>% clean()
train_y <- dummy_y %>% clean()

# Model Stuff
model <- keras_model_sequential() 
model %>% 
  layer_dense(units = 12, activation = 'relu', input_shape = c(6)) %>% 
  layer_dense(units = 1, activation = 'linear')

model %>% compile(
  loss = loss_mean_squared_error,
  optimizer = optimizer_adam()
)

history <- model %>% fit(
  train, train_y, 
  epochs = 10, batch_size = 10,
  validation_split = 0.2,
  metrics = metric_mean_squared_error
)

head(predict(model, train))
head(train_y)
