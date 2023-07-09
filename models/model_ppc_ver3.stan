

data{
    int N;
    vector<lower=0>[N] dad_value_numeric;// indywidual
    vector<lower=0>[N] dad_num_of_starts;//uniwersalny
    vector<lower=0>[N] dad_first_place;
    vector<lower=0>[N] dad_second_place;
    vector<lower=0>[N] dad_third_place;
    vector<lower=0>[N] kid_value;
}

parameters {
    real<lower=0> a0[N];
    real<lower=0> a1[N]; 
    real<lower=0> value_coeff;
    real<lower=0> num_of_starts_coeff; 
    real<lower=0> first_place_coeff;
    real<lower=0> second_place_coeff;
    real<lower=0> third_place_coeff;
}

transformed parameters {
    // vector of calculated kid value mean
    real<lower=0> mu[N];

    for (j in 1:N) {
        // mu[j] = (value_coeff*dad_value_numeric[j]+0.00001+a0-a1+
        //         num_of_starts_coeff * dad_num_of_starts[j] +
        //         first_place_coeff * dad_first_place[j] +
        //         second_place_coeff * dad_second_place[j] +
        //         third_place_coeff * dad_third_place[j])/3;
        mu[j] = dad_value_numeric[j]+0.00001+a0[j]-a1[j]+
                dad_num_of_starts[j] +
                dad_first_place[j] +
                dad_second_place[j] +
                dad_third_place[j];
    }
}

model {

    

    // value_coeff ~ exponential(2.37);
    // num_of_starts_coeff ~ lognormal(-1.48, 0.71); 
    // first_place_coeff ~ lognormal(-1.40, 0.59);
    // second_place_coeff ~ exponential(3.59);
    // third_place_coeff ~ exponential(6.10);
    // a0 ~ exponential(0.001);
    // a1 ~ exponential(0.001);
    // a0 ~ lognormal(-1.95, 0.832);
    // a1 ~ lognormal(-1.95, 0.83);
    for (j in 1:N){
        kid_value[j] ~ exponential(1/mu[j]);
    
    }
    
   
}

generated quantities {
    real kid_value_p[N];

    for (j in 1:N) {
        kid_value_p[j] = exponential_rng(1/mu[j]);
    }
}
