/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif



static void Gate_35_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;

LAB0:    t1 = (t0 + 7464U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 1344U);
    t3 = *((char **)t2);
    t2 = (t0 + 1504U);
    t4 = *((char **)t2);
    t2 = (t0 + 1664U);
    t5 = *((char **)t2);
    t2 = (t0 + 1824U);
    t6 = *((char **)t2);
    t2 = (t0 + 1984U);
    t7 = *((char **)t2);
    t2 = (t0 + 2144U);
    t8 = *((char **)t2);
    t2 = (t0 + 2304U);
    t9 = *((char **)t2);
    t2 = (t0 + 2464U);
    t10 = *((char **)t2);
    t2 = (t0 + 2624U);
    t11 = *((char **)t2);
    t2 = (t0 + 2784U);
    t12 = *((char **)t2);
    t2 = (t0 + 2944U);
    t13 = *((char **)t2);
    t2 = (t0 + 3104U);
    t14 = *((char **)t2);
    t2 = (t0 + 3264U);
    t15 = *((char **)t2);
    t2 = (t0 + 3424U);
    t16 = *((char **)t2);
    t2 = (t0 + 3584U);
    t17 = *((char **)t2);
    t2 = (t0 + 3744U);
    t18 = *((char **)t2);
    t2 = (t0 + 3904U);
    t19 = *((char **)t2);
    t2 = (t0 + 4064U);
    t20 = *((char **)t2);
    t2 = (t0 + 4224U);
    t21 = *((char **)t2);
    t2 = (t0 + 4384U);
    t22 = *((char **)t2);
    t2 = (t0 + 4544U);
    t23 = *((char **)t2);
    t2 = (t0 + 4704U);
    t24 = *((char **)t2);
    t2 = (t0 + 4864U);
    t25 = *((char **)t2);
    t2 = (t0 + 5024U);
    t26 = *((char **)t2);
    t2 = (t0 + 5184U);
    t27 = *((char **)t2);
    t2 = (t0 + 5344U);
    t28 = *((char **)t2);
    t2 = (t0 + 5504U);
    t29 = *((char **)t2);
    t2 = (t0 + 5664U);
    t30 = *((char **)t2);
    t2 = (t0 + 5824U);
    t31 = *((char **)t2);
    t2 = (t0 + 5984U);
    t32 = *((char **)t2);
    t2 = (t0 + 6144U);
    t33 = *((char **)t2);
    t2 = (t0 + 6304U);
    t34 = *((char **)t2);
    t2 = (t0 + 7864);
    t35 = (t2 + 56U);
    t36 = *((char **)t35);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    xsi_vlog_OrGate(t38, 32, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, t17, t18, t19, t20, t21, t22, t23, t24, t25, t26, t27, t28, t29, t30, t31, t32, t33, t34);
    t39 = (t0 + 7864);
    xsi_driver_vfirst_trans(t39, 0, 0);
    t40 = (t0 + 7784);
    *((int *)t40) = 1;

LAB1:    return;
}


extern void simprims_ver_m_00000000001606816916_0473216920_init()
{
	static char *pe[] = {(void *)Gate_35_0};
	xsi_register_didat("simprims_ver_m_00000000001606816916_0473216920", "isim/test1_isim_fit.exe.sim/simprims_ver/m_00000000001606816916_0473216920.didat");
	xsi_register_executes(pe);
}
