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



static void Gate_29_0(char *t0)
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

LAB0:    t1 = (t0 + 3464U);
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
    t2 = (t0 + 3864);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    xsi_vlog_AndGate(t13, 7, t3, t4, t5, t6, t7, t8, t9);
    t14 = (t0 + 3864);
    xsi_driver_vfirst_trans(t14, 0, 0);
    t15 = (t0 + 3784);
    *((int *)t15) = 1;

LAB1:    return;
}


extern void simprims_ver_m_00000000002895147581_4190339329_init()
{
	static char *pe[] = {(void *)Gate_29_0};
	xsi_register_didat("simprims_ver_m_00000000002895147581_4190339329", "isim/test1_isim_fit.exe.sim/simprims_ver/m_00000000002895147581_4190339329.didat");
	xsi_register_executes(pe);
}
