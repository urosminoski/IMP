--Copyright (C)2014-2024 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.9.02
--Part Number: GW1N-LV4LQ144C5/I4
--Device: GW1N-4
--Device Version: D
--Created Time: Mon May 13 09:07:45 2024

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component dp_ram
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
        ada: in std_logic_vector(12 downto 0);
        dina: in std_logic_vector(15 downto 0);
        adb: in std_logic_vector(12 downto 0);
        dinb: in std_logic_vector(15 downto 0)
    );
end component;

your_instance_name: dp_ram
    port map (
        douta => douta_o,
        doutb => doutb_o,
        clka => clka_i,
        ocea => ocea_i,
        cea => cea_i,
        reseta => reseta_i,
        wrea => wrea_i,
        clkb => clkb_i,
        oceb => oceb_i,
        ceb => ceb_i,
        resetb => resetb_i,
        wreb => wreb_i,
        ada => ada_i,
        dina => dina_i,
        adb => adb_i,
        dinb => dinb_i
    );

----------Copy end-------------------