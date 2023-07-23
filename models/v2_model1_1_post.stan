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

parameters{
    array[2] real dad_ns_coef;
    array[2] real dad_fp_coef;
    array[2] real dad_sp_coef;
    array[2] real dad_tp_coef;
    array[2] real dad_val_coef;


    array[2] real mum_ns_coef;
    array[2] real mum_fp_coef;
    array[2] real mum_sp_coef;
    array[2] real mum_tp_coef;
    array[2] real mum_val_coef;
    array[2] real alpha;
    array[2] real sigma;
}

transformed parameters{
vector[N] mu;
    
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
}

model {

   dad_ns_coef[1] ~normal(0,0.3);
   dad_fp_coef[1] ~normal(0,0.3);
   dad_sp_coef[1] ~normal(0,0.3);
   dad_tp_coef[1] ~normal(0,0.3);
   dad_val_coef[1] ~normal(0,0.3);

   mum_ns_coef[1] ~normal(0,0.3);
   mum_fp_coef[1] ~normal(0,0.3);
   mum_sp_coef[1] ~normal(0,0.3);
   mum_tp_coef[1] ~normal(0,0.3);
   mum_val_coef[1] ~normal(0,0.3);

   dad_ns_coef[2] ~normal(0,0.3);
   dad_fp_coef[2] ~normal(0,0.3);
   dad_sp_coef[2] ~normal(0,0.3);
   dad_tp_coef[2] ~normal(0,0.3);
   dad_val_coef[2] ~normal(0,0.3);

   mum_ns_coef[2] ~normal(0,0.3);
   mum_fp_coef[2] ~normal(0,0.3);
   mum_sp_coef[2] ~normal(0,0.3);
   mum_tp_coef[2] ~normal(0,0.3);
   mum_val_coef[2] ~normal(0,0.3);

   alpha ~ normal(0.003, 0.001);
   sigma  ~ exponential(0.1);
    for (k in 1:N){
        output ~ lognormal(mu[k],sigma);
    }
}

generated quantities {
    array[N] real output_pred;
    array[N] real log_likelyhood;
    for (n in 1:N)
    {   
        log_likelyhood[n] = lognormal_lpdf(output[n] | mu[n], sigma);
        output_pred[n] = lognormal_rng(mu[n],sigma);
    }
}
