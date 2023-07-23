

data{
    int N; // no of samples
    
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
    vector[N] output;
}
parameters{
    real dad_ns_coef;
    real dad_fp_coef;
    real dad_sp_coef;
    real dad_tp_coef;
    real dad_val_coef;


    real mum_ns_coef;
    real mum_fp_coef;
    real mum_sp_coef;
    real mum_tp_coef;
    real mum_val_coef;
    real alpha;
    real sigma;

}


transformed parameters{
vector[N] mu;
    
for(i in 1:N){
        mu[i] = (dad_ns_coef*dad_ns[i] +
                dad_fp_coef*dad_fp[i] +
                dad_sp_coef*dad_sp[i] +
                dad_tp_coef*dad_tp[i] +
                dad_val_coef*dad_val[i] +
                mum_ns_coef*mum_ns[i] + 
                mum_fp_coef*mum_fp[i] +
                mum_sp_coef*mum_sp[i]+
                mum_tp_coef*mum_tp[i] +
                mum_val_coef*mum_val[i]+alpha);
        }    
}

model {

   dad_ns_coef ~normal(0,0.3);
   dad_fp_coef ~normal(0,0.3);
   dad_sp_coef ~normal(0,0.3);
   dad_tp_coef ~normal(0,0.3);
   dad_val_coef ~normal(0,0.3);

   mum_ns_coef ~normal(0,0.3);
   mum_fp_coef ~normal(0,0.3);
   mum_sp_coef ~normal(0,0.3);
   mum_tp_coef ~normal(0,0.3);
   mum_val_coef ~normal(0,0.3);

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
