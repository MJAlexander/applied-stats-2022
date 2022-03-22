data {
  int<lower=1> N;
  vector[N] arsenic;
  vector[N] dist;
  int<lower=0,upper=1> y[N];
}
transformed data {
  vector[N] inter;           // interaction
  inter     = dist .* arsenic;
}
parameters {
  vector[4] beta; 
}
model {
  beta ~ normal(0,1);
  y ~ bernoulli_logit(beta[1] + beta[2] * dist + beta[3] * arsenic + beta[4] * inter);
}
generated quantities {
  vector[N] log_lik;    // pointwise log-likelihood for LOO
  vector[N] y_rep; // replications from posterior predictive dist

  for (n in 1:N) {
    real y_hat_n = beta[1] + beta[2] * dist[n] + beta[3] * arsenic[n] + beta[4] * inter[n];
    log_lik[n] = bernoulli_logit_lpmf(y[n] | y_hat_n);
    y_rep[n] = bernoulli_logit_rng(y_hat_n);
  }
}
