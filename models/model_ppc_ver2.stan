data{
    int N;
    real dad_value_numeric[N];
    vector[N] dad_num_of_starts;
    vector[N] dad_first_place;
    vector[N] dad_second_place;
    vector[N] dad_third_place;
    // vector[N] kid_value;
}

parameters {
    vector <lower=0> [N] a0;
    vector <lower=0>[N] a1; 
    real <lower=0>value_coeff;
    real <lower=0>num_of_starts_coeff; 
    real <lower=0>first_place_coeff;
    real <lower=0>second_place_coeff;
    real <lower=0>third_place_coeff;
}

transformed parameters {

    // vector of calculated kid value mean
    real <lower=0> mu[N];

   


    for (j in 1:N) {
        mu[j] = value_coeff * dad_value_numeric[j]; 
                    //   num_of_starts_coeff * dad_num_of_starts[j] +
                    //   first_place_coeff * dad_first_place[j] +
                    //   second_place_coeff * dad_second_place[j] +
                    //   third_place_coeff * dad_third_place[j] ;
                    //   +
                    //   a0[j]-a1[j];
        // mu[j] = fmax(0.0, raw_mu);
    }
}

model {

    // a0 ~ lognormal(-4.951, 0.83);
    // a1 ~ lognormal(-4.951, 0.83);
    value_coeff ~ exponential(2.37);
    num_of_starts_coeff ~ lognormal(-1.48,0.71); 
    first_place_coeff ~ lognormal(-1.40,0.59);
    second_place_coeff ~ exponential(3.59);
    third_place_coeff ~  exponential(6.10);

    // a0 ~ lognormal(-4.951, 0.83);
    // a1 ~ lognormal(-4.951, 0.83);
    // value_coeff ~ exponential(2.37);
    // num_of_starts_coeff ~ lognormal(-1.48, 0.71); 
    // first_place_coeff ~ lognormal(-1.40, 0.59);
    // second_place_coeff ~ exponential(1 / 3.59); // Adjusted parameter for the exponential distribution
    // third_place_coeff ~ exponential(1 / 6.10); // Adjusted parameter for the exponential distribution
    for (j in 1:N){
        a0[j] ~ lognormal(-4.951, 0.83);
        a1[j] ~ lognormal(-4.951, 0.83);
    }
    

    // for (i in 1:N) {
    //     kid_value[i] ~ exponential(1/mu[i]);
    // }
}

generated quantities {
    vector[N] kid_value_pred;
    // vector[N] log_likelihood;

    for (i in 1:N) {
        
        kid_value_pred[i] = exponential_rng(1/mu[i]);
    }
}