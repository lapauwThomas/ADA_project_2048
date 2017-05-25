
-- VHDL Instantiation Created from source file MOVE_GEN.vhd -- 10:32:54 05/25/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT MOVE_GEN
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		enable : IN std_logic;
		input_character : IN std_logic_vector(7 downto 0);          
		direction : OUT std_logic_vector(1 downto 0);
		valid : OUT std_logic
		);
	END COMPONENT;

	Inst_MOVE_GEN: MOVE_GEN PORT MAP(
		clk => ,
		reset => ,
		enable => ,
		input_character => ,
		direction => ,
		valid => 
	);


