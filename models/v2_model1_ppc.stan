generated quantities {
   /* ... declarations ... statements ... */
   // dad
   real dad_ns = normal_rng(0,1);
   real dad_fp = normal_rng(0,1);
   real dad_sp = normal_rng(0,1);
   real dad_tp = normal_rng(0,1);
   real dad_val = normal_rng(0,1);
   // dad coefs
   real dad_ns_coef = normal_rng(0.9, 0.3);
   real dad_fp_coef = normal_rng(1, 0.33);
   real dad_sp_coef = normal_rng(0.7, 0.23);
   real dad_tp_coef = normal_rng(0.7, 0.23);
   real dad_val_coef = normal_rng(0.5, 0.16);

   // mum
   real mum_ns = normal_rng(0,1);
   real mum_fp = normal_rng(0,1);
   real mum_sp = normal_rng(0,1);
   real mum_tp = normal_rng(0,1);
   real mum_val = normal_rng(0,1);
   // mum coefs
   real mum_ns_coef = normal_rng(-0.3, 0.1);
   real mum_fp_coef = normal_rng(0.5, 0.33);
   real mum_sp_coef = normal_rng(0.35, 0.23);
   real mum_tp_coef = normal_rng(0.35, 0.23);
   real mum_val_coef = normal_rng(0.5, 0.16);

   // params
   real alpha = normal_rng(0.5, 0.16)

   real mu = dad_ns*dad_ns_coef +
            dad_fp*dad_fp_coef +
            dad_sp*dad_sp_coef +
            dad_tp*dad_tp_coef +
            dad_val*dad_val_coef +
            mum_ns*mum_ns_coef + 
            mum_fp*mum_fp_coef +
            mum_sp*mum_sp_coef +
            mum_tp*mum_tp_coef +
            mum_val*mum_val_coef + alpha;

    real nu = gamma_rng(0.5, 0.5);
    real sigma = exponential_rng(0.5);
    real output = student_t_rng(nu, mu, sigma);
}