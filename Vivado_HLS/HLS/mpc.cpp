#include    "mpc.h"
#include	<string.h>
#include	<math.h>
#include    "typedefine.h"
#include    "stdlib.h"


d_s_rand_result randac()
{
	//********************种子初始，static声明，与全局变量一样
	static d_s_rand_seed seed = 9;
	//********************常数赋值
	const d_s_rand_seed  m = 1048576;
	const d_s_rand_a a = 45;    //随机数很有随机性，容易导致个别点突变，根据结果调整

	d_s_rand_i i2;
	d_s_rand_result result;

	//********************迭代公式
	i2 = ((a* seed).to_int())%(m.to_int());

	//********************更新种子
	seed = i2.to_int();

	//********************除以模值，获得随机数
	result=i2>>20;
	return result;
}
/*写控制 ——aa*/
//void write_result_aa(double aa)
//{
//	//u
//	FILE *fp_aa;
//	if(fp_aa = fopen("C:\\Users\\Administrator\\Desktop\\HLS\\aa.txt","a+"))  //以追加的方式打开文本文档，文档可不存在，写入时保留原有内容，新内容写入文件尾;
//		puts("打开文件成功");
//	else
//		puts("打开文件失败");
//
//			fprintf(fp_aa,"%lf\n",aa);
//	fclose(fp_aa);
//
//}
//void write_result_bb(double bb)
//{
//	//u
//	FILE *fp_bb;
//	if(fp_bb = fopen("C:\\Users\\Administrator\\Desktop\\HLS\\bb.txt","a+"))  //以追加的方式打开文本文档，文档可不存在，写入时保留原有内容，新内容写入文件尾;
//		puts("打开文件成功");
//	else
//		puts("打开文件失败");
//
//			fprintf(fp_bb,"%lf\n",bb);
//	fclose(fp_bb);
//
//}


d_t_fit_result fitness(d_t_fit_x x[2],d_t_G G[2],d_t_b b[4])
{
    d_t_H H[2][2]={     231.5891983880240,   210.4915536015400,  210.4915536015399,   225.4663393899590};
    ap_fixed<2,2,AP_RND_CONV,AP_SAT> c[4][2]={-1,0,0,-1,1,0,0,1};
	d_t_aa aa[4]={0.0,0.0,0.0,0.0};
	d_t_Cx Cx[4]={0.0,0.0,0.0,0.0};
	d_t_fit_result result=0;
    int i;
    d_t_Cx sum=0;
    int k;
    d_t_fit_result xH[2]={0.0,0.0};
    d_t_fit_result xHx=0.0;
    d_t_fit_Gx Gx=0.0;

	fitness_label1:for( i=0;i<4;i++)
	{
        int j;
		fitness_label2:for( j=0;j<2;j++)
		{
			Cx[i]+=c[i][j]*x[j];
		}
		aa[i]=Cx[i]-b[i];
		//printf("Cx[%d]=%2.15lf\n",i,Cx[i].to_double());
		//write_result_aa(aa[i].to_double());
	}

	fitness_label5:for ( k=0;k<4;k++)
	{
		d_t_fit_min min[4];
    if(aa[k]<=0)
		min[k]=aa[k];
	else
		min[k]=0;
    //write_result_aa(min[k].to_double());
	sum+=min[k]*min[k];
	}

// 		for(i = 0; i <2;i++)
// 	{
// 		xH[i] = 0;
// 	}

	fitness_label4:for(i=0;i<2;i++)
    {
        int j;
        for( j=0;j<2;j++)
		{
		xH[i]+=((d_t_rand)0.5)*x[j]*H[j][i];
		//write_result_aa(xH[i].to_double());
		}
    }

	fitness_label7:for( i=0;i<2;i++)
		{
		xHx+=xH[i]*x[i];
		Gx+=(-1)*G[i]*x[i];
		//write_result_aa(xHx.to_double());
		//write_result_bb(Gx.to_double());
		}
    result=xHx+Gx+((ap_fixed<16,14,AP_RND_CONV,AP_SAT>)5000)*sum;
    //printf("result=%2.15lf\n",result.to_double());
   //write_result_aa(sum.to_double());
	return result;
}

d_t_fit_min pso(d_t_G G[2],d_t_b b[4])
{
	      d_t_fit_min UU[2];
	      ap_fixed<20,2,AP_RND_CONV,AP_SAT> c1=1.4962;            //学习因子1
          ap_fixed<20,2,AP_RND_CONV,AP_SAT> c2=1.4962;             //学习因子2
          ap_fixed<20,2,AP_RND_CONV,AP_SAT> w=0.0;
          ap_fixed<20,2,AP_RND_CONV,AP_SAT> ww[20]={0.77,0.74,0.71,0.68,0.65,0.62,0.59,0.56,0.53,0.50,
        		                                   0.47,0.44,0.41,0.38,0.35,0.32,0.29,0.26,0.23,0.20
                                                   };

	const ap_fixed<6,6,AP_RND_CONV,AP_SAT>  MaxDT=20;            //最大迭代次数20
	const ap_fixed<3,3,AP_RND_CONV,AP_SAT> D=2;                  //搜索空间维数（未知数个数）
	const ap_fixed<6,6,AP_RND_CONV,AP_SAT> N=20;                  //%初始化群体个体数目
	//double eps=0.000001;             //%设置精度(在已知最小值时候用)
	d_t_fit_x x[20][2];
	d_t_fit_x y[20][2];
    ap_fixed<30,2,AP_RND_CONV,AP_SAT> v[20][2];
    d_t_fit_result p[20]={0.0};
    d_t_fit_x pg[2];
    d_s_rand_result randac1=0.0;
    d_s_rand_result randac2=0.0;
    int t;
	//%------初始化种群的个体(可以在这里限定位置和速度的范围)------------
    ap_fixed<20,2,AP_RND_CONV,AP_SAT> r=0.1;
    int i;
    int j;
	pso_label8:for ( i=0;i<N;i++)
	{
       	pso_label9:for ( j=0;j<D;j++)
		{
			x[i][j]=((d_t_rand)0.001)*randac();  //%随机初始化位置
			//v[i][j]=0*randac();  //%随机初始化速度
			//write_result_aa(x[i][j].to_double());
			v[i][j]=0;  //%随机初始化速度
		}
	}

	//%------先计算各个粒子的适应度，并初始化Pi和Pg----------------------
	pso_label2:for ( i=0;i<N;i++)

	{
        p[i]=fitness(x[i],G,b);
		//printf("p[%d]=%lf\n",i,p[i].to_double());
		pso_label7:for(j=0;j<D;j++)
		{
		y[i][j]=x[i][j];
		}
	}

		pso_label6:for( j=0;j<D;j++)
	{
		pg[j]=x[0][j];//%Pg为全局最优
	}

	pso_label1:for (i=1;i<N;i++)

	{
		if (fitness(x[i],G,b)<fitness(pg,G,b))
			pso_label11:for(j=0;j<D;j++)
			{
			pg[j]=x[i][j];
			//printf("pg[%d]=%lf\n",j,pg[j].to_double());
			}
	}

	//%------进入主要循环，按照公式依次迭代，直到满足精度要求------------
   	for ( t=0;t<MaxDT;t++)
	{
        int k;
        //w=(( ap_fixed<31,2,AP_RND_CONV,AP_SAT>)0.8)-((d_t_rand)0.6)*(t+1)/MaxDT;//可以修改
        w=ww[t];
		//printf("w=%lf\n",w.to_double());
		for(i=0;i<N;i++)
		{
            randac1=randac();
            randac2=randac();
			//printf("randac1=%lf\n",randac1.to_double());
			//printf("randac2=%lf\n",randac2.to_double());
			pso_label13:for( j=0;j<D;j++)
		    {
                v[i][j]=w*v[i][j]+1*c1*randac1*(y[i][j]-x[i][j])+1*c2*randac2*(pg[j]-x[i][j]);
                x[i][j]=x[i][j]+v[i][j];
                //write_result_aa(x[i][j].to_double());
				/*if(j==D-1)
				{
					printf("x[%d][%d]=%lf\n",i,j,x[i][j].to_double());
				}
				else
				{
					printf("x[%d][%d]=%lf\n",i,j,x[i][j].to_double());
				}*/
			}

			pso_label16:for ( k=0;k<D;k++)
			{
			if  (x[i][k]>1)
				{
					x[i][k]=1;
				}
			if (x[i][k]<-1)
				{
					x[i][k]=-1;
				}
			}
			if (fitness(x[i],G,b)<p[i])
			{
				p[i]=fitness(x[i],G,b);

				pso_label15:for( j=0;j<D;j++)
				{
					y[i][j]=x[i][j];
				}
			}
			if (p[i]<fitness(pg,G,b))
			{
				pso_label14:for( j=0;j<D;j++)
				{
					pg[j]=y[i][j];
					//printf("pg[%d]=%lf\n",j,pg[j].to_double());
				}
			}

		}

	}
	pso_label10:for(i=0;i<D;i++)
	{
	    UU[i]=pg[i];
	    //write_result_aa(UU[i].to_double());
	}
    return UU[0];
}

d_t_fit_min mpc_pso(d_t_in2 dx1_in,d_t_in1 dx2_in,d_t_in1 y_in,d_t_in1 u_in,d_t_in1 ref_in)
{

	d_t_fit_min duu;
	ap_fixed<30,6,AP_RND_CONV,AP_SAT> Sx[20][2]={0.999999887494521,   0.000980908441683,
								   1.999999443182048,   0.002905510919606,
								   2.999998456081107,   0.005738004675732,
								   3.999996723214666,   0.009443945051661,
								   4.999994049306499,   0.013990193972083,
								   5.999990246489080,   0.019344870382393,
								   6.999985134022543,   0.025477302566354,
								   7.999978538024314,   0.032357982272474,
								   8.999970291208991,   0.039958520580513,
								   9.999960232638099,   0.048251605442091,
								  10.999948207479330,   0.057210960831894,
								  11.999934066774919,   0.066811307448406,
								  12.999917667218810,   0.077028324905356,
								  13.999898870942264,   0.087838615357362,
								  14.999877545307610,   0.099219668505353,
								  15.999853562709818,   0.111149827929432,
								  16.999826800385591,   0.123608258698829,
								  17.999797140229713,   0.136574916210506,
								  18.999764468618345,   0.150030516209793,
								  19.999728676239037,   0.163956505948230};

	ap_fixed<30,8,AP_RND_CONV,AP_SAT> g[2][20]={ 0.295173465193610,	1.16571436196475,	2.58979392352947,	4.54641140982271,	7.01536269810910,	9.97721006504063,	13.4132531149660,	17.3055008110112,	21.6366445671002,	26.3900323606712,	31.5496438273702,	37.1000663004737,	43.0264717592035,	49.3145946514563,	55.9507105577808,	62.9216156646895,	70.2146070166061,	77.8174635169120,	85.7184276496769,	93.9061878947356,
								   0,                	0.295173465193610,	1.71925302675833,	3.67587051305157,	6.14482180133796,	9.10666916826949,	12.5427122181949,	16.4349599142401,	20.7661036703291,	25.5194914639001,	30.6791029305990,	36.2295254037026,	42.1559308624323,	48.4440537546851,	55.0801696610096,	62.0510747679183,	69.3440661198349,	76.9469226201408,	84.8478867529057,	93.0356469979644};
	//double g[2][20];
    int i;
    int j;
    ap_fixed<20,2,AP_RND_CONV,AP_SAT> Umax=0.8;
    ap_fixed<20,2,AP_RND_CONV,AP_SAT> Umin=-0.8;
	d_t_state SxDx[20];
	d_t_b  b[4];
	d_t_G      G[2];
    d_t_state  Ep[20];
   // double UU[2]={0.0,0.0};

	b[0]=u_in - Umax;
	b[1]=u_in - Umax;
	b[2]=Umin-u_in ;
	b[3]=Umin-u_in ;
	//printf("b[0]=%lf\n",b[0].to_double());
	//printf("b[2]=%lf\n",b[2].to_double());


	mpc_pso_label3:for( i=0;i<20;i++)
	{
		SxDx[i]=Sx[i][0]*dx1_in+Sx[i][1]*dx2_in;
		//printf("SxDx[%d]=%lf\n",i,SxDx[i].to_double());
	}
	mpc_pso_label11:for( i=0;i<20;i++)
	{
		Ep[i]=ref_in-SxDx[i]-y_in;
	}
	for(i=0;i<2;i++)
	{
		d_t_state sum=0.0;
		for(j=0;j<20;j++)
		sum+=g[i][j]*Ep[j];
		//G[i]=10000000000*sum;
		G[i]=sum;
		//printf("G[%d]=%lf\n",i,G[i].to_double());
	}

	duu=pso(G,b);
	//write_result_aa(duu.to_double());
	//duu=duu+u_in;
	//printf("duu=%lf\n",duu.to_double());
	return duu;

}

d_t_in2 input_dx1(d_t_in1 y)
{
	static d_t_in1 x1=0;
	static d_t_in1 x1_1=0;
	d_t_in1 dx1;

	x1=y;
	dx1=x1-x1_1;
	x1_1=x1;
	//printf("dx1=%lf\n",dx1.to_double());
	return dx1;
}
d_t_in1 input_dx2(d_t_in2 dx1)
{
	static d_t_in3 x2=0;
	static d_t_in3 x2_2=0;
	d_t_in1 dx2;
	const ap_fixed<10,10,AP_RND_CONV,AP_SAT> ts=500;

	x2=dx1*ts;
	//printf("x2=%lf\n",x2.to_double());
	//printf("x2_2=%lf\n",x2_2.to_double());
	dx2=x2-x2_2;
	x2_2=x2;
	//printf("x2_2=%lf\n",x2_2.to_double());

	//printf("dx2=%lf\n",dx2.to_double());
	return dx2;
}

d_t_in1 Compult(d_t_y y_in,d_t_ref ref_in)
{
	d_t_y y;
	d_t_ref ref;
	d_t_in2 dx1;
	d_t_in1 dx2;
	d_t_in1 du;
	const ap_ufixed<20,1,AP_RND_CONV,AP_SAT> factor_ry= 0.9;
	d_s_output u_out;
	y=y_in*factor_ry;
	ref=ref_in*factor_ry;
	static d_t_in1 u=0;
	ap_fixed<26,16,AP_RND_CONV,AP_SAT> my_factor_u= 30000;

	dx1=input_dx1(y);
	dx2=input_dx2(dx1);


	du=mpc_pso(dx1,dx2,y,u,ref);
	u=u+du;
	u_out=u*my_factor_u;
	return u_out;

}
