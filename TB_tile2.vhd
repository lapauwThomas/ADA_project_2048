--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:19:38 05/23/2017
-- Design Name:   
-- Module Name:   C:/Users/thoma/CloudStation/School/2MA/semester2/ADA/labs/project/TB_tile2.vhd
-- Project Name:  project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: tile
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_tile2 IS
END TB_tile2;
 
ARCHITECTURE behavior OF TB_tile2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT tile
    PORT(
         CLK : IN  std_logic;
         VALUE : OUT  std_logic_vector(11 downto 0);
         DIRECTION : IN  std_logic_vector(1 downto 0);
         EXECUTE : IN  std_logic;
         MOVE_LEFT_NDONE : IN  std_logic;
         MOVE_RIGHT_NDONE : IN  std_logic;
         MOVE_UP_NDONE : IN  std_logic;
         MOVE_DOWN_NDONE : IN  std_logic;
         INIT : IN  std_logic;
         INITVAL : IN  std_logic_vector(11 downto 0);
         MOVE_OUT_LEFT : OUT  std_logic_vector(1 downto 0);
         MOVE_OUT_RIGHT : OUT  std_logic_vector(1 downto 0);
         MOVE_OUT_TOP : OUT  std_logic_vector(1 downto 0);
         MOVE_OUT_BOTTOM : OUT  std_logic_vector(1 downto 0);
         MOVE_IN_LEFT : IN  std_logic_vector(1 downto 0);
         MOVE_IN_RIGHT : IN  std_logic_vector(1 downto 0);
         MOVE_IN_TOP : IN  std_logic_vector(1 downto 0);
         MOVE_IN_BOTTOM : IN  std_logic_vector(1 downto 0);
         LEFT_TILE : IN  std_logic_vector(11 downto 0);
         RIGHT_TILE : IN  std_logic_vector(11 downto 0);
         TOP_TILE : IN  std_logic_vector(11 downto 0);
         BOTTOM_TILE : IN  std_logic_vector(11 downto 0);
         RESET : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
	
	--GLOBAL SIGNALS SHARED
   signal CLK : std_logic := '0';
   signal DIRECTION : std_logic_vector(1 downto 0) := (others => '0');
   signal EXECUTE : std_logic := '0';
	signal INITVAL : std_logic_vector(11 downto 0) := (others => '0');
	signal RESET : std_logic := '0';
	
   signal MOVE_LEFT_NDONE_ROW1 : std_logic := '0';
   signal MOVE_RIGHT_NDONE_ROW1 : std_logic := '0';
   signal MOVE_UP_NDONE_COL1 : std_logic := '0';
   signal MOVE_DOWN_NDONE_COL1 : std_logic := '0';
	
   signal INIT_BL1 : std_logic := '0';
	signal INIT_BL2 : std_logic := '0';
   --signal MOVE_IN_LEFT : std_logic_vector(1 downto 0) := (others => '0');
   
   --signal MOVE_IN_TOP : std_logic_vector(1 downto 0) := (others => '0');
	
   signal MOVE_IN_BOTTOM_BL1 : std_logic_vector(1 downto 0) := (others => '0');
	signal MOVE_IN_BOTTOM_BL2 : std_logic_vector(1 downto 0) := (others => '0');
	signal MOVE_IN_RIGHT_BL2 : std_logic_vector(1 downto 0) := (others => '0');
	
	
	
  --signal LEFT_TILE : std_logic_vector(11 downto 0) := (others => '0');
   signal RIGHT_TILE_BL2 : std_logic_vector(11 downto 0) := (others => '0');
  -- signal TOP_TILE : std_logic_vector(11 downto 0) := (others => '0');
   signal BOTTOM_TILE_BL1 : std_logic_vector(11 downto 0) := (others => '0');
	signal BOTTOM_TILE_BL2 : std_logic_vector(11 downto 0) := (others => '0');

 	--Outputs
   
	
   signal MOVE_OUT_LEFT_BL1 : std_logic_vector(1 downto 0);
	signal MOVE_OUT_RIGHT_BL2 : std_logic_vector(1 downto 0);
	
	--INTERCONNECTS
   signal MV_BL1_BL2 : std_logic_vector(1 downto 0);
	signal MV_BL2_BL1 : std_logic_vector(1 downto 0) := (others => '0');
	signal VALUE_BL1 : std_logic_vector(11 downto 0);
	signal VALUE_BL2 : std_logic_vector(11 downto 0);
	
	signal MOVE_OUT_TOP_BL2 : std_logic_vector(1 downto 0);
   signal MOVE_OUT_TOP_BL1 : std_logic_vector(1 downto 0);
   signal MOVE_OUT_BOTTOM_BL2 : std_logic_vector(1 downto 0);
   signal MOVE_OUT_BOTTOM_BL1 : std_logic_vector(1 downto 0);
   -- Clock period definitions
   constant CLK_period : time := 10 ns;
	
	constant zeroes: std_logic_vector(11 downto 0) := (others => '0');
	constant WALL_VAL: std_logic_vector(11 downto 0) := (others => '1');
	constant WALL_MOVE: std_logic_vector(1 downto 0) := (others => '0');
	
constant dirLeft: std_logic_vector(1 downto 0) := "00";
constant dirUp: std_logic_vector(1 downto 0) := "01";
constant dirRight: std_logic_vector(1 downto 0) := "10";
constant dirDown: std_logic_vector(1 downto 0) := "11";


 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
  BL1: tile PORT MAP (
          CLK => CLK,
          
          DIRECTION => DIRECTION,
          EXECUTE => EXECUTE,
			 INITVAL => INITVAL,
			 RESET => RESET,
			 
			 VALUE => VALUE_BL1,
			 INIT => INIT_BL1,
			 
			 
          MOVE_LEFT_NDONE => MOVE_LEFT_NDONE_ROW1,
          MOVE_RIGHT_NDONE => MOVE_RIGHT_NDONE_ROW1,
          MOVE_UP_NDONE => MOVE_UP_NDONE_COL1,
          MOVE_DOWN_NDONE => MOVE_DOWN_NDONE_COL1,
          
          
          MOVE_OUT_LEFT => MOVE_OUT_LEFT_BL1,
          MOVE_OUT_RIGHT => MV_BL1_BL2,
          MOVE_OUT_TOP => MOVE_OUT_TOP_BL1,
          MOVE_OUT_BOTTOM => MOVE_OUT_BOTTOM_BL1,
			 
          MOVE_IN_LEFT => WALL_MOVE,
          MOVE_IN_RIGHT => MV_BL2_BL1,
          MOVE_IN_TOP => WALL_MOVE,
          MOVE_IN_BOTTOM => WALL_MOVE,
			 
          LEFT_TILE => WALL_VAL,
          RIGHT_TILE => VALUE_BL2,
          TOP_TILE => WALL_VAL,
          BOTTOM_TILE => WALL_VAL
          
        );
		  
		  
		BL2: tile PORT MAP (
          CLK => CLK,
          DIRECTION => DIRECTION,
          EXECUTE => EXECUTE,
			 INITVAL => INITVAL,
			 RESET => RESET,
			 
			 VALUE => VALUE_BL2,
			 INIT => INIT_BL2,
          
          MOVE_LEFT_NDONE => MOVE_LEFT_NDONE_ROW1,
          MOVE_RIGHT_NDONE => MOVE_RIGHT_NDONE_ROW1,
          MOVE_UP_NDONE => MOVE_UP_NDONE_COL1,
          MOVE_DOWN_NDONE => MOVE_DOWN_NDONE_COL1,
          
          MOVE_OUT_LEFT => MV_BL2_BL1,
          MOVE_OUT_RIGHT => MOVE_OUT_RIGHT_BL2,
          MOVE_OUT_TOP => MOVE_OUT_TOP_BL2,
          MOVE_OUT_BOTTOM => MOVE_OUT_BOTTOM_BL2,
			 
          MOVE_IN_LEFT => MV_BL1_BL2,
          MOVE_IN_RIGHT => WALL_MOVE,
          MOVE_IN_TOP => WALL_MOVE,
          MOVE_IN_BOTTOM => WALL_MOVE,
			 
          LEFT_TILE => VALUE_BL1,
          RIGHT_TILE => WALL_VAL,
          TOP_TILE => WALL_VAL,
          BOTTOM_TILE => WALL_VAL

        );
		  
		  MOVE_LEFT_NDONE_ROW1 <= MOVE_OUT_RIGHT_BL2(1);
		  MOVE_RIGHT_NDONE_ROW1 <= MOVE_OUT_LEFT_BL1(1);
   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		RESET <= '1';
		wait for 100 ns;	
		RESET <= '0';
		
		INITVAL <= "000000000010";
		wait for 10 ns;
		INIT_BL2 <= '1';
		wait for 20 ns;
		INIT_BL2 <= '0';	
		wait for 100 ns;
		
		
		DIRECTION <= dirLEFT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
		
		INITVAL <= "000000000010";
		wait for 10 ns;
		INIT_BL2 <= '1';
		wait for 20 ns;
		INIT_BL2 <= '0';	
		wait for 100 ns;
		
		
		DIRECTION <= dirLEFT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
		INITVAL <= "000000000100";
		wait for 10 ns;
		INIT_BL2 <= '1';
		wait for 20 ns;
		INIT_BL2 <= '0';	
		wait for 100 ns;
		
		
		DIRECTION <= dirRIGHT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				DIRECTION <= dirLEFT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				DIRECTION <= dirLEFT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				DIRECTION <= dirLEFT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				DIRECTION <= dirRIGHT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				DIRECTION <= dirRIGHT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
						DIRECTION <= dirLEFT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				DIRECTION <= dirRIGHT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
		
				INITVAL <= "000000000010";
		wait for 10 ns;
		INIT_BL1 <= '1';
		wait for 20 ns;
		INIT_BL1 <= '0';	
		wait for 100 ns;
		
						DIRECTION <= dirLEFT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				DIRECTION <= dirRIGHT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				DIRECTION <= dirRIGHT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
						DIRECTION <= dirLEFT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				DIRECTION <= dirRIGHT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				
				INITVAL <= "000000001000";
		wait for 10 ns;
		INIT_BL1 <= '1';
		wait for 20 ns;
		INIT_BL1 <= '0';	
		wait for 100 ns;
		
						DIRECTION <= dirLEFT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				DIRECTION <= dirRIGHT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				DIRECTION <= dirRIGHT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
						DIRECTION <= dirLEFT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
				DIRECTION <= dirRIGHT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
		
      wait for CLK_period*10;
		
      -- insert stimulus here 

      wait;
   end process;

END;
