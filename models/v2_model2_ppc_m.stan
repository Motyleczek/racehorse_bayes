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
}

generated quantities {

   real dad_ns_coef = normal_rng(0,0.3);
   real dad_fp_coef = normal_rng(0,0.3);
   real dad_sp_coef = normal_rng(0,0.3);
   real dad_tp_coef = normal_rng(0,0.3);
   real dad_val_coef = normal_rng(0,0.3);

   real mum_ns_coef = normal_rng(0,0.3);
   real mum_fp_coef = normal_rng(0,0.3);
   real mum_sp_coef = normal_rng(0,0.3);
   real mum_tp_coef = normal_rng(0,0.3);
   real mum_val_coef = normal_rng(0,0.3);

   real alpha = normal_rng(0.003, 0.001);


    vector[N] mu;
    real sigma = fabs(normal_rng(0.1, 0.03));
    array[N] real<lower=0> output;
   
      mu = 0.4*(dad_ns_coef*dad_ns +
                dad_fp_coef*dad_fp +
                dad_sp_coef*dad_sp +
                dad_tp_coef*dad_tp +
                dad_val_coef*dad_val +
                mum_ns_coef*mum_ns + 
                mum_fp_coef*mum_fp +
                mum_sp_coef*mum_sp+
                mum_tp_coef*mum_tp +
                mum_val_coef*mum_val)+alpha;

     output = fabs(normal_rng(mu,sigma));
}