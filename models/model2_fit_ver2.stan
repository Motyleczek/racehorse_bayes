data{
    int N;
    // int<lower=0, upper=1> potential_to_be_rich[N];
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
    real <lower=0> mu[N];
    real <lower=0> sigma[N];
    real mulog[N];
    real sigmalog[N];
    
    // real<lower=0> mu_2[N];
    // real<lower=0> sigma_2[N];
    for(i in 1:N){


        mu[i] =fmax(((value_coeff*dad_value_numeric[i]+a0-a1+
                    num_of_starts_coeff *dad_num_of_starts[i] +
                    first_place_coeff * dad_first_place[i] +
                    second_place_coeff *dad_second_place[i] +
                    third_place_coeff * dad_third_place[i])/2),0)+0.00001;
    for(i in 1:N){
        sigma[i]= 0.00001;
    }
    for(i in 1:N){
        mulog[i]= 0;
    }
    for(i in 1:N){
        sigmalog[i] = 1;
    }
        
        
        // log(pow(mu[i],2)/sqrt(pow(mu[i],2)+pow(sigma[i],2)));
        
        // sqrt(log(1+pow(mu[i],2)/pow(sigma[i],2)));

        // mu_2[i] = fmax(potential_to_be_rich[i]*(1+(first_place_coeff*dad_first_place[i] + 
        //                     num_of_starts_coeff*dad_num_of_starts[i]+ 
        //                     a2)*-0.2),0);
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

    value_coeff ~ normal(0.2,0.001);
    num_of_starts_coeff ~ normal(0.4,0.001); 
    first_place_coeff ~ normal(0.3,0.001);
    second_place_coeff ~ normal(0.3,0.001);
    third_place_coeff ~ normal(0.3,0.001);
    a0 ~ lognormal(-1.95, 0.83);
    a1 ~ lognormal(-1.95, 0.83);
    a2 ~ lognormal(-1.95, 0.83);
    

    // a0 ~ lognormal(-1.95, 0.832);
    // a1 ~ lognormal(-1.95, 0.83);
    for (j in 1:N){
        kid_value[j] ~ lognormal(mulog[j], sigmalog[j]);
        // kid_value_rich[j] ~normal(mu_2[j], 0.000001);

    
    }

    
    // for (n in 1:N) {
    //         target += log_sum_exp(
    //                  exponential_lpdf(kid_value[n] | 1/mu[n]),
    //                  normal_lpdf(kid_value[n] | mu[n], 0.000001));
    //             }
   
}

generated quantities {
    real kid_value_p[N];
    // real kid_value_rich_p[N];
    // vector[N] log_likelihood;
    for (j in 1:N) {
        // log_likelihood[j] = lognormal_lpdf(kid_value[j] | mulog[j],sigmalog[j]);
        // kid_value_rich_p[j]= normal_rng(mu_2[j],0.000001);
        kid_value_p[j] =lognormal_rng(mulog[j],sigmalog[j]);

    }
}
