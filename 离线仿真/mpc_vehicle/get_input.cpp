
#include <iostream>
using namespace std;

#include "get_input.h"


void get_input(double y[txt_size],double ref[txt_size])
{

				//y
		FILE *fp_y;

		if(fp_y= fopen("F:\\OpenHW_ECU\\HLS\\y_14.txt","r")) //以只读方式打开文本文档
			puts("打开文件成功");
	    else
			puts("打开文件失败");

		for(int i  = 0;i < txt_size;i++)
			fscanf(fp_y,"%lf" ,&y[i]);  //two data

		fclose(fp_y);
		
		//ref
		FILE *fp_ref;

		if(fp_ref= fopen("F:\\OpenHW_ECU\\HLS\\ref_14.txt","r")) //以只读方式打开文本文档
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
	if(fp_u_c = fopen("F:\\OpenHW_ECU\\HLS\\u_c14_2.txt","a+"))  //以追加的方式打开文本文档，文档可不存在，写入时保留原有内容，新内容写入文件尾;
		puts("打开文件成功");
	else
		puts("打开文件失败");

	for(int i  = 0;i < txt_size;i++)
			fprintf(fp_u_c,"%lf\n",u_c[i]);  
	fclose(fp_u_c);
	
}
