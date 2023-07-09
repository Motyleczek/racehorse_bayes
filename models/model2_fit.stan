data{
    int N;
    int<lower=0, upper=1> potential_to_be_rich[N];
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
    real<lower=0.0> a2; 
    real<lower=0.0> value_coeff;
    real<lower=0.0> num_of_starts_coeff; 
    real<lower=0.0> first_place_coeff;
    real<lower=0.0> second_place_coeff;
    real<lower=0.0> third_place_coeff;
}

transformed parameters {
    real<lower=0> mu[N];
    real<lower=0> mu_2[N];
    // real<lower=0> sigma_2[N];
    for(i in 1:N){
        mu[i] = fmax(((1-potential_to_be_rich[i])*(value_coeff*dad_value_numeric[i]+a0-a1+
                    num_of_starts_coeff *dad_num_of_starts[i] +
                    first_place_coeff * dad_first_place[i] +
                    second_place_coeff *dad_second_place[i] +
                    third_place_coeff * dad_third_place[i])/2),0)+0.00001;

        mu_2[i] = fmax(potential_to_be_rich[i]*(1+(first_place_coeff*dad_first_place[i] + 
                            num_of_starts_coeff*dad_num_of_starts[i]+ 
                            a2)*-0.2),0);
        // sigma_2[i] = normal_rng(0.00001, 0.000001);
    

    }
    
}

model {

    // value_coeff ~ exponential(2); // Adjusted to approximate an exponential distribution with mean 2
    // num_of_starts_coeff ~ exponential(2); // Adjusted to approximate an exponential distribution with mean 2
    // first_place_coeff ~ exponential(2); // Adjusted to approximate an exponential distribution with mean 2
    // second_place_coeff ~ exponential(2); // Adjusted to approximate an exponential distribution with mean 2
    // third_place_coeff ~ exponential(2); // Adjusted to approximate an exponential distribution with mean 2
    // a0 ~ exponential(2); // Adjusted to approximate an exponential distribution with mean 2
    // a1 ~ exponential(2); // Adjusted to approximate an exponential distribution with mean 2

    value_coeff ~ normal(0.2,0.01);
    num_of_starts_coeff ~ normal(0.4,0.01); 
    first_place_coeff ~ normal(0.3,0.01);
    second_place_coeff ~ normal(0.3,0.01);
    third_place_coeff ~ normal(0.3,0.01);
    a0 ~ lognormal(-1.95, 0.83);
    a1 ~ lognormal(-1.95, 0.83);
    a2 ~ lognormal(-1.95, 0.83);
    

    // a0 ~ lognormal(-1.95, 0.832);
    // a1 ~ lognormal(-1.95, 0.83);
    for (j in 1:N){
        kid_value[j] ~ exponential(1/mu[j]);
        // kid_value_rich[j] ~normal(mu_2[j], 0.000001);

    
    }
    
   
}

generated quantities {
    real kid_value_p[N];
    real kid_value_rich_p[N];
    vector[N] log_likelihood;
    for (j in 1:N) {
        log_likelihood[j] = exponential_lpdf(kid_value[j] | 1/mu[j]);
        kid_value_rich_p[j]= normal_rng(mu_2[j],0.000001);
        kid_value_p[j] = exponential_rng(1/mu[j])+kid_value_rich_p[j];

    }
}
