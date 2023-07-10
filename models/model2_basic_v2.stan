generated quantities {
    real<lower=0, upper=1> potential_rich = bernoulli_rng(0.05);
    real<lower=0.0> value =  exponential_rng(2.37);
    real<lower=0.0> num_of_starts = lognormal_rng(-1.48, 0.71); 
    real<lower=0.0> first_place = lognormal_rng(-1.40, 0.59);
    real<lower=0.0> second_place = exponential_rng(3.59);
    real<lower=0.0> third_place = exponential_rng(6.10);
    real<lower=0.0> a0 = lognormal_rng(-1.95, 0.83);
    real<lower=0.0> a1 = lognormal_rng(-1.95, 0.83);

    real<lower=0.0> value_coeff =  normal_rng(0.2,0.01);
    real<lower=0.0> num_of_starts_coeff = normal_rng(0.4,0.01); 
    real<lower=0.0> first_place_coeff =normal_rng(0.3,0.01);
    real<lower=0.0> second_place_coeff = normal_rng(0.3,0.01);
    real<lower=0.0> third_place_coeff = normal_rng(0.3,0.01);
    real<lower=0.0> omega2 = normal_rng(0.05, 0.001);
    real<lower=0.0> omega1 = normal_rng(0.1, 0.01);
    
    real<lower= 0> mu_x = fmax((value_coeff*value+a0-a1+
                num_of_starts_coeff *num_of_starts +
                first_place_coeff * first_place +
                second_place_coeff *second_place +
                third_place_coeff * third_place)/4, 0) + 0.003;

    real<lower=0.0> sigma_x = normal_rng(0.1, 0.01);

    real mu = (1-potential_rich)*log(pow(mu_x,2)/sqrt(pow(mu,2)+pow(sigma_x,2))) + potential_rich*omega2;
    real sigma =(1-potential_rich)*normal_rng(1, 0.1) + potential_rich*omega1;

    real kid_value = lognormal_rng(mu, sigma);

}