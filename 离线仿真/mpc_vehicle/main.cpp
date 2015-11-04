#include <iostream>
using namespace std;

#include "get_input.h"
#include "mpc.h"


void main()
{

	//double txt_belta[txt_size];
	//double txt_r[txt_size];
	double txt_y[txt_size];
	//double txt_u[txt_size];
	double txt_ref[txt_size];
	double txt_u_vc[txt_size]={0.0};
	get_input(txt_y,txt_ref);
	//printf("txt_belta[%d]=%2.15lf\n",3,txt_belta[3]);
	//double txt_UU[txt_size][2]={0.0};
	//get_input_pso(txt_G,txt_b);
		 //   for(int i=0;i<0.5*(txt_size-1);i++)
			//printf("txt_belta[%d]=%2.15lf\n",i,txt_belta[i]);
	for (int i = 0; i<2; i++)
		{
			//printf("txt_y[ %d]=%2.15lf\n",i,txt_y[i]);
            //if(i==999)
			//printf("y_in[%d]=%2.15lf\n",i,txt_y[i]);
		   // printf("r_in[%d]=%2.15lf\n",i,txt_ref[i]);
		
			txt_u_vc[i]=Compult(txt_y[i],txt_ref[i]);
			printf("txt_u[%d]=%2.15lf\n",i,txt_u_vc[i]);
			//printf("txt_UU[999]=%lf\n",txt_UU[999]);

		}
      // printf("txt_u[999]=%2.15lf\n",txt_u[999]);
	 //		for (int i=0;i<txt_size;i++)
		//{
		//	
		//	pso(txt_G[i],txt_b[i], txt_UU[i]);
		//	//printf("txt_UU[999]=%lf\n",txt_UU[999]);

		//}
	/*	double u[2];
     pso(txt_G[999],txt_b[999], u);
	 for(int i=0;i<2;i++)
	 {
	 printf("u[%d]=%lf\n",i,u[i]);
	 printf("txt_G[999][%d]=%lf\n",i,txt_G[999][i]);
	 }*/
	//write_result_u_c(txt_u_vc);
	//write_result_UU(txt_UU);

	//double txt_randac[txt_size];
	//for (int i=0;i<txt_size;i++)
	//{
	//txt_randac[i]=randac();
	//}
	//write_result_randac(txt_randac);


}