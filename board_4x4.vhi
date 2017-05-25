
-- VHDL Instantiation Created from source file board_4x4.vhd -- 10:27:11 05/25/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT board_4x4
	PORT(
		CLK : IN std_logic;
		INITVAL : IN std_logic_vector(11 downto 0);
		DIRECTION : IN std_logic_vector(1 downto 0);
		EXECUTE : IN std_logic;
		RESET : IN std_logic;
		INITLOC : IN std_logic_vector(15 downto 0);          
		BOARDIDLE : OUT std_logic;
		ISZERO_VECT : OUT std_logic_vector(15 downto 0);
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

	Inst_board_4x4: board_4x4 PORT MAP(
		CLK => ,
		INITVAL => ,
		DIRECTION => ,
		EXECUTE => ,
		RESET => ,
		BOARDIDLE => ,
		INITLOC => ,
		ISZERO_VECT => ,
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


