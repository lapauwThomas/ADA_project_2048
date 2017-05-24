--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:12:37 05/24/2017
-- Design Name:   
-- Module Name:   C:/Users/thoma/CloudStation/School/2MA/semester2/ADA/labs/project/TB_board.vhd
-- Project Name:  project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: board_4x4
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
 
ENTITY TB_board IS
END TB_board;
 
ARCHITECTURE behavior OF TB_board IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT board_4x4
    PORT(
         CLK : IN  std_logic;
         INITVAL : IN  std_logic_vector(11 downto 0);
         DIRECTION : IN  std_logic_vector(1 downto 0);
         EXECUTE : IN  std_logic;
         RESET : IN  std_logic;
         INITLOC : IN  std_logic_vector(15 downto 0);
         ISZERO_VECT : OUT  std_logic_vector(15 downto 0);
         OUT_VALUE_BL11 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL12 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL13 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL14 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL21 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL22 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL23 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL24 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL31 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL32 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL33 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL34 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL41 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL42 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL43 : OUT  std_logic_vector(11 downto 0);
         OUT_VALUE_BL44 : OUT  std_logic_vector(11 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal INITVAL : std_logic_vector(11 downto 0) := (others => '0');
   signal DIRECTION : std_logic_vector(1 downto 0) := (others => '0');
   signal EXECUTE : std_logic := '0';
   signal RESET : std_logic := '0';
   signal INITLOC : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal ISZERO_VECT : std_logic_vector(15 downto 0);
   signal OUT_VALUE_BL11 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL12 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL13 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL14 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL21 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL22 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL23 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL24 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL31 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL32 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL33 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL34 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL41 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL42 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL43 : std_logic_vector(11 downto 0);
   signal OUT_VALUE_BL44 : std_logic_vector(11 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
	
		
constant dirLeft: std_logic_vector(1 downto 0) := "00";
constant dirUp: std_logic_vector(1 downto 0) := "01";
constant dirRight: std_logic_vector(1 downto 0) := "10";
constant dirDown: std_logic_vector(1 downto 0) := "11";


 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: board_4x4 PORT MAP (
          CLK => CLK,
          INITVAL => INITVAL,
          DIRECTION => DIRECTION,
          EXECUTE => EXECUTE,
          RESET => RESET,
          INITLOC => INITLOC,
          ISZERO_VECT => ISZERO_VECT,
          OUT_VALUE_BL11 => OUT_VALUE_BL11,
          OUT_VALUE_BL12 => OUT_VALUE_BL12,
          OUT_VALUE_BL13 => OUT_VALUE_BL13,
          OUT_VALUE_BL14 => OUT_VALUE_BL14,
          OUT_VALUE_BL21 => OUT_VALUE_BL21,
          OUT_VALUE_BL22 => OUT_VALUE_BL22,
          OUT_VALUE_BL23 => OUT_VALUE_BL23,
          OUT_VALUE_BL24 => OUT_VALUE_BL24,
          OUT_VALUE_BL31 => OUT_VALUE_BL31,
          OUT_VALUE_BL32 => OUT_VALUE_BL32,
          OUT_VALUE_BL33 => OUT_VALUE_BL33,
          OUT_VALUE_BL34 => OUT_VALUE_BL34,
          OUT_VALUE_BL41 => OUT_VALUE_BL41,
          OUT_VALUE_BL42 => OUT_VALUE_BL42,
          OUT_VALUE_BL43 => OUT_VALUE_BL43,
          OUT_VALUE_BL44 => OUT_VALUE_BL44
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
       wait for 100 ns;	
		RESET <= '1';
		wait for 100 ns;	
		RESET <= '0';
		
		INITVAL <= "000000000010";
		wait for 10 ns;
		INITLOC <= "1000" & "0000" & "0000" & "0000" ;
		wait for 20 ns;
		INITLOC <= "0000" & "0000" & "0000" & "0000" ;	
		wait for 100 ns;
		
		INITVAL <= "000000000010";
		wait for 10 ns;
		INITLOC <= "0000" & "0000" & "0010" & "0000" ;
		wait for 20 ns;
		INITLOC <= "0000" & "0000" & "0000" & "0000" ;	
		wait for 100 ns;
		
		
		INITVAL <= "000000000100";
		wait for 10 ns;
		INITLOC <= "0000" & "0000" & "0000" & "0001" ;
		wait for 20 ns;
		INITLOC <= "0000" & "0000" & "0000" & "0000" ;	
		wait for 100 ns;
		
		DIRECTION <= dirLEFT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
		
--		INITVAL <= "000000000010";
--		wait for 10 ns;
--		INIT_BL2 <= '1';
--		wait for 20 ns;
--		INIT_BL2 <= '0';	
--		wait for 100 ns;
--		
		
		DIRECTION <= dirLEFT;
		wait for 20 ns;
		EXECUTE <= '1';
		wait for 20 ns;
		EXECUTE <= '0';
		wait for 100 ns;
		
--		INITVAL <= "000000000100";
--		wait for 10 ns;
--		INIT_BL2 <= '1';
--		wait for 20 ns;
--		INIT_BL2 <= '0';	
--		wait for 100 ns;
--		
		
		DIRECTION <= dirUP;
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
		
				DIRECTION <= dirDOWN;
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
		
--		
--				INITVAL <= "000000000010";
--		wait for 10 ns;
--		INIT_BL1 <= '1';
--		wait for 20 ns;
--		INIT_BL1 <= '0';	
--		wait for 100 ns;
		
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
		
--				
--				INITVAL <= "000000001000";
--		wait for 10 ns;
--		INIT_BL1 <= '1';
--		wait for 20 ns;
--		INIT_BL1 <= '0';	
--		wait for 100 ns;
		
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
		wait for 100 ns;      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
