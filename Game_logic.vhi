
-- VHDL Instantiation Created from source file Game_logic.vhd -- 12:23:02 05/25/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Game_logic
	PORT(
		CLK : IN std_logic;
		input_character : IN std_logic_vector(7 downto 0);
		RESET : IN std_logic;
		START : IN std_logic;
		LOAD : IN std_logic;          
		GAMEOVER : OUT std_logic;
		OUT_VALUE_BL11 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL12 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL13 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL14 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL21 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL22 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL23 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL24 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL31 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL32 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL33 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL34 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL41 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL42 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL43 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL44 : OUT std_logic_vector(11 downto 0)
		);
	END COMPONENT;

	Inst_Game_logic: Game_logic PORT MAP(
		CLK => ,
		input_character => ,
		RESET => ,
		GAMEOVER => ,
		START => ,
		LOAD => ,
		OUT_VALUE_BL11 => ,
		OUT_VALUE_BL12 => ,
		OUT_VALUE_BL13 => ,
		OUT_VALUE_BL14 => ,
		OUT_VALUE_BL21 => ,
		OUT_VALUE_BL22 => ,
		OUT_VALUE_BL23 => ,
		OUT_VALUE_BL24 => ,
		OUT_VALUE_BL31 => ,
		OUT_VALUE_BL32 => ,
		OUT_VALUE_BL33 => ,
		OUT_VALUE_BL34 => ,
		OUT_VALUE_BL41 => ,
		OUT_VALUE_BL42 => ,
		OUT_VALUE_BL43 => ,
		OUT_VALUE_BL44 => 
	);


