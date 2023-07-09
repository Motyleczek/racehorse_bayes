generated quantities {
    real<lower= 0> mu = lognormal_rng(-2.15, 1.02);
   

    real kid_value = exponential_rng(1/mu);
}