
data {
  int<lower=0> N;
  int<lower=0> y[N];
  vector[N] log_pop;
  vector[N] x;
}


parameters {
  real log_alpha;
  real beta;
}

model {
  y ~ poisson_log(log_alpha+beta*x+log_pop);
  log_alpha ~ normal(0,100);
  beta ~ normal(0, 100);
}

