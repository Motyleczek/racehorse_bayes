data{
    int N;
    vector<lower=0>[N] dad_value_numeric;
    vector<lower=0>[N] dad_num_of_starts;
    vector<lower=0>[N] dad_first_place;
    vector<lower=0>[N] dad_second_place;
    vector<lower=0>[N] dad_third_place;
    vector<lower=0>[N] kid_value;

}
transformed parameters {
   
   for(j in 1:N)
    {
        mu[j] = 0.000001+value_coeff*dad_value_numeric[j]+num_of_starts_coeff*dad_num_of_starts[j]+
    first_place_coeff*dad_first_place[j]+second_place_coeff*dad_second_place[j]
    +third_place_coeff*dad_third_place[j]+a0-a1;
    
    
    }
}

model{
    
    for (i in 1:N) {
        kid_value[i] ~ exponential(1/mu[i]);
    }
}

generated quantities {
       
    real a0 =lognormal_rng(-4.951, 0.83);
    real a1 =lognormal_rng(-4.951, 0.83);
    real value_coeff=exponential_rng(2.37);
    
    real num_of_starts_coeff = lognormal_rng(-1.48,0.71); 
    real first_place_coeff = lognormal_rng(-1.40,0.59);
    real second_place_coeff = exponential_rng(3.59);
    real third_place_coeff =  exponential_rng(6.10);

    

    //vector of calculated offspring value
   
    
    
    
    real kid_value_p[N];
    for (i in 1:N) {
        kid_value_p[i] = exponential_rng(1/mu[i]);
    }
}

