

/*
 * Include Files
 *
 */
#if defined(MATLAB_MEX_FILE)
#include "tmwtypes.h"
#include "simstruc_types.h"
#else
#include "rtwtypes.h"
#endif

/* %%%-SFUNWIZ_wrapper_includes_Changes_BEGIN --- EDIT HERE TO _END */
#include <math.h>
#include <string.h>
#include <mpc.h>
/* %%%-SFUNWIZ_wrapper_includes_Changes_END --- EDIT HERE TO _BEGIN */
#define u_width 1
#define y_width 1
/*
 * Create external references here.  
 *
 */
/* %%%-SFUNWIZ_wrapper_externs_Changes_BEGIN --- EDIT HERE TO _END */
/* extern double func(double a); */
extern double randac();
extern double fitness(double x[2],double G[2],double b[4]);
extern double pso(double G[2],double b[4]);	
extern double mpc_pso(double belta,double r,double y,double u,double ref);
extern double input_dx1(double y);
extern double input_dx2(double dx1);
extern double Compult(double y_in,double ref_in);
/* %%%-SFUNWIZ_wrapper_externs_Changes_END --- EDIT HERE TO _BEGIN */

/*
 * Output functions
 *
 */
void controller_Outputs_wrapper(const real_T *dx1,
			const real_T *dx2,
			const real_T *y,
			const real_T *u,
			const real_T *r,
			real_T *du,
			real_T *dx1_com,
			real_T *dx2_com)
{
/* %%%-SFUNWIZ_wrapper_Outputs_Changes_BEGIN --- EDIT HERE TO _END */
/* This sample sets the output equal to the input
         y0[0] = u0[0];
For complex signals use: y0[0].re = u0[0].re;
                         y0[0].im = u0[0].im;
                         y1[0].re = u1[0].re;
                         y1[0].im = u1[0].im;*/
#include "mpc.h"
double txt_belta;
double txt_r;
double txt_y;
double txt_u;
double txt_ref;
double txt_u_vc;
//static double u=0;
txt_belta= dx1[0];
txt_r    = dx2[0];
txt_y    = y[0];
txt_u    = u[0];
txt_ref  = r[0];

//du[0]=mpc_pso(txt_belta,txt_r,txt_y,txt_u,txt_ref);
du[0]=Compult(txt_y,txt_ref);
//dx1_com[0]=input_dx1(txt_y);
//dx2_com[0]=input_dx2(dx1_com[0]);
// double txt_randac[txt_size];
// for (int i=0;i<txt_size;i++)
// {
// 	txt_randac[i]=randac();
// }
/* %%%-SFUNWIZ_wrapper_Outputs_Changes_END --- EDIT HERE TO _BEGIN */
}
