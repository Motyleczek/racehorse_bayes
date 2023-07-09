generated quantities {
    real<lower=0.0> value =  exponential_rng(2.37);
    real<lower=0.0> num_of_starts = lognormal_rng(-1.48, 0.71); 
    real<lower=0.0> first_place = lognormal_rng(-1.40, 0.59);
    real<lower=0.0> second_place = exponential_rng(3.59);
    real<lower=0.0> third_place = exponential_rng(6.10);
    real<lower=0.0> a0 = lognormal_rng(-1.95, 0.83);
    real<lower=0.0> a1 = lognormal_rng(-1.95, 0.83);
    real<lower=0.0> a2 = lognormal_rng(-1.95, 0.83);


    real<lower=0.0> value_coeff =  normal_rng(0.2,0.01);
    real<lower=0.0> num_of_starts_coeff = normal_rng(0.4,0.01); 
    real<lower=0.0> first_place_coeff =normal_rng(0.3,0.01);
    real<lower=0.0> second_place_coeff = normal_rng(0.3,0.01);
    real<lower=0.0> third_place_coeff = normal_rng(0.3,0.01);
    // a1 ~ lognormal(-1.95, 0.83);
    
    real<lower= 0> mu = (value_coeff*value+0.00001+a0-a1+
                num_of_starts_coeff *num_of_starts +
                first_place_coeff * first_place +
                second_place_coeff *second_place +
                third_place_coeff * third_place)/4;

    real<lower=0.0> mu_2 = first_place_coeff*first_place + 
                        num_of_starts_coeff*num_of_starts + 
                        a2;
    real<lower=0.0> sigma_2 = normal_rng(0.01, 0.01);


    // real<lower= 0> mu = lognormal_rng(-2.15, 1.02);
    real kid_value = exponential_rng(1/mu) + normal_rng(mu_2, sigma_2);
}