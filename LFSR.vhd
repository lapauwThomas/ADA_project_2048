----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:03:31 05/18/2017 
-- Design Name: 
-- Module Name:    LFSR - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all; --conv_integer

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LFSR is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  enable : in STD_LOGIC;
           seed : in  STD_LOGIC_VECTOR ( 4 downto 0);
			  zero_tiles : in std_logic_vector (15 downto 0); --16 parallel lines, '1' indicates value inside block is zero; '0' indicates value inside block is non-zero
			  value_2_4 : out std_logic_vector( 11 downto 0 ) := (others => '0'); --either "0..010" (2) or "0..100" (4)
			  location : out std_logic_vector( 15 downto 0 ) := (others => '0') ; --16 parallel lines from which one is '1' at a given time and indicating the block to write random value in
           valid : out std_logic := '0';
			  output : out  STD_LOGIC_VECTOR ( 4 downto 0) := (others => '0') ); --only used in testbench
end LFSR;

architecture Behavioral of LFSR is

signal internal_LFSR : std_logic_vector( 4 downto 0 ) := (others => '0');
signal location_internal : std_logic_vector( 15 downto 0 ) := (others => '0');

begin
	process(clk)
	begin
		if( rising_edge(clk) ) then
			if (reset = '1') then
				--at reset the seed is loaded
				internal_LFSR <= seed;
				--value_2_4 <= (others => '0');
				--location <= (others => '0');
				--valid <= '0';
			else
				if (enable = '1' ) then
					
					--LFSR core
					----shift register
					internal_LFSR( 4 downto 1 ) <= internal_LFSR( 3 downto 0 );
					----feedback tabs for 5bit
					internal_LFSR(0) <= ( internal_LFSR(1) xor internal_LFSR(4) );
					
					--output
					--output <= internal_LFSR( 4 downto 0 );			
--					location <= location_internal AND zero_tiles;
					
					--if location generated, contains a non-zero element -> valid = '0'
					--else -> valid = '1'
--					if ( location_internal AND zero_tiles ) = (location_internal'range => '0') then
--						valid <= '0';
--					else 
--						valid <= '1';
--					end if; --valid
					
					--generate a 2 or 4 value, depending on the last bit of the LFSR value
--					case internal_LFSR(4) is
--							when '0' => value_2_4 <= (1 => '1' , others => '0');
--							when '1' => value_2_4 <= (2 => '1' , others => '0');
--							when others => value_2_4 <= (others => '0');
--					end case;		
						
				end if; --enable
			end if; --reset
		end if; --clk
	end process;
			
			
	output <= internal_LFSR( 4 downto 0 );	
	--location_internal <= ( conv_integer( unsigned( internal_LFSR( 3 downto 0 ) ) ) => '1' , others => '0' );
	--location_internal <= ((others => '0')&'1' ) srl to_integer(unsigned( internal_LFSR( 3 downto 0 )));
	location <= location_internal AND zero_tiles;
	
	with internal_LFSR(4) select value_2_4 <=
		(1 => '1' , others => '0') when '0',
		(2 => '1' , others => '0') when '1',
		(others => '0')				when others;
		
		
	with (location_internal AND zero_tiles) select valid <=
		'0' when (location_internal'range => '0'),
		'1' when others;	

 with internal_LFSR(3 downto 0) select location_internal <=
			"0000000000000001" 	when "0000",
			"0000000000000010"	when "0001",
			"0000000000000100"	when "0010",
			"0000000000001000"	when "0011",
			"0000000000010000"	when "0100",
			"0000000000100000"	when "0101",
			"0000000001000000"	when "0110",
			"0000000010000000"	when "0111",
			"0000000100000000"	when "1000",
			"0000001000000000"	when "1001",
			"0000010000000000"	when "1010",
			"0000100000000000"	when "1011",
			"0001000000000000"	when "1100",
			"0010000000000000"	when "1101",
			"0100000000000000"	when "1110",
			"1000000000000000"	when "1111",
		(others => '0')				when others;
end Behavioral;

