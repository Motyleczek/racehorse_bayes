data {
    real mu_dad_num_of_starts;
    real sigma_dad_num_of_starts;
    real mu_dad_first_place;
    real sigma_dad_first_place;
    real lambda_dad_value_numeric_rescale;
    real lambda_dad_second_place;
    real lambda_dad_third_place;
}

generated quantities {
    real<lower=0> first_place = lognormal_rng(mu_dad_first_place, sigma_dad_first_place); 
    real<lower=0> num_of_start= lognormal_rng(mu_dad_num_of_starts, sigma_dad_num_of_starts);
    real<lower=0> value_numeric= exponential_rng(lambda_dad_value_numeric_rescale);
    real<lower=0> second_place = exponential_rng(lambda_dad_second_place);
    real<lower=0> third_place = exponential_rng(lambda_dad_third_place);
    
    real kid_value = exponential_rng(1/num_of_start);
}

// data {
//     real mu_dad_num_of_starts;
//     real sigma_dad_num_of_starts;
//     real mu_dad_first_place;
//     real sigma_dad_first_place;
//     real lambda_dad_value_numeric_rescale;
//     real lambda_dad_second_place;
//     real lambda_dad_third_place;
// }

// generated quantities {
//     real<lower=0> first_place = fmin(100, lognormal_rng(mu_dad_first_place, sigma_dad_first_place)); 
//     real<lower=0> num_of_start = fmin(100, lognormal_rng(mu_dad_num_of_starts, sigma_dad_num_of_starts));
//     real<lower=0> value_numeric = fmin(100, exponential_rng(lambda_dad_value_numeric_rescale));
//     real<lower=0> second_place = fmin(100, exponential_rng(lambda_dad_second_place));
//     real<lower=0> third_place = fmin(100, exponential_rng(lambda_dad_third_place));
    
//     real life_expectancy = exponential_rng(1 / num_of_start);
// }