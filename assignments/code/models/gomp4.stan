
data {
  int<lower=0> N;
  int<lower=0> T;
  int<lower=0> y[N,T];
  matrix[N,T] log_pop;
  vector[N] x;
}


parameters {
  real<lower=0> alpha[T];
  real<lower=0> beta[T];
}

transformed parameters{
  real log_alpha[T];
  log_alpha = log(alpha);
}

model {
  for(t in 1:T){
    y[,t] ~ poisson_log(log_alpha[t]+beta[t]*x+log_pop[,t]);
  }
  
  alpha ~ normal(0, 10);
  beta ~ normal(0, 10);
}



