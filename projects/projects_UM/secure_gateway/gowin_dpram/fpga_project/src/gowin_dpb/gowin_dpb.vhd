--Copyright (C)2014-2024 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: IP file
--Tool Version: V1.9.9.02
--Part Number: GW1N-LV4LQ144C5/I4
--Device: GW1N-4
--Device Version: D
--Created Time: Tue May 14 14:39:43 2024

library IEEE;
use IEEE.std_logic_1164.all;

entity dp_ram is
    port (
        douta: out std_logic_vector(15 downto 0);
        doutb: out std_logic_vector(15 downto 0);
        clka: in std_logic;
        ocea: in std_logic;
        cea: in std_logic;
        reseta: in std_logic;
        wrea: in std_logic;
        clkb: in std_logic;
        oceb: in std_logic;
        ceb: in std_logic;
        resetb: in std_logic;
        wreb: in std_logic;
        ada: in std_logic_vector(13 downto 0);
        dina: in std_logic_vector(15 downto 0);
        adb: in std_logic_vector(13 downto 0);
        dinb: in std_logic_vector(15 downto 0)
    );
end dp_ram;

architecture Behavioral of dp_ram is

    signal dpb_inst_0_douta_w: std_logic_vector(13 downto 0);
    signal dpb_inst_0_douta: std_logic_vector(1 downto 0);
    signal dpb_inst_0_doutb_w: std_logic_vector(13 downto 0);
    signal dpb_inst_0_doutb: std_logic_vector(1 downto 0);
    signal dpb_inst_1_douta_w: std_logic_vector(13 downto 0);
    signal dpb_inst_1_douta: std_logic_vector(3 downto 2);
    signal dpb_inst_1_doutb_w: std_logic_vector(13 downto 0);
    signal dpb_inst_1_doutb: std_logic_vector(3 downto 2);
    signal dpb_inst_2_douta_w: std_logic_vector(13 downto 0);
    signal dpb_inst_2_douta: std_logic_vector(5 downto 4);
    signal dpb_inst_2_doutb_w: std_logic_vector(13 downto 0);
    signal dpb_inst_2_doutb: std_logic_vector(5 downto 4);
    signal dpb_inst_3_douta_w: std_logic_vector(13 downto 0);
    signal dpb_inst_3_douta: std_logic_vector(7 downto 6);
    signal dpb_inst_3_doutb_w: std_logic_vector(13 downto 0);
    signal dpb_inst_3_doutb: std_logic_vector(7 downto 6);
    signal dpb_inst_4_douta_w: std_logic_vector(7 downto 0);
    signal dpb_inst_4_douta: std_logic_vector(7 downto 0);
    signal dpb_inst_4_doutb_w: std_logic_vector(7 downto 0);
    signal dpb_inst_4_doutb: std_logic_vector(7 downto 0);
    signal dpb_inst_5_douta_w: std_logic_vector(13 downto 0);
    signal dpb_inst_5_douta: std_logic_vector(9 downto 8);
    signal dpb_inst_5_doutb_w: std_logic_vector(13 downto 0);
    signal dpb_inst_5_doutb: std_logic_vector(9 downto 8);
    signal dpb_inst_6_douta_w: std_logic_vector(13 downto 0);
    signal dpb_inst_6_douta: std_logic_vector(11 downto 10);
    signal dpb_inst_6_doutb_w: std_logic_vector(13 downto 0);
    signal dpb_inst_6_doutb: std_logic_vector(11 downto 10);
    signal dpb_inst_7_douta_w: std_logic_vector(13 downto 0);
    signal dpb_inst_7_douta: std_logic_vector(13 downto 12);
    signal dpb_inst_7_doutb_w: std_logic_vector(13 downto 0);
    signal dpb_inst_7_doutb: std_logic_vector(13 downto 12);
    signal dpb_inst_8_douta_w: std_logic_vector(13 downto 0);
    signal dpb_inst_8_douta: std_logic_vector(15 downto 14);
    signal dpb_inst_8_doutb_w: std_logic_vector(13 downto 0);
    signal dpb_inst_8_doutb: std_logic_vector(15 downto 14);
    signal dpb_inst_9_douta_w: std_logic_vector(7 downto 0);
    signal dpb_inst_9_douta: std_logic_vector(15 downto 8);
    signal dpb_inst_9_doutb_w: std_logic_vector(7 downto 0);
    signal dpb_inst_9_doutb: std_logic_vector(15 downto 8);
    signal dff_q_0: std_logic;
    signal dff_q_1: std_logic;
    signal cea_w: std_logic;
    signal ceb_w: std_logic;
    signal gw_gnd: std_logic;
    signal dpb_inst_0_BLKSELA_i: std_logic_vector(2 downto 0);
    signal dpb_inst_0_BLKSELB_i: std_logic_vector(2 downto 0);
    signal dpb_inst_0_ADA_i: std_logic_vector(13 downto 0);
    signal dpb_inst_0_DIA_i: std_logic_vector(15 downto 0);
    signal dpb_inst_0_ADB_i: std_logic_vector(13 downto 0);
    signal dpb_inst_0_DIB_i: std_logic_vector(15 downto 0);
    signal dpb_inst_0_DOA_o: std_logic_vector(15 downto 0);
    signal dpb_inst_0_DOB_o: std_logic_vector(15 downto 0);
    signal dpb_inst_1_BLKSELA_i: std_logic_vector(2 downto 0);
    signal dpb_inst_1_BLKSELB_i: std_logic_vector(2 downto 0);
    signal dpb_inst_1_ADA_i: std_logic_vector(13 downto 0);
    signal dpb_inst_1_DIA_i: std_logic_vector(15 downto 0);
    signal dpb_inst_1_ADB_i: std_logic_vector(13 downto 0);
    signal dpb_inst_1_DIB_i: std_logic_vector(15 downto 0);
    signal dpb_inst_1_DOA_o: std_logic_vector(15 downto 0);
    signal dpb_inst_1_DOB_o: std_logic_vector(15 downto 0);
    signal dpb_inst_2_BLKSELA_i: std_logic_vector(2 downto 0);
    signal dpb_inst_2_BLKSELB_i: std_logic_vector(2 downto 0);
    signal dpb_inst_2_ADA_i: std_logic_vector(13 downto 0);
    signal dpb_inst_2_DIA_i: std_logic_vector(15 downto 0);
    signal dpb_inst_2_ADB_i: std_logic_vector(13 downto 0);
    signal dpb_inst_2_DIB_i: std_logic_vector(15 downto 0);
    signal dpb_inst_2_DOA_o: std_logic_vector(15 downto 0);
    signal dpb_inst_2_DOB_o: std_logic_vector(15 downto 0);
    signal dpb_inst_3_BLKSELA_i: std_logic_vector(2 downto 0);
    signal dpb_inst_3_BLKSELB_i: std_logic_vector(2 downto 0);
    signal dpb_inst_3_ADA_i: std_logic_vector(13 downto 0);
    signal dpb_inst_3_DIA_i: std_logic_vector(15 downto 0);
    signal dpb_inst_3_ADB_i: std_logic_vector(13 downto 0);
    signal dpb_inst_3_DIB_i: std_logic_vector(15 downto 0);
    signal dpb_inst_3_DOA_o: std_logic_vector(15 downto 0);
    signal dpb_inst_3_DOB_o: std_logic_vector(15 downto 0);
    signal dpb_inst_4_BLKSELA_i: std_logic_vector(2 downto 0);
    signal dpb_inst_4_BLKSELB_i: std_logic_vector(2 downto 0);
    signal dpb_inst_4_ADA_i: std_logic_vector(13 downto 0);
    signal dpb_inst_4_DIA_i: std_logic_vector(15 downto 0);
    signal dpb_inst_4_ADB_i: std_logic_vector(13 downto 0);
    signal dpb_inst_4_DIB_i: std_logic_vector(15 downto 0);
    signal dpb_inst_4_DOA_o: std_logic_vector(15 downto 0);
    signal dpb_inst_4_DOB_o: std_logic_vector(15 downto 0);
    signal dpb_inst_5_BLKSELA_i: std_logic_vector(2 downto 0);
    signal dpb_inst_5_BLKSELB_i: std_logic_vector(2 downto 0);
    signal dpb_inst_5_ADA_i: std_logic_vector(13 downto 0);
    signal dpb_inst_5_DIA_i: std_logic_vector(15 downto 0);
    signal dpb_inst_5_ADB_i: std_logic_vector(13 downto 0);
    signal dpb_inst_5_DIB_i: std_logic_vector(15 downto 0);
    signal dpb_inst_5_DOA_o: std_logic_vector(15 downto 0);
    signal dpb_inst_5_DOB_o: std_logic_vector(15 downto 0);
    signal dpb_inst_6_BLKSELA_i: std_logic_vector(2 downto 0);
    signal dpb_inst_6_BLKSELB_i: std_logic_vector(2 downto 0);
    signal dpb_inst_6_ADA_i: std_logic_vector(13 downto 0);
    signal dpb_inst_6_DIA_i: std_logic_vector(15 downto 0);
    signal dpb_inst_6_ADB_i: std_logic_vector(13 downto 0);
    signal dpb_inst_6_DIB_i: std_logic_vector(15 downto 0);
    signal dpb_inst_6_DOA_o: std_logic_vector(15 downto 0);
    signal dpb_inst_6_DOB_o: std_logic_vector(15 downto 0);
    signal dpb_inst_7_BLKSELA_i: std_logic_vector(2 downto 0);
    signal dpb_inst_7_BLKSELB_i: std_logic_vector(2 downto 0);
    signal dpb_inst_7_ADA_i: std_logic_vector(13 downto 0);
    signal dpb_inst_7_DIA_i: std_logic_vector(15 downto 0);
    signal dpb_inst_7_ADB_i: std_logic_vector(13 downto 0);
    signal dpb_inst_7_DIB_i: std_logic_vector(15 downto 0);
    signal dpb_inst_7_DOA_o: std_logic_vector(15 downto 0);
    signal dpb_inst_7_DOB_o: std_logic_vector(15 downto 0);
    signal dpb_inst_8_BLKSELA_i: std_logic_vector(2 downto 0);
    signal dpb_inst_8_BLKSELB_i: std_logic_vector(2 downto 0);
    signal dpb_inst_8_ADA_i: std_logic_vector(13 downto 0);
    signal dpb_inst_8_DIA_i: std_logic_vector(15 downto 0);
    signal dpb_inst_8_ADB_i: std_logic_vector(13 downto 0);
    signal dpb_inst_8_DIB_i: std_logic_vector(15 downto 0);
    signal dpb_inst_8_DOA_o: std_logic_vector(15 downto 0);
    signal dpb_inst_8_DOB_o: std_logic_vector(15 downto 0);
    signal dpb_inst_9_BLKSELA_i: std_logic_vector(2 downto 0);
    signal dpb_inst_9_BLKSELB_i: std_logic_vector(2 downto 0);
    signal dpb_inst_9_ADA_i: std_logic_vector(13 downto 0);
    signal dpb_inst_9_DIA_i: std_logic_vector(15 downto 0);
    signal dpb_inst_9_ADB_i: std_logic_vector(13 downto 0);
    signal dpb_inst_9_DIB_i: std_logic_vector(15 downto 0);
    signal dpb_inst_9_DOA_o: std_logic_vector(15 downto 0);
    signal dpb_inst_9_DOB_o: std_logic_vector(15 downto 0);

    --component declaration
    component DPB
        generic (
            READ_MODE0: in bit := '0';
            READ_MODE1: in bit := '0';
            WRITE_MODE0: in bit_vector := "00";
            WRITE_MODE1: in bit_vector := "00";
            BIT_WIDTH_0: in integer :=16;
            BIT_WIDTH_1: in integer :=16;
            BLK_SEL_0: in bit_vector := "000";
            BLK_SEL_1: in bit_vector := "000";
            RESET_MODE: in string := "SYNC";
            INIT_RAM_00: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_01: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_02: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_03: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_04: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_05: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_06: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_07: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_08: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_09: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0A: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0B: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0C: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0D: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0E: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_0F: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_10: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_11: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_12: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_13: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_14: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_15: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_16: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_17: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_18: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_19: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1A: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1B: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1C: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1D: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1E: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_1F: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_20: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_21: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_22: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_23: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_24: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_25: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_26: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_27: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_28: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_29: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2A: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2B: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2C: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2D: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2E: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_2F: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_30: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_31: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_32: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_33: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_34: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_35: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_36: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_37: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_38: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_39: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3A: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3B: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3C: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3D: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3E: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
            INIT_RAM_3F: in bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000"
        );
        port (
            DOA: out std_logic_vector(15 downto 0);
            DOB: out std_logic_vector(15 downto 0);
            CLKA: in std_logic;
            OCEA: in std_logic;
            CEA: in std_logic;
            RESETA: in std_logic;
            WREA: in std_logic;
            CLKB: in std_logic;
            OCEB: in std_logic;
            CEB: in std_logic;
            RESETB: in std_logic;
            WREB: in std_logic;
            BLKSELA: in std_logic_vector(2 downto 0);
            BLKSELB: in std_logic_vector(2 downto 0);
            ADA: in std_logic_vector(13 downto 0);
            DIA: in std_logic_vector(15 downto 0);
            ADB: in std_logic_vector(13 downto 0);
            DIB: in std_logic_vector(15 downto 0)
        );
    end component;

    -- component declaration
    component DFFE
        port (
            Q: out std_logic;
            D: in std_logic;
            CLK: in std_logic;
            CE: in std_logic
        );
    end component;

    -- component declaration
    component MUX2
        port (
            O: out std_logic;
            I0: in std_logic;
            I1: in std_logic;
            S0: in std_logic
        );
    end component;

