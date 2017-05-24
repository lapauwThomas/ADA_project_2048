--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:17:52 05/22/2017
-- Design Name:   
-- Module Name:   C:/Users/Steven/Documents/Advanced Digital Architectures/Project/Project2048/MOVE_GEN_TB.vhd
-- Project Name:  Project2048
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MOVE_GEN
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
 
ENTITY MOVE_GEN_TB IS
END MOVE_GEN_TB;
 
ARCHITECTURE behavior OF MOVE_GEN_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MOVE_GEN
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         enable : IN  std_logic;
         input_character : IN  std_logic_vector(7 downto 0);
         direction : OUT  std_logic_vector(1 downto 0);
         valid : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal enable : std_logic := '0';
   signal input_character : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal direction : std_logic_vector(1 downto 0);
   signal valid : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
	
	constant dirLeft: std_logic_vector(1 downto 0) := "00";
constant dirUp: std_logic_vector(1 downto 0) := "01";
constant dirRight: std_logic_vector(1 downto 0) := "10";
constant dirDown: std_logic_vector(1 downto 0) := "11";

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MOVE_GEN PORT MAP (
          clk => clk,
          reset => reset,
          enable => enable,
          input_character => input_character,
          direction => direction,
          valid => valid
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      reset <= '1';
		enable <= '0';
		input_character <= x"52"; --R
		
		wait for clk_period;
		assert (direction = dirLeft) report "MOVE_GEN: error during reset";
		
		wait for 10*clk_period;
		reset <= '0';
		enable <= '0';
		
		wait for 5*clk_period;
		enable <= '1';

		
		wait for clk_period;
		assert (direction = "11") report "MOVE_GEN: error during right";
		assert (valid = '1') report "MOVE_GEN: error with valid signal";
		input_character <= x"4C"; --L

		
		wait for clk_period;
		assert (direction = "10") report "MOVE_GEN: error during left";
		assert (valid = '1') report "MOVE_GEN: error with valid signal";
		input_character <= x"44"; --D	

		
		wait for clk_period;
		assert (direction = "01") report "MOVE_GEN: error during down";
		assert (valid = '1') report "MOVE_GEN: error with valid signal";
		input_character <= x"55"; --U	

		
		wait for clk_period;
		assert (direction = dirLeft) report "MOVE_GEN: error during left";
		assert (valid = '1') report "MOVE_GEN: error with valid signal";
		input_character <= x"00"; --INVALID

		
		wait for clk_period;
		assert (valid = '0') report "MOVE_GEN: error with valid signal";
		input_character <= x"20"; --INVALID

		
		wait for clk_period;
		assert (valid = '0') report "MOVE_GEN: error with valid signal";
		input_character <= x"44"; --D	

		
		wait for clk_period;
		assert (direction = "01") report "MOVE_GEN: error during down";
		assert (valid = '1') report "MOVE_GEN: error with valid signal";		
		enable <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
