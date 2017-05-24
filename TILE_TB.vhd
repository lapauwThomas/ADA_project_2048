--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:21:31 05/22/2017
-- Design Name:   
-- Module Name:   C:/Users/thoma/CloudStation/School/2MA/semester2/ADA/labs/project/TILE_TB.vhd
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
 
ENTITY TILE_TB IS
END TILE_TB;
 
ARCHITECTURE behavior OF TILE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT tile
    PORT(
         CLK : IN  std_logic;
         VALUE : OUT  std_logic_vector(11 downto 0);
         DIRECTION : IN  std_logic_vector(1 downto 0);
         EXECUTE : IN  std_logic;
         INIT : IN  std_logic;
         INITVAL : IN  std_logic_vector(11 downto 0);
         ALLOW_MOVE_FROM_LEFT : OUT  std_logic;
         ALLOW_MOVE_FROM_RIGHT : OUT  std_logic;
         ALLOW_MOVE_FROM_TOP : OUT  std_logic;
         ALLOW_MOVE_FROM_BOTTOM : OUT  std_logic;
         MOVE_INTO_LEFT : IN  std_logic;
         MOVE_INTO_RIGHT : IN  std_logic;
         MOVE_INTO_TOP : IN  std_logic;
         MOVE_INTO_BOTTOM : IN  std_logic;
         ALLOW_MERGE_FROM_LEFT : OUT  std_logic;
         ALLOW_MERGE_FROM_RIGHT : OUT  std_logic;
         ALLOW_MERGE_FROM_TOP : OUT  std_logic;
         ALLOW_MERGE_FROM_BOTTOM : OUT  std_logic;
         MERGE_INTO_LEFT : IN  std_logic;
         MERGE_INTO_RIGHT : IN  std_logic;
         MERGE_INTO_TOP : IN  std_logic;
         MERGE_INTO_BOTTOM : IN  std_logic;
         LEFT_TILE : IN  std_logic_vector(11 downto 0);
         RIGHT_TILE : IN  std_logic_vector(11 downto 0);
         TOP_TILE : IN  std_logic_vector(11 downto 0);
         BOTTOM_TILE : IN  std_logic_vector(11 downto 0);
         RESET : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
	
	--General signals shared
   signal CLK : std_logic := '0';
   signal DIRECTION : std_logic_vector(1 downto 0) := (others => '0');
   signal EXECUTE : std_logic := '0';
	signal INITVAL : std_logic_vector(11 downto 0) := (others => '0');
	signal RESET : std_logic := '0';
	
------------------BLOCK 1 ---------------------------------------------------	
   signal BL1_INIT : std_logic := '0';

  -- signal BL1_MOVE_INTO_LEFT : std_logic := '0';
   signal BL1_MOVE_INTO_RIGHT : std_logic := '0';
   --signal BL1_MOVE_INTO_TOP : std_logic := '0';
   signal BL1_MOVE_INTO_BOTTOM : std_logic := '0';
   --signal BL1_MERGE_INTO_LEFT : std_logic := '0';
   signal BL1_MERGE_INTO_RIGHT : std_logic := '0';
   --signal BL1_MERGE_INTO_TOP : std_logic := '0';
   signal BL1_MERGE_INTO_BOTTOM : std_logic := '0';
   --signal BL1_LEFT_TILE : std_logic_vector(11 downto 0) := (others => '0');
   signal BL1_RIGHT_TILE : std_logic_vector(11 downto 0) := (others => '0');
   --signal BL1_TOP_TILE : std_logic_vector(11 downto 0) := (others => '0');
   signal BL1_BOTTOM_TILE : std_logic_vector(11 downto 0) := (others => '0');


 	--Outputs
   signal BL1_VALUE : std_logic_vector(11 downto 0);
   
	signal BL1_ALLOW_MOVE_FROM_LEFT : std_logic;
   --signal BL1_ALLOW_MOVE_FROM_RIGHT : std_logic;
   signal BL1_ALLOW_MOVE_FROM_TOP : std_logic;
   signal BL1_ALLOW_MOVE_FROM_BOTTOM : std_logic;
   signal BL1_ALLOW_MERGE_FROM_LEFT : std_logic;
  -- signal BL1_ALLOW_MERGE_FROM_RIGHT : std_logic;
   signal BL1_ALLOW_MERGE_FROM_TOP : std_logic;
   signal BL1_ALLOW_MERGE_FROM_BOTTOM : std_logic;

------------------BLOCK 2 ---------------------------------------------------	
   signal BL2_INIT : std_logic := '0';

   --signal BL2_MOVE_INTO_LEFT : std_logic := '0';
   signal BL2_MOVE_INTO_RIGHT : std_logic := '0';
  -- signal BL2_MOVE_INTO_TOP : std_logic := '0';
   signal BL2_MOVE_INTO_BOTTOM : std_logic := '0';
  -- signal BL2_MERGE_INTO_LEFT : std_logic := '0';
   signal BL2_MERGE_INTO_RIGHT : std_logic := '0';
  -- signal BL2_MERGE_INTO_TOP : std_logic := '0';
   signal BL2_MERGE_INTO_BOTTOM : std_logic := '0';
   signal BL2_LEFT_TILE : std_logic_vector(11 downto 0) := (others => '0');
   signal BL2_RIGHT_TILE : std_logic_vector(11 downto 0) := (others => '0');
 -- signal BL2_TOP_TILE : std_logic_vector(11 downto 0) := (others => '0');
   signal BL2_BOTTOM_TILE : std_logic_vector(11 downto 0) := (others => '0');


 	--Outputs
   signal BL2_VALUE : std_logic_vector(11 downto 0);
   signal MOVE_BL1_BL2 : std_logic;
	signal MOVE_BL2_BL1 : std_logic;
	
	signal MERGE_BL1_BL2 : std_logic;
	signal MERGE_BL2_BL1 : std_logic;
	
	
   signal BL2_ALLOW_MOVE_FROM_RIGHT : std_logic;
   signal BL2_ALLOW_MOVE_FROM_TOP : std_logic;
   signal BL2_ALLOW_MOVE_FROM_BOTTOM : std_logic;
  -- signal BL2_ALLOW_MERGE_FROM_LEFT : std_logic;
   signal BL2_ALLOW_MERGE_FROM_RIGHT : std_logic;
   signal BL2_ALLOW_MERGE_FROM_TOP : std_logic;
   signal BL2_ALLOW_MERGE_FROM_BOTTOM : std_logic;

constant dirLeft: std_logic_vector 	(1 downto 0) := "00";
constant dirUp: std_logic_vector 	(1 downto 0) := "01";
constant dirRight: std_logic_vector (1 downto 0) := "10";
constant dirDown: std_logic_vector 	(1 downto 0) := "11";

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut1: tile PORT MAP (
          CLK => CLK,
          VALUE => BL1_VALUE,
          DIRECTION => DIRECTION,
          EXECUTE => EXECUTE,
          INIT => BL1_INIT,
          INITVAL => INITVAL,
          ALLOW_MOVE_FROM_LEFT => BL1_ALLOW_MOVE_FROM_LEFT,
          ALLOW_MOVE_FROM_RIGHT => MOVE_BL1_BL2,  --move signal from block 2 to 1
          ALLOW_MOVE_FROM_TOP => BL1_ALLOW_MOVE_FROM_TOP,
          ALLOW_MOVE_FROM_BOTTOM => BL1_ALLOW_MOVE_FROM_BOTTOM,
          MOVE_INTO_LEFT => '0',  --left wall
          MOVE_INTO_RIGHT => MOVE_BL2_BL1, --move signal for block 1 into block 2
          MOVE_INTO_TOP => '0',   -- top wall
          MOVE_INTO_BOTTOM => BL1_MOVE_INTO_BOTTOM,
          ALLOW_MERGE_FROM_LEFT => BL1_ALLOW_MERGE_FROM_LEFT,
          ALLOW_MERGE_FROM_RIGHT => MERGE_BL1_BL2,
          ALLOW_MERGE_FROM_TOP => BL1_ALLOW_MERGE_FROM_TOP,
          ALLOW_MERGE_FROM_BOTTOM => BL1_ALLOW_MERGE_FROM_BOTTOM,
          MERGE_INTO_LEFT => '0', -- left wall
          MERGE_INTO_RIGHT => MERGE_BL2_BL1,
          MERGE_INTO_TOP => '0', --top wall
          MERGE_INTO_BOTTOM => BL1_MERGE_INTO_BOTTOM,
          LEFT_TILE => (others => '0'), --left wall
          RIGHT_TILE => BL2_VALUE,  -- value from block to the right,
          TOP_TILE => (others => '0'), --top wall
          BOTTOM_TILE => BL1_BOTTOM_TILE,
          RESET => RESET
        );
		  
		  
		  
		  
		  uut2: tile PORT MAP (
		 CLK => CLK,
		 VALUE => BL2_VALUE,
		 DIRECTION => DIRECTION,
		 EXECUTE => EXECUTE,
		 INIT => BL2_INIT,
		 INITVAL => INITVAL,
		 ALLOW_MOVE_FROM_LEFT => MOVE_BL2_BL1,
		 ALLOW_MOVE_FROM_RIGHT => BL2_ALLOW_MOVE_FROM_RIGHT,
		 ALLOW_MOVE_FROM_TOP => BL2_ALLOW_MOVE_FROM_TOP,
		 ALLOW_MOVE_FROM_BOTTOM => BL2_ALLOW_MOVE_FROM_BOTTOM,
		 MOVE_INTO_LEFT => MOVE_BL1_BL2,
		 MOVE_INTO_RIGHT => BL2_MOVE_INTO_RIGHT,
		 MOVE_INTO_TOP => '0',
		 MOVE_INTO_BOTTOM => BL2_MOVE_INTO_BOTTOM,
		 ALLOW_MERGE_FROM_LEFT => MERGE_BL2_BL1,
		 ALLOW_MERGE_FROM_RIGHT => BL2_ALLOW_MERGE_FROM_RIGHT,
		 ALLOW_MERGE_FROM_TOP => BL2_ALLOW_MERGE_FROM_TOP,
		 ALLOW_MERGE_FROM_BOTTOM => BL2_ALLOW_MERGE_FROM_BOTTOM,
		 MERGE_INTO_LEFT => MERGE_BL1_BL2,
		 MERGE_INTO_RIGHT => BL2_MERGE_INTO_RIGHT,
		 MERGE_INTO_TOP => '0',
		 MERGE_INTO_BOTTOM => BL2_MERGE_INTO_BOTTOM,
		 LEFT_TILE => BL1_VALUE,
		 RIGHT_TILE => BL2_RIGHT_TILE,
		 TOP_TILE => (others => '0'), --top wall
		 BOTTOM_TILE => BL2_BOTTOM_TILE,
		 RESET => RESET
	  );

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
		DIRECTION <= dirLeft;
		EXECUTE <= '0';
		BL1_INIT <= '0';
		BL2_INIT <= '0';
		RESET <= '1';
		INITVAL <= "000000000010";
	
	
	-- TOP and LEFT are wall so npo move into, or merge into

		
		
		BL1_BOTTOM_TILE <= "000000000000";
		BL2_RIGHT_TILE <= 	"000000000000";
		--MERGE_INTO_RIGHT <='1';

		
      wait for 100 ns;	
		RESET <= '0';
		wait for 100 ns;
		BL1_INIT <= '1';
		wait for 20 ns;
		BL1_INIT <= '0';
		
		-- Action to the left = merge with right block into this one
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		BL2_RIGHT_TILE <= 	"000000000010";
		-- Action to the left = merge with right block into this one
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		BL2_RIGHT_TILE <= 	"000000000000";
		-- Action to the left = merge with right block into this one
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		--Merge from bottom = merge from the bottom block into this one
		wait for 100 ns;
		
		--Merge from bottom = merge from the bottom block into this one
		wait for 100 ns;
		DIRECTION <= dirUp;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		
		wait for 100 ns;
		-- Check move to the right if the right block reports it can be moved into
		-- == this block clears since it is moved into the right block
--		MOVE_INTO_RIGHT <='1';
--		RIGHT_TILE <= "000000000000";
--		wait for 100 ns;
--		DIRECTION <= dirRight;
--		wait for 20 ns;
--		EXECUTE <= '1';
--		wait for 20 ns;
--		EXECUTE <= '0';
--		
--		wait for 100 ns;
--		-- Move UP = move the bottom value in the current one since the value is 0;
--		BOTTOM_TILE <= "000000001000";
--		wait for 100 ns;
--		DIRECTION <= dirUp;
--		wait for 20 ns;
--		EXECUTE <= '1';
--		wait for 20 ns;
--		EXECUTE <= '0';
		
--		wait for 100 ns;
--		DIRECTION <= dirUp;
--		wait for 20 ns;
--		EXECUTE <= '1';
--		wait for 20 ns;
--		EXECUTE <= '0';
		

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