begin
    gw_gnd <= '0';

    cea_w <= not wrea and cea;
    ceb_w <= not wreb and ceb;
    dpb_inst_0_BLKSELA_i <= gw_gnd & gw_gnd & ada(13);
    dpb_inst_0_BLKSELB_i <= gw_gnd & gw_gnd & adb(13);
    dpb_inst_0_ADA_i <= ada(12 downto 0) & gw_gnd;
    dpb_inst_0_DIA_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dina(1 downto 0);
    dpb_inst_0_ADB_i <= adb(12 downto 0) & gw_gnd;
    dpb_inst_0_DIB_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dinb(1 downto 0);
    dpb_inst_0_douta(1 downto 0) <= dpb_inst_0_DOA_o(1 downto 0) ;
    dpb_inst_0_douta_w(13 downto 0) <= dpb_inst_0_DOA_o(15 downto 2) ;
    dpb_inst_0_doutb(1 downto 0) <= dpb_inst_0_DOB_o(1 downto 0) ;
    dpb_inst_0_doutb_w(13 downto 0) <= dpb_inst_0_DOB_o(15 downto 2) ;
    dpb_inst_1_BLKSELA_i <= gw_gnd & gw_gnd & ada(13);
    dpb_inst_1_BLKSELB_i <= gw_gnd & gw_gnd & adb(13);
    dpb_inst_1_ADA_i <= ada(12 downto 0) & gw_gnd;
    dpb_inst_1_DIA_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dina(3 downto 2);
    dpb_inst_1_ADB_i <= adb(12 downto 0) & gw_gnd;
    dpb_inst_1_DIB_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dinb(3 downto 2);
    dpb_inst_1_douta(3 downto 2) <= dpb_inst_1_DOA_o(1 downto 0) ;
    dpb_inst_1_douta_w(13 downto 0) <= dpb_inst_1_DOA_o(15 downto 2) ;
    dpb_inst_1_doutb(3 downto 2) <= dpb_inst_1_DOB_o(1 downto 0) ;
    dpb_inst_1_doutb_w(13 downto 0) <= dpb_inst_1_DOB_o(15 downto 2) ;
    dpb_inst_2_BLKSELA_i <= gw_gnd & gw_gnd & ada(13);
    dpb_inst_2_BLKSELB_i <= gw_gnd & gw_gnd & adb(13);
    dpb_inst_2_ADA_i <= ada(12 downto 0) & gw_gnd;
    dpb_inst_2_DIA_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dina(5 downto 4);
    dpb_inst_2_ADB_i <= adb(12 downto 0) & gw_gnd;
    dpb_inst_2_DIB_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dinb(5 downto 4);
    dpb_inst_2_douta(5 downto 4) <= dpb_inst_2_DOA_o(1 downto 0) ;
    dpb_inst_2_douta_w(13 downto 0) <= dpb_inst_2_DOA_o(15 downto 2) ;
    dpb_inst_2_doutb(5 downto 4) <= dpb_inst_2_DOB_o(1 downto 0) ;
    dpb_inst_2_doutb_w(13 downto 0) <= dpb_inst_2_DOB_o(15 downto 2) ;
    dpb_inst_3_BLKSELA_i <= gw_gnd & gw_gnd & ada(13);
    dpb_inst_3_BLKSELB_i <= gw_gnd & gw_gnd & adb(13);
    dpb_inst_3_ADA_i <= ada(12 downto 0) & gw_gnd;
    dpb_inst_3_DIA_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dina(7 downto 6);
    dpb_inst_3_ADB_i <= adb(12 downto 0) & gw_gnd;
    dpb_inst_3_DIB_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dinb(7 downto 6);
    dpb_inst_3_douta(7 downto 6) <= dpb_inst_3_DOA_o(1 downto 0) ;
    dpb_inst_3_douta_w(13 downto 0) <= dpb_inst_3_DOA_o(15 downto 2) ;
    dpb_inst_3_doutb(7 downto 6) <= dpb_inst_3_DOB_o(1 downto 0) ;
    dpb_inst_3_doutb_w(13 downto 0) <= dpb_inst_3_DOB_o(15 downto 2) ;
    dpb_inst_4_BLKSELA_i <= ada(13) & ada(12) & ada(11);
    dpb_inst_4_BLKSELB_i <= adb(13) & adb(12) & adb(11);
    dpb_inst_4_ADA_i <= ada(10 downto 0) & gw_gnd & gw_gnd & gw_gnd;
    dpb_inst_4_DIA_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dina(7 downto 0);
    dpb_inst_4_ADB_i <= adb(10 downto 0) & gw_gnd & gw_gnd & gw_gnd;
    dpb_inst_4_DIB_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dinb(7 downto 0);
    dpb_inst_4_douta(7 downto 0) <= dpb_inst_4_DOA_o(7 downto 0) ;
    dpb_inst_4_douta_w(7 downto 0) <= dpb_inst_4_DOA_o(15 downto 8) ;
    dpb_inst_4_doutb(7 downto 0) <= dpb_inst_4_DOB_o(7 downto 0) ;
    dpb_inst_4_doutb_w(7 downto 0) <= dpb_inst_4_DOB_o(15 downto 8) ;
    dpb_inst_5_BLKSELA_i <= gw_gnd & gw_gnd & ada(13);
    dpb_inst_5_BLKSELB_i <= gw_gnd & gw_gnd & adb(13);
    dpb_inst_5_ADA_i <= ada(12 downto 0) & gw_gnd;
    dpb_inst_5_DIA_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dina(9 downto 8);
    dpb_inst_5_ADB_i <= adb(12 downto 0) & gw_gnd;
    dpb_inst_5_DIB_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dinb(9 downto 8);
    dpb_inst_5_douta(9 downto 8) <= dpb_inst_5_DOA_o(1 downto 0) ;
    dpb_inst_5_douta_w(13 downto 0) <= dpb_inst_5_DOA_o(15 downto 2) ;
    dpb_inst_5_doutb(9 downto 8) <= dpb_inst_5_DOB_o(1 downto 0) ;
    dpb_inst_5_doutb_w(13 downto 0) <= dpb_inst_5_DOB_o(15 downto 2) ;
    dpb_inst_6_BLKSELA_i <= gw_gnd & gw_gnd & ada(13);
    dpb_inst_6_BLKSELB_i <= gw_gnd & gw_gnd & adb(13);
    dpb_inst_6_ADA_i <= ada(12 downto 0) & gw_gnd;
    dpb_inst_6_DIA_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dina(11 downto 10);
    dpb_inst_6_ADB_i <= adb(12 downto 0) & gw_gnd;
    dpb_inst_6_DIB_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dinb(11 downto 10);
    dpb_inst_6_douta(11 downto 10) <= dpb_inst_6_DOA_o(1 downto 0) ;
    dpb_inst_6_douta_w(13 downto 0) <= dpb_inst_6_DOA_o(15 downto 2) ;
    dpb_inst_6_doutb(11 downto 10) <= dpb_inst_6_DOB_o(1 downto 0) ;
    dpb_inst_6_doutb_w(13 downto 0) <= dpb_inst_6_DOB_o(15 downto 2) ;
    dpb_inst_7_BLKSELA_i <= gw_gnd & gw_gnd & ada(13);
    dpb_inst_7_BLKSELB_i <= gw_gnd & gw_gnd & adb(13);
    dpb_inst_7_ADA_i <= ada(12 downto 0) & gw_gnd;
    dpb_inst_7_DIA_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dina(13 downto 12);
    dpb_inst_7_ADB_i <= adb(12 downto 0) & gw_gnd;
    dpb_inst_7_DIB_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dinb(13 downto 12);
    dpb_inst_7_douta(13 downto 12) <= dpb_inst_7_DOA_o(1 downto 0) ;
    dpb_inst_7_douta_w(13 downto 0) <= dpb_inst_7_DOA_o(15 downto 2) ;
    dpb_inst_7_doutb(13 downto 12) <= dpb_inst_7_DOB_o(1 downto 0) ;
    dpb_inst_7_doutb_w(13 downto 0) <= dpb_inst_7_DOB_o(15 downto 2) ;
    dpb_inst_8_BLKSELA_i <= gw_gnd & gw_gnd & ada(13);
    dpb_inst_8_BLKSELB_i <= gw_gnd & gw_gnd & adb(13);
    dpb_inst_8_ADA_i <= ada(12 downto 0) & gw_gnd;
    dpb_inst_8_DIA_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dina(15 downto 14);
    dpb_inst_8_ADB_i <= adb(12 downto 0) & gw_gnd;
    dpb_inst_8_DIB_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dinb(15 downto 14);
    dpb_inst_8_douta(15 downto 14) <= dpb_inst_8_DOA_o(1 downto 0) ;
    dpb_inst_8_douta_w(13 downto 0) <= dpb_inst_8_DOA_o(15 downto 2) ;
    dpb_inst_8_doutb(15 downto 14) <= dpb_inst_8_DOB_o(1 downto 0) ;
    dpb_inst_8_doutb_w(13 downto 0) <= dpb_inst_8_DOB_o(15 downto 2) ;
    dpb_inst_9_BLKSELA_i <= ada(13) & ada(12) & ada(11);
    dpb_inst_9_BLKSELB_i <= adb(13) & adb(12) & adb(11);
    dpb_inst_9_ADA_i <= ada(10 downto 0) & gw_gnd & gw_gnd & gw_gnd;
    dpb_inst_9_DIA_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dina(15 downto 8);
    dpb_inst_9_ADB_i <= adb(10 downto 0) & gw_gnd & gw_gnd & gw_gnd;
    dpb_inst_9_DIB_i <= gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & gw_gnd & dinb(15 downto 8);
    dpb_inst_9_douta(15 downto 8) <= dpb_inst_9_DOA_o(7 downto 0) ;
    dpb_inst_9_douta_w(7 downto 0) <= dpb_inst_9_DOA_o(15 downto 8) ;
    dpb_inst_9_doutb(15 downto 8) <= dpb_inst_9_DOB_o(7 downto 0) ;
    dpb_inst_9_doutb_w(7 downto 0) <= dpb_inst_9_DOB_o(15 downto 8) ;
    dpb_inst_0: DPB
        generic map (
            READ_MODE0 => '0',
            READ_MODE1 => '0',
            WRITE_MODE0 => "00",
            WRITE_MODE1 => "00",
            BIT_WIDTH_0 => 2,
            BIT_WIDTH_1 => 2,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "000",
            BLK_SEL_1 => "000"
        )
        port map (
            DOA => dpb_inst_0_DOA_o,
            DOB => dpb_inst_0_DOB_o,
            CLKA => clka,
            OCEA => ocea,
            CEA => cea,
            RESETA => reseta,
            WREA => wrea,
            CLKB => clkb,
            OCEB => oceb,
            CEB => ceb,
            RESETB => resetb,
            WREB => wreb,
            BLKSELA => dpb_inst_0_BLKSELA_i,
            BLKSELB => dpb_inst_0_BLKSELB_i,
            ADA => dpb_inst_0_ADA_i,
            DIA => dpb_inst_0_DIA_i,
            ADB => dpb_inst_0_ADB_i,
            DIB => dpb_inst_0_DIB_i
        );

    dpb_inst_1: DPB
        generic map (
            READ_MODE0 => '0',
            READ_MODE1 => '0',
            WRITE_MODE0 => "00",
            WRITE_MODE1 => "00",
            BIT_WIDTH_0 => 2,
            BIT_WIDTH_1 => 2,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "000",
            BLK_SEL_1 => "000"
        )
        port map (
            DOA => dpb_inst_1_DOA_o,
            DOB => dpb_inst_1_DOB_o,
            CLKA => clka,
            OCEA => ocea,
            CEA => cea,
            RESETA => reseta,
            WREA => wrea,
            CLKB => clkb,
            OCEB => oceb,
            CEB => ceb,
            RESETB => resetb,
            WREB => wreb,
            BLKSELA => dpb_inst_1_BLKSELA_i,
            BLKSELB => dpb_inst_1_BLKSELB_i,
            ADA => dpb_inst_1_ADA_i,
            DIA => dpb_inst_1_DIA_i,
            ADB => dpb_inst_1_ADB_i,
            DIB => dpb_inst_1_DIB_i
        );

    dpb_inst_2: DPB
        generic map (
            READ_MODE0 => '0',
            READ_MODE1 => '0',
            WRITE_MODE0 => "00",
            WRITE_MODE1 => "00",
            BIT_WIDTH_0 => 2,
            BIT_WIDTH_1 => 2,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "000",
            BLK_SEL_1 => "000"
        )
        port map (
            DOA => dpb_inst_2_DOA_o,
            DOB => dpb_inst_2_DOB_o,
            CLKA => clka,
            OCEA => ocea,
            CEA => cea,
            RESETA => reseta,
            WREA => wrea,
            CLKB => clkb,
            OCEB => oceb,
            CEB => ceb,
            RESETB => resetb,
            WREB => wreb,
            BLKSELA => dpb_inst_2_BLKSELA_i,
            BLKSELB => dpb_inst_2_BLKSELB_i,
            ADA => dpb_inst_2_ADA_i,
            DIA => dpb_inst_2_DIA_i,
            ADB => dpb_inst_2_ADB_i,
            DIB => dpb_inst_2_DIB_i
        );

    dpb_inst_3: DPB
        generic map (
            READ_MODE0 => '0',
            READ_MODE1 => '0',
            WRITE_MODE0 => "00",
            WRITE_MODE1 => "00",
            BIT_WIDTH_0 => 2,
            BIT_WIDTH_1 => 2,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "000",
            BLK_SEL_1 => "000"
        )
        port map (
            DOA => dpb_inst_3_DOA_o,
            DOB => dpb_inst_3_DOB_o,
            CLKA => clka,
            OCEA => ocea,
            CEA => cea,
            RESETA => reseta,
            WREA => wrea,
            CLKB => clkb,
            OCEB => oceb,
            CEB => ceb,
            RESETB => resetb,
            WREB => wreb,
            BLKSELA => dpb_inst_3_BLKSELA_i,
            BLKSELB => dpb_inst_3_BLKSELB_i,
            ADA => dpb_inst_3_ADA_i,
            DIA => dpb_inst_3_DIA_i,
            ADB => dpb_inst_3_ADB_i,
            DIB => dpb_inst_3_DIB_i
        );

    dpb_inst_4: DPB
        generic map (
            READ_MODE0 => '0',
            READ_MODE1 => '0',
            WRITE_MODE0 => "00",
            WRITE_MODE1 => "00",
            BIT_WIDTH_0 => 8,
            BIT_WIDTH_1 => 8,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "100",
            BLK_SEL_1 => "100"
        )
        port map (
            DOA => dpb_inst_4_DOA_o,
            DOB => dpb_inst_4_DOB_o,
            CLKA => clka,
            OCEA => ocea,
            CEA => cea,
            RESETA => reseta,
            WREA => wrea,
            CLKB => clkb,
            OCEB => oceb,
            CEB => ceb,
            RESETB => resetb,
            WREB => wreb,
            BLKSELA => dpb_inst_4_BLKSELA_i,
            BLKSELB => dpb_inst_4_BLKSELB_i,
            ADA => dpb_inst_4_ADA_i,
            DIA => dpb_inst_4_DIA_i,
            ADB => dpb_inst_4_ADB_i,
            DIB => dpb_inst_4_DIB_i
        );

    dpb_inst_5: DPB
        generic map (
            READ_MODE0 => '0',
            READ_MODE1 => '0',
            WRITE_MODE0 => "00",
            WRITE_MODE1 => "00",
            BIT_WIDTH_0 => 2,
            BIT_WIDTH_1 => 2,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "000",
            BLK_SEL_1 => "000"
        )
        port map (
            DOA => dpb_inst_5_DOA_o,
            DOB => dpb_inst_5_DOB_o,
            CLKA => clka,
            OCEA => ocea,
            CEA => cea,
            RESETA => reseta,
            WREA => wrea,
            CLKB => clkb,
            OCEB => oceb,
            CEB => ceb,
            RESETB => resetb,
            WREB => wreb,
            BLKSELA => dpb_inst_5_BLKSELA_i,
            BLKSELB => dpb_inst_5_BLKSELB_i,
            ADA => dpb_inst_5_ADA_i,
            DIA => dpb_inst_5_DIA_i,
            ADB => dpb_inst_5_ADB_i,
            DIB => dpb_inst_5_DIB_i
        );

    dpb_inst_6: DPB
        generic map (
            READ_MODE0 => '0',
            READ_MODE1 => '0',
            WRITE_MODE0 => "00",
            WRITE_MODE1 => "00",
            BIT_WIDTH_0 => 2,
            BIT_WIDTH_1 => 2,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "000",
            BLK_SEL_1 => "000"
        )
        port map (
            DOA => dpb_inst_6_DOA_o,
            DOB => dpb_inst_6_DOB_o,
            CLKA => clka,
            OCEA => ocea,
            CEA => cea,
            RESETA => reseta,
            WREA => wrea,
            CLKB => clkb,
            OCEB => oceb,
            CEB => ceb,
            RESETB => resetb,
            WREB => wreb,
            BLKSELA => dpb_inst_6_BLKSELA_i,
            BLKSELB => dpb_inst_6_BLKSELB_i,
            ADA => dpb_inst_6_ADA_i,
            DIA => dpb_inst_6_DIA_i,
            ADB => dpb_inst_6_ADB_i,
            DIB => dpb_inst_6_DIB_i
        );

    dpb_inst_7: DPB
        generic map (
            READ_MODE0 => '0',
            READ_MODE1 => '0',
            WRITE_MODE0 => "00",
            WRITE_MODE1 => "00",
            BIT_WIDTH_0 => 2,
            BIT_WIDTH_1 => 2,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "000",
            BLK_SEL_1 => "000"
        )
        port map (
            DOA => dpb_inst_7_DOA_o,
            DOB => dpb_inst_7_DOB_o,
            CLKA => clka,
            OCEA => ocea,
            CEA => cea,
            RESETA => reseta,
            WREA => wrea,
            CLKB => clkb,
            OCEB => oceb,
            CEB => ceb,
            RESETB => resetb,
            WREB => wreb,
            BLKSELA => dpb_inst_7_BLKSELA_i,
            BLKSELB => dpb_inst_7_BLKSELB_i,
            ADA => dpb_inst_7_ADA_i,
            DIA => dpb_inst_7_DIA_i,
            ADB => dpb_inst_7_ADB_i,
            DIB => dpb_inst_7_DIB_i
        );

    dpb_inst_8: DPB
        generic map (
            READ_MODE0 => '0',
            READ_MODE1 => '0',
            WRITE_MODE0 => "00",
            WRITE_MODE1 => "00",
            BIT_WIDTH_0 => 2,
            BIT_WIDTH_1 => 2,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "000",
            BLK_SEL_1 => "000"
        )
        port map (
            DOA => dpb_inst_8_DOA_o,
            DOB => dpb_inst_8_DOB_o,
            CLKA => clka,
            OCEA => ocea,
            CEA => cea,
            RESETA => reseta,
            WREA => wrea,
            CLKB => clkb,
            OCEB => oceb,
            CEB => ceb,
            RESETB => resetb,
            WREB => wreb,
            BLKSELA => dpb_inst_8_BLKSELA_i,
            BLKSELB => dpb_inst_8_BLKSELB_i,
            ADA => dpb_inst_8_ADA_i,
            DIA => dpb_inst_8_DIA_i,
            ADB => dpb_inst_8_ADB_i,
            DIB => dpb_inst_8_DIB_i
        );

    dpb_inst_9: DPB
        generic map (
            READ_MODE0 => '0',
            READ_MODE1 => '0',
            WRITE_MODE0 => "00",
            WRITE_MODE1 => "00",
            BIT_WIDTH_0 => 8,
            BIT_WIDTH_1 => 8,
            RESET_MODE => "SYNC",
            BLK_SEL_0 => "100",
            BLK_SEL_1 => "100"
        )
        port map (
            DOA => dpb_inst_9_DOA_o,
            DOB => dpb_inst_9_DOB_o,
            CLKA => clka,
            OCEA => ocea,
            CEA => cea,
            RESETA => reseta,
            WREA => wrea,
            CLKB => clkb,
            OCEB => oceb,
            CEB => ceb,
            RESETB => resetb,
            WREB => wreb,
            BLKSELA => dpb_inst_9_BLKSELA_i,
            BLKSELB => dpb_inst_9_BLKSELB_i,
            ADA => dpb_inst_9_ADA_i,
            DIA => dpb_inst_9_DIA_i,
            ADB => dpb_inst_9_ADB_i,
            DIB => dpb_inst_9_DIB_i
        );

    dff_inst_0: DFFE
        port map (
            Q => dff_q_0,
            D => ada(13),
            CLK => clka,
            CE => cea_w
        );

    dff_inst_1: DFFE
        port map (
            Q => dff_q_1,
            D => adb(13),
            CLK => clkb,
            CE => ceb_w
        );

    mux_inst_4: MUX2
        port map (
            O => douta(0),
            I0 => dpb_inst_0_douta(0),
            I1 => dpb_inst_4_douta(0),
            S0 => dff_q_0
        );

    mux_inst_9: MUX2
        port map (
            O => douta(1),
            I0 => dpb_inst_0_douta(1),
            I1 => dpb_inst_4_douta(1),
            S0 => dff_q_0
        );

    mux_inst_14: MUX2
        port map (
            O => douta(2),
            I0 => dpb_inst_1_douta(2),
            I1 => dpb_inst_4_douta(2),
            S0 => dff_q_0
        );

    mux_inst_19: MUX2
        port map (
            O => douta(3),
            I0 => dpb_inst_1_douta(3),
            I1 => dpb_inst_4_douta(3),
            S0 => dff_q_0
        );

    mux_inst_24: MUX2
        port map (
            O => douta(4),
            I0 => dpb_inst_2_douta(4),
            I1 => dpb_inst_4_douta(4),
            S0 => dff_q_0
        );

    mux_inst_29: MUX2
        port map (
            O => douta(5),
            I0 => dpb_inst_2_douta(5),
            I1 => dpb_inst_4_douta(5),
            S0 => dff_q_0
        );

    mux_inst_34: MUX2
        port map (
            O => douta(6),
            I0 => dpb_inst_3_douta(6),
            I1 => dpb_inst_4_douta(6),
            S0 => dff_q_0
        );

    mux_inst_39: MUX2
        port map (
            O => douta(7),
            I0 => dpb_inst_3_douta(7),
            I1 => dpb_inst_4_douta(7),
            S0 => dff_q_0
        );

    mux_inst_44: MUX2
        port map (
            O => douta(8),
            I0 => dpb_inst_5_douta(8),
            I1 => dpb_inst_9_douta(8),
            S0 => dff_q_0
        );

    mux_inst_49: MUX2
        port map (
            O => douta(9),
            I0 => dpb_inst_5_douta(9),
            I1 => dpb_inst_9_douta(9),
            S0 => dff_q_0
        );

    mux_inst_54: MUX2
        port map (
            O => douta(10),
            I0 => dpb_inst_6_douta(10),
            I1 => dpb_inst_9_douta(10),
            S0 => dff_q_0
        );

    mux_inst_59: MUX2
        port map (
            O => douta(11),
            I0 => dpb_inst_6_douta(11),
            I1 => dpb_inst_9_douta(11),
            S0 => dff_q_0
        );

    mux_inst_64: MUX2
        port map (
            O => douta(12),
            I0 => dpb_inst_7_douta(12),
            I1 => dpb_inst_9_douta(12),
            S0 => dff_q_0
        );

    mux_inst_69: MUX2
        port map (
            O => douta(13),
            I0 => dpb_inst_7_douta(13),
            I1 => dpb_inst_9_douta(13),
            S0 => dff_q_0
        );

    mux_inst_74: MUX2
        port map (
            O => douta(14),
            I0 => dpb_inst_8_douta(14),
            I1 => dpb_inst_9_douta(14),
            S0 => dff_q_0
        );

    mux_inst_79: MUX2
        port map (
            O => douta(15),
            I0 => dpb_inst_8_douta(15),
            I1 => dpb_inst_9_douta(15),
            S0 => dff_q_0
        );

    mux_inst_84: MUX2
        port map (
            O => doutb(0),
            I0 => dpb_inst_0_doutb(0),
            I1 => dpb_inst_4_doutb(0),
            S0 => dff_q_1
        );

    mux_inst_89: MUX2
        port map (
            O => doutb(1),
            I0 => dpb_inst_0_doutb(1),
            I1 => dpb_inst_4_doutb(1),
            S0 => dff_q_1
        );

    mux_inst_94: MUX2
        port map (
            O => doutb(2),
            I0 => dpb_inst_1_doutb(2),
            I1 => dpb_inst_4_doutb(2),
            S0 => dff_q_1
        );

    mux_inst_99: MUX2
        port map (
            O => doutb(3),
            I0 => dpb_inst_1_doutb(3),
            I1 => dpb_inst_4_doutb(3),
            S0 => dff_q_1
        );

    mux_inst_104: MUX2
        port map (
            O => doutb(4),
            I0 => dpb_inst_2_doutb(4),
            I1 => dpb_inst_4_doutb(4),
            S0 => dff_q_1
        );

    mux_inst_109: MUX2
        port map (
            O => doutb(5),
            I0 => dpb_inst_2_doutb(5),
            I1 => dpb_inst_4_doutb(5),
            S0 => dff_q_1
        );

    mux_inst_114: MUX2
        port map (
            O => doutb(6),
            I0 => dpb_inst_3_doutb(6),
            I1 => dpb_inst_4_doutb(6),
            S0 => dff_q_1
        );

    mux_inst_119: MUX2
        port map (
            O => doutb(7),
            I0 => dpb_inst_3_doutb(7),
            I1 => dpb_inst_4_doutb(7),
            S0 => dff_q_1
        );

    mux_inst_124: MUX2
        port map (
            O => doutb(8),
            I0 => dpb_inst_5_doutb(8),
            I1 => dpb_inst_9_doutb(8),
            S0 => dff_q_1
        );

    mux_inst_129: MUX2
        port map (
            O => doutb(9),
            I0 => dpb_inst_5_doutb(9),
            I1 => dpb_inst_9_doutb(9),
            S0 => dff_q_1
        );

    mux_inst_134: MUX2
        port map (
            O => doutb(10),
            I0 => dpb_inst_6_doutb(10),
            I1 => dpb_inst_9_doutb(10),
            S0 => dff_q_1
        );

    mux_inst_139: MUX2
        port map (
            O => doutb(11),
            I0 => dpb_inst_6_doutb(11),
            I1 => dpb_inst_9_doutb(11),
            S0 => dff_q_1
        );

    mux_inst_144: MUX2
        port map (
            O => doutb(12),
            I0 => dpb_inst_7_doutb(12),
            I1 => dpb_inst_9_doutb(12),
            S0 => dff_q_1
        );

    mux_inst_149: MUX2
        port map (
            O => doutb(13),
            I0 => dpb_inst_7_doutb(13),
            I1 => dpb_inst_9_doutb(13),
            S0 => dff_q_1
        );

    mux_inst_154: MUX2
        port map (
            O => doutb(14),
            I0 => dpb_inst_8_doutb(14),
            I1 => dpb_inst_9_doutb(14),
            S0 => dff_q_1
        );

    mux_inst_159: MUX2
        port map (
            O => doutb(15),
            I0 => dpb_inst_8_doutb(15),
            I1 => dpb_inst_9_doutb(15),
            S0 => dff_q_1
        );

end Behavioral; --dp_ram
