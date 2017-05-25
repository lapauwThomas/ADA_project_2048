
-- VHDL Instantiation Created from source file LFSR.vhd -- 14:14:22 05/25/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT LFSR
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		enable : IN std_logic;
		seed : IN std_logic_vector(4 downto 0);
		zero_tiles : IN std_logic_vector(15 downto 0);          
		value_2_4 : OUT std_logic_vector(11 downto 0);
		location : OUT std_logic_vector(15 downto 0);
		valid : OUT std_logic;
		output : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;

	Inst_LFSR: LFSR PORT MAP(
		clk => ,
		reset => ,
		enable => ,
		seed => ,
		zero_tiles => ,
		value_2_4 => ,
		location => ,
		valid => ,
		output => 
	);


