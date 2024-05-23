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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *VL_P_2533777724;
char *IEEE_P_2592010699;
char *STD_STANDARD;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000004134447467_2073120511_init();
    simprims_ver_m_00000000003359274523_2662658903_init();
    simprims_ver_m_00000000001255213976_2021654676_init();
    simprims_ver_u_00000000001790370653_1131516744_init();
    simprims_ver_m_00000000000452859522_3752318385_init();
    simprims_ver_m_00000000001255213976_3226743947_init();
    simprims_ver_m_00000000000126354981_0818475687_init();
    simprims_ver_m_00000000000126354981_1080494567_init();
    simprims_ver_m_00000000003690504506_1236628566_init();
    simprims_ver_m_00000000000237972898_3218428928_init();
    simprims_ver_m_00000000000648012491_3151998091_init();
    simprims_ver_m_00000000002872589513_3118641787_init();
    simprims_ver_m_00000000002872589513_2309584270_init();
    simprims_ver_m_00000000002231714667_4272833816_init();
    simprims_ver_m_00000000001606816916_2100456487_init();
    simprims_ver_m_00000000002872589513_1752281125_init();
    simprims_ver_m_00000000003378901902_1623904443_init();
    simprims_ver_m_00000000003402595666_0399368237_init();
    simprims_ver_m_00000000003468226314_0695144707_init();
    simprims_ver_m_00000000003378901902_2165445904_init();
    simprims_ver_m_00000000003468226314_1214892732_init();
    simprims_ver_u_00000000000017755009_3216321564_init();
    simprims_ver_m_00000000003963788642_2501315080_init();
    simprims_ver_m_00000000000452859522_3643135096_init();
    simprims_ver_m_00000000000710743255_2395255191_init();
    simprims_ver_m_00000000001606816916_0473216920_init();
    simprims_ver_m_00000000002895147581_4190339329_init();
    simprims_ver_m_00000000003402595666_4128580998_init();
    simprims_ver_m_00000000002787266980_1769774224_init();
    simprims_ver_m_00000000002787266980_2292472123_init();
    simprims_ver_m_00000000000710743255_1864135740_init();
    work_m_00000000001743234068_4040393109_init();
    ieee_p_2592010699_init();
    vl_p_2533777724_init();
    work_a_2221974671_2372691052_init();


    xsi_register_tops("work_a_2221974671_2372691052");
    xsi_register_tops("work_m_00000000004134447467_2073120511");

    VL_P_2533777724 = xsi_get_engine_memory("vl_p_2533777724");
    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");

    return xsi_run_simulation(argc, argv);

}
