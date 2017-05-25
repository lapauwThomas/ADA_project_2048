--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:33:17 05/18/2017
-- Design Name:   
-- Module Name:   C:/Users/Steven/Documents/Advanced Digital Architectures/Project/Project2048/LFSR_TB.vhd
-- Project Name:  Project2048
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LFSR
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
--USE ieee.numeric_std.ALL;
use ieee.std_logic_arith.all; --conv_integer
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY LFSR_TB IS
END LFSR_TB;
 
ARCHITECTURE behavior OF LFSR_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LFSR
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
			enable : IN std_logic;
         seed : IN  std_logic_vector(4 downto 0);
		   zero_tiles : in std_logic_vector (15 downto 0);
			value_2_4 : out std_logic_vector( 11 downto 0 ); 
		   location : out std_logic_vector( 15 downto 0 );
			valid : out std_logic;
         output : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
	signal enable : std_logic := '0';
   signal seed : std_logic_vector(4 downto 0) := (others => '0');
	signal zero_tiles : std_logic_vector (15 downto 0);

 	--Outputs
   signal output : std_logic_vector(4 downto 0);
	signal value_2_4 : std_logic_vector( 11 downto 0 ); 
   signal location : std_logic_vector( 15 downto 0 );
	signal valid : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	--Test signals
	----for 5 bit LFSR: 2^5 - 1 (=31) possible outputs
	signal register_output : std_logic_vector( 30 downto 0) := (others => '0'); --signal to test that all outputs occured
	constant ones : std_logic_vector( 30 downto 0) := (others => '1'); --constant to check registered_output against
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LFSR PORT MAP (
          clk => clk,
          reset => reset,
			 enable => enable,
          seed => seed,
			 zero_tiles => zero_tiles,
			 value_2_4 => value_2_4,
			 location => location,
			 valid => valid,
          output => output
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
		seed <= "01101"; 
		zero_tiles <= ( others => '1');
		
		assert value_2_4 = (value_2_4'range => '0') report "LFSR: ERROR in reset";
		assert location = (location'range => '0') report "LFSR: ERROR in reset";
		assert valid = '0' report "LFSR: ERROR in reset";
		assert output = seed report "LFSR: ERROR in reset";

		wait for 10*clk_period;	
		reset <= '0';
		
		wait for clk_period;
		enable <= '1';
		
      -- insert stimulus here 
		
		--wait so that seed is loaded
		wait for clk_period;
		
		
		--1. test for randomness (full length) of LFSR
		for i in 0 to 31 loop
			register_output( conv_integer(unsigned(output)) -1 ) <= '1';
			wait for clk_period;
		end loop;
		
		assert register_output = ones report "ERROR: not all random output combination occured!";
		
		--2. do other tests
		----assume one tile is not zero
		zero_tiles <= "1111"&"1101"&"1111"&"1111";
		wait for clk_period;
		
		--for i in 0 to 31 loop
		--	assert valid = '0' report "Tile is not zero occured";
		--	wait for clk_period;
		--end loop;
		
		--zero_tiles <= "1111"&"1111"&"1111"&"1111";
		
      wait;
   end process;

END;
