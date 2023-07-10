data{    
    int N;
    vector<lower=0>[N] dad_value_numeric;
    vector<lower=0>[N] dad_num_of_starts;
    vector<lower=0>[N] dad_first_place;
    vector<lower=0>[N] dad_second_place;
    vector<lower=0>[N] dad_third_place;
    vector<lower=0>[N] kid_value;
}

parameters {

    real<lower=0.0> a0;
    real<lower=0.0> a1; 
    real<lower=0.0> value_coeff;
    real<lower=0.0> num_of_starts_coeff; 
    real<lower=0.0> first_place_coeff;
    real<lower=0.0> second_place_coeff;
    real<lower=0.0> third_place_coeff;
}

transformed parameters {

    real<lower=0> mu[N];
    for(i in 1:N){
        mu[i] = (value_coeff*dad_value_numeric[i]+0.00001+a0-a1+
                        num_of_starts_coeff *dad_num_of_starts[i] +
                        first_place_coeff * dad_first_place[i] +
                        second_place_coeff *dad_second_place[i] +
                        third_place_coeff * dad_third_place[i])/4;

    }
    
}

model {

    value_coeff ~ normal(0.2,0.01);
    num_of_starts_coeff ~ normal(0.4,0.01); 
    first_place_coeff ~ normal(0.3,0.01);
    second_place_coeff ~ normal(0.3,0.01);
    third_place_coeff ~ normal(0.3,0.01);
    a0 ~ lognormal(-1.95, 0.83);
    a1 ~ lognormal(-1.95, 0.83);
    
    for (j in 1:N){
        kid_value[j] ~ exponential(1/mu[j]);
    
    }
    
   
}

generated quantities {
    real kid_value_p[N];
    vector[N] log_likelihood;
    for (j in 1:N) {
        log_likelihood[j] = exponential_lpdf(kid_value[j] | 1/mu[j]);
        kid_value_p[j] = exponential_rng(1/mu[j]);
    }
}
