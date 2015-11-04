
#include	<string.h>
#include	<math.h>
#include	<time.h>
double randac();
double fitness(double x[2],double G[2],double b[4]);
double pso(double G[2],double b[4]);	
double mpc_pso(double belta,double r,double y,double u,double ref);
double input_dx1(double y);
double input_dx2(double dx1);
double Compult(double y_in,double ref_in);