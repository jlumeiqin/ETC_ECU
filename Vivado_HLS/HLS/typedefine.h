#if !defined(_TYPE_DEFINE_H)
#define _TYPE_DEFINE_H
#include "ap_fixed.h"
/*#include "ac_fixed.h"
#include "math\mgc_ac_math.h"
#include "math\mgc_ac_trig.h"

typedef ac_fixed<16,16,true> d_s_input;
typedef ac_fixed<50,20,true> d_t_state;
typedef ac_fixed<40,20,true> d_t_result;
typedef ac_fixed<30,3,true> d_t_in1;
typedef ac_fixed<40,3,true> d_t_in2;
typedef ac_fixed<40,10,true> d_t_H;
typedef ac_fixed<40,11,true> d_t_G;
typedef ac_fixed<30,1,true> d_t_rand;
typedef ac_fixed<6,6,false> d_s_rand_a;
//typedef ac_fixed<19,19,false> d_s_rand_seed;
typedef ac_fixed<30,25,false> d_s_rand_seed;
typedef ac_fixed<20,0,false> d_s_rand_result;
typedef ac_fixed<40,24,false> d_s_rand_i;*/

typedef ap_fixed<12,12,AP_RND_CONV,AP_SAT> d_s_input;
typedef ap_fixed<16,16,AP_RND_CONV,AP_SAT> d_s_output;
typedef ap_fixed<36,20,AP_RND_CONV,AP_SAT> d_t_state;
//typedef ap_fixed<32,16,AP_RND_CONV,AP_SAT> d_t_state;
typedef ap_fixed<32,16,AP_RND_CONV,AP_SAT> d_t_result;
typedef ap_fixed<32,5,AP_RND_CONV,AP_SAT> d_t_b;
typedef ap_fixed<30,3,AP_RND_CONV,AP_SAT> d_t_in1;
typedef ap_fixed<32,3,AP_RND_CONV,AP_SAT> d_t_in2;
typedef ap_fixed<32,5,AP_RND_CONV,AP_SAT> d_t_in3;
typedef ap_ufixed<18,8,AP_RND_CONV,AP_SAT> d_t_H;
typedef ap_fixed<28,11,AP_RND_CONV,AP_SAT> d_t_G;
typedef ap_fixed<30,1,AP_RND_CONV,AP_SAT> d_t_rand;
typedef ap_fixed<7,7,AP_RND_CONV,AP_SAT> d_s_rand_a;
//typedef ac_fixed<19,19,false> d_s_rand_seed;
typedef ap_fixed<31,26,AP_RND_CONV,AP_SAT> d_s_rand_seed;
typedef ap_fixed<20,1,AP_RND_CONV,AP_SAT> d_s_rand_result;
typedef ap_fixed<41,25,AP_RND_CONV,AP_SAT> d_s_rand_i;


typedef ap_fixed<23,3,AP_RND_CONV,AP_SAT> d_t_aa;
typedef ap_fixed<29,2,AP_RND_CONV,AP_SAT> d_t_Cx;
typedef ap_fixed<27,2,AP_RND_CONV,AP_SAT> d_t_fit_min;
typedef ap_fixed<32,16,AP_RND_CONV,AP_SAT> d_t_fit_result;
typedef ap_fixed<31,13,AP_RND_CONV,AP_SAT> d_t_fit_Gx;
typedef ap_ufixed<16,1,AP_RND_CONV,AP_SAT> d_t_y;
typedef ap_ufixed<16,1,AP_RND_CONV,AP_SAT> d_t_ref;

typedef ap_fixed<29,3,AP_RND_CONV,AP_SAT> d_t_fit_x;
#endif
