data{
    int N; // no of samples

    array[N] int horse_sex;

    vector[N] dad_ns; 
    vector[N] dad_fp; 
    vector[N] dad_sp;
    vector[N] dad_tp; 
    vector[N] dad_val; 
// mum
    vector[N] mum_ns;
    vector[N] mum_fp; 
    vector[N] mum_sp; 
    vector[N] mum_tp; 
    vector[N] mum_val; 
}

generated quantities {

   array[2] real dad_ns_coef;
   dad_ns_coef[1] = normal_rng(0,0.3);
   dad_ns_coef[2] = normal_rng(0,0.3);

   array[2] real dad_fp_coef;
   dad_fp_coef[1] = normal_rng(0,0.3);
   dad_fp_coef[2] = normal_rng(0,0.3);

   array[2] real dad_sp_coef;
   dad_sp_coef[1] = normal_rng(0,0.3);
   dad_sp_coef[2] = normal_rng(0,0.3);

   array[2] real dad_tp_coef;
   dad_tp_coef[1] = normal_rng(0,0.3);
   dad_tp_coef[2] = normal_rng(0,0.3);

   array[2] real dad_val_coef;
   dad_val_coef[1] = normal_rng(0,0.3);
   dad_val_coef[2] = normal_rng(0,0.3);

    array[2] real mum_ns_coef;
   mum_ns_coef[1] = normal_rng(0,0.3);
   mum_ns_coef[2] = normal_rng(0,0.3);

   array[2] real mum_fp_coef;
   mum_fp_coef[1] = normal_rng(0,0.3);
   mum_fp_coef[2] = normal_rng(0,0.3);

   array[2] real mum_sp_coef;
   mum_sp_coef[1] = normal_rng(0,0.3);
   mum_sp_coef[2] = normal_rng(0,0.3);

   array[2] real mum_tp_coef;
   mum_tp_coef[1] = normal_rng(0,0.3);
   mum_tp_coef[2] = normal_rng(0,0.3);

   array[2] real mum_val_coef;
   mum_val_coef[1] = normal_rng(0,0.3);
   mum_val_coef[2] = normal_rng(0,0.3);

   real alpha = normal_rng(0.003, 0.001);

    vector[N] mu;
    real sigma = exponential_rng(0.1);
    array[N] real<lower=0> output;
    
    for (i in 1:N){
      mu[i] = (dad_ns_coef[horse_sex[i]]*dad_ns[i] +
                dad_fp_coef[horse_sex[i]]*dad_fp[i] +
                dad_sp_coef[horse_sex[i]]*dad_sp[i] +
                dad_tp_coef[horse_sex[i]]*dad_tp[i] +
                dad_val_coef[horse_sex[i]]*dad_val[i] +
                mum_ns_coef[horse_sex[i]]*mum_ns[i] + 
                mum_fp_coef[horse_sex[i]]*mum_fp[i] +
                mum_sp_coef[horse_sex[i]]*mum_sp[i]+
                mum_tp_coef[horse_sex[i]]*mum_tp[i] +
                mum_val_coef[horse_sex[i]]*mum_val[i]+alpha);
    }
    output = lognormal_rng(mu, sigma);
}