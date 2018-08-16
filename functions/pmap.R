library(purrr)

rnorm(5)
rnorm(10)
rnorm(20)
map(list(5, 10, 20), rnorm)

rnorm(5, mean = 1)
rnorm(10, mean = 5)
rnomr(20, mean = 10)
map2(list(5, 10, 20), list(1, 5, 10), rnorm)

rnorm(5, mean = 1, sd = 0.1)
rnorm(10, mean = 5, sd = 0.5)
rnorm(20, mean = 10, sd = 0.1)
pmap(list(n = list(5, 10, 20),
          mean = list(1, 5, 10),
          sd = list(0.1, 0.5, 0.1)
          ), rnorm)


rnorm(5)
runif(5)
rexp(5)

invoke_map(list(rnorm, runif, rexp), n = 5)


rnorm_params <- list(mean = 10)
runif_params <- list(min = 0, max = 5)
rexp_params <- list(rate = 5)

params <- list(rnorm_params, 
               runif_params,
               rexp_params)
invoke_map(list(rnorm, runif, rexp), params, n = 5)


