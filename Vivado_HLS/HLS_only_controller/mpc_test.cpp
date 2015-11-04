#include <iostream>
using namespace std;
//#include <mc_scverify.h>
#include "mpc.h"
//#include "typedefine.h"
//#include "math\mgc_ac_math.h"
//#include "math\mgc_ac_trig.h"

static const int txt_size = 1001;
void get_input(double y[txt_size],double ref[txt_size])
{		//y
		FILE *fp_y;

		if(fp_y= fopen("E:\\OpenHW_ECU\\HLS\\y.txt","r")) //以只读方式打开文本文档
			puts("打开文件成功");
	    else
			puts("打开文件失败");

		for(int i  = 0;i < txt_size;i++)
			fscanf(fp_y,"%lf" ,&y[i]);  //two data

		fclose(fp_y);

		//ref
		FILE *fp_ref;

		if(fp_ref= fopen("E:\\OpenHW_ECU\\HLS\\ref.txt","r")) //以只读方式打开文本文档
			puts("打开文件成功");
	    else
			puts("打开文件失败");

		for(int i  = 0;i < txt_size;i++)
			fscanf(fp_ref,"%lf" ,&ref[i]);  //two data

		fclose(fp_ref);
}



void write_result_u_c(double u_c[txt_size])
{
	//u
	FILE *fp_u_c;
	if(fp_u_c = fopen("E:\\OpenHW_ECU\\HLS\\u_c_verilog.txt","a+"))  //以追加的方式打开文本文档，文档可不存在，写入时保留原有内容，新内容写入文件尾;
		puts("打开文件成功");
	else
		puts("打开文件失败");

	for(int i  = 0;i < txt_size;i++)
			fprintf(fp_u_c,"%lf\n",u_c[i]);
	fclose(fp_u_c);

}



int main()
{
			//获取当前时刻的激励

	double txt_r[txt_size];
	double txt_y[txt_size];
	double txt_u_vc[txt_size]={0.0};
	d_t_in2 y_in=0;
	d_t_in1 r_in=0;
	d_t_in1 u_vc_fixed[txt_size]={0};
	get_input(txt_y,txt_r);
	//printf("txt_belta[%d]=%2.15lf\n",3,txt_belta[3]);
		for (int i=0;i<txt_size;i++)
		{

		y_in=(d_t_in2)txt_y[i];
		r_in=(d_t_in1)txt_r[i];
		//printf("y_in[%d]=%2.15lf\n",i,y_in.to_double());
		//printf("r_in[%d]=%2.15lf\n",i,r_in.to_double());
		u_vc_fixed[i]=Compult(y_in,r_in);
			//printf("txt_UU[999]=%lf\n",txt_UU[999]);
		txt_u_vc[i] = u_vc_fixed[i].to_double();
		//txt_u_vc[i] /= 30000;
		printf("txt_u[%d]=%2.15lf\n",i,txt_u_vc[i]);
		//cout<<"the"<<i<<"txt_u_vc is"<<txt_u_vc<<endl;
		}
      // printf("txt_u[999]=%2.15lf\n",txt_u[999]);
	 //		for (int i=0;i<txt_size;i++)
		//{
		//i
		//	pso(txt_G[i],txt_b[i], txt_UU[i]);
		//	//printf("txt_UU[999]=%lf\n",txt_UU[999]);

		//}
  write_result_u_c(txt_u_vc);
	//write_result_UU(txt_UU);

	/*double txt_randac[txt_size];
	for (int i=0;i<txt_size;i++)
	{
	txt_randac[i]=randac().to_double();
	}
	write_result_randac(txt_randac);*/

return 0;
}
