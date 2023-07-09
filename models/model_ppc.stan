data{
    int N;
    vector[N] dad_value_numeric;
    vector[N] dad_num_of_starts;
    vector[N] dad_first_place;
    vector[N] dad_second_place;
    vector[N] dad_third_place;
}

generated quantities {
    // real value_coeff= normal_rng(0.1,0.1);
    // real num_of_starts_coeff = normal_rng(0.2,0.1);
    // real first_place_coeff =  normal_rng(0.15,0.1);========================================
    // real second_place_coeff =  normal_rng(0.15,0.1);
    // real third_place_coeff =  normal_rng(0.15,0.1);
    // vector[N] a0 =lognormal_rng(-4.951, 0.83);
    // vector [N] a1 =lognormal_rng(-4.951, 0.83);
   
    real a0 =lognormal_rng(-4.951, 0.83);
    real a1 =lognormal_rng(-4.951, 0.83);
    real  value_coeff=exponential_rng(2.37);
    
    real num_of_starts_coeff = lognormal_rng(-1.48,0.71); 
    real first_place_coeff = lognormal_rng(-1.40,0.59);
    real second_place_coeff = exponential_rng(3.59);
    real third_place_coeff =  exponential_rng(6.10);

    

    //vector of calculated offspring value
    vector[N] mu;
    // mu = num_of_starts_coeff*dad_num_of_starts+a0+value_coeff*dad_value_numeric;
    // for(j in 1:N)
    // {
    //     mu = value_coeff*dad_value_numeric[j]+num_of_starts_coeff*dad_num_of_starts[j]+
    // first_place_coeff*dad_first_place[j]+second_place_coeff*dad_second_place[j]
    // +third_place_coeff*dad_third_place[j]+a0[j]-a1[j];
    
    
    // }
    
     
    for(i in 1:N){
        mu[i] =dad_value_numeric[i];
    } 

    // *dad_value_numeric[i]+num_of_starts_coeff*dad_num_of_starts[i]+
    //         first_place_coeff*dad_first_place[i]+second_place_coeff*dad_second_place[i]
    //         +third_place_coeff*dad_third_place[i];


    // mu = value_coeff*dad_value_numeric+num_of_starts_coeff*dad_num_of_starts+
    // first_place_coeff*dad_first_place+second_place_coeff*dad_second_place
    // +third_place_coeff*dad_third_place;

    

    // prior predictive check - predicting life expectancy
    vector[N] kid_value;
    for (i in 1:N) {
        kid_value[i] = exponential_rng(1/mu[i]);
    }
}