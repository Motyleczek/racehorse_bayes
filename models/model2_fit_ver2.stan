
data{
    int N;
    vector<lower=0>[N] dad_value_numeric;
    vector<lower=0>[N] dad_num_of_starts;
    vector<lower=0>[N] dad_first_place;
    vector<lower=0>[N] dad_second_place;
    vector<lower=0>[N] dad_third_place;
    vector<lower=0>[N] kid_value;
    vector<lower=0>[N] potential_to_be_rich;
}

parameters {
    
    real<lower=0> sigma_x;
    real<lower=0> theta;
    // Together a0 and a1 make a0 in formula
    real<lower=0> a0;
    real<lower=0> a1; 
    // values below part of beta vector
    real<lower=0> value_coeff;
    real<lower=0> num_of_starts_coeff; 
    real<lower=0> first_place_coeff;
    real<lower=0> second_place_coeff;
    real<lower=0> third_place_coeff;
    // End of beta vector
    real<lower=0> omega2;
    real<lower=0> omega1;
}

transformed parameters {
    vector<lower=0>[N] mu_x;
    vector[N] mu;
    vector[N] sigma;
    for(i in 1:N){
        mu_x[i] =fmax(((value_coeff*dad_value_numeric[i]+a0-a1+
                    num_of_starts_coeff *dad_num_of_starts[i] +
                    first_place_coeff * dad_first_place[i] +
                    second_place_coeff *dad_second_place[i] +
                    third_place_coeff * dad_third_place[i])/4), 0)+0.003;
        mu[i] = (1-potential_to_be_rich[i])*log(pow(mu_x[i],2)/sqrt(pow(mu_x[i],2)+pow(sigma_x,2)))+potential_to_be_rich[i]*omega2;
        sigma[i] = (1-potential_to_be_rich[i])*theta + potential_to_be_rich[i]*omega1;
    }   
}

model {
    value_coeff ~ normal(0.2,0.001);
    num_of_starts_coeff ~ normal(0.4,0.001); 
    first_place_coeff ~ normal(0.3,0.001);
    second_place_coeff ~ normal(0.3,0.001);
    third_place_coeff ~ normal(0.3,0.001);
    a0 ~ lognormal(-1.95, 0.83);
    a1 ~ lognormal(-1.95, 0.83);
    sigma_x ~ normal(0.1, 0.01);
    theta ~ normal(1, 0.1);
    omega1 ~ normal(0.1, 0.01);
    omega2 ~ normal(0.05, 0.001);
    
    for (j in 1:N){
        kid_value[j] ~ lognormal(mu[j], sigma[j]);
    }
}

generated quantities {
    vector<lower=0>[N] kid_value_p;
    vector[N] log_likelihood;
    for (k in 1:N) {
        log_likelihood[k] = lognormal_lpdf(kid_value[k] | mu[k], sigma[k]);
        kid_value_p[k] =lognormal_rng(mu[k], sigma[k]);
    }
}