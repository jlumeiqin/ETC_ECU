#include	<string.h>
#include	<math.h>
#include	<time.h>
#include   "typedefine.h"
d_s_rand_result randac();
d_t_fit_result fitness(d_t_state x[2],d_t_G G[2],d_t_result b[4]);
d_t_fit_min pso(d_t_G G[2],d_t_result b[4]);
d_t_fit_min mpc_pso(d_t_in2 dx1_in,d_t_in1 dx2_in,d_t_in1 y_in,d_t_in1 u_in,d_t_in1 ref_in);
d_t_in2 input_dx1(d_t_in1 y);
d_t_in1 input_dx2(d_t_in2 dx1);
d_t_in1 Compult(d_t_in2 y_in,d_t_in1 ref_in);
