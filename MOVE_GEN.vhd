----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:59:56 05/19/2017 
-- Design Name: 
-- Module Name:    MOVE_GEN - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MOVE_GEN is
    Port ( --clk : in  STD_LOGIC;
           --reset : in  STD_LOGIC;
           --enable : in  STD_LOGIC;
			  input_character : STD_LOGIC_VECTOR(7 downto 0); --ASCII representation
           direction : out  STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
			  valid : out STD_LOGIC := '0');
end MOVE_GEN;

architecture Behavioral of MOVE_GEN is

constant dirLeft: std_logic_vector(1 downto 0) := "00";
constant dirUp: std_logic_vector(1 downto 0) := "01";
constant dirRight: std_logic_vector(1 downto 0) := "10";
constant dirDown: std_logic_vector(1 downto 0) := "11";

begin
--	process(clk)
--	begin
--		if ( rising_edge(clk) ) then
--			if reset = '1' then
--				direction <= "00";
--				valid <= '0';
--			else
--				if enable = '1' then
--					case input_character is
--						when x"55" =>  --ASCII: 55 = U 
--							direction <= dirUp;
--							valid <= '1';
--						when x"44" =>  --ASCII: 44 = D 
--							direction <= dirDown;
--							valid <= '1';
--						when x"4C" =>  --ASCII: 4C = L 
--							direction <= dirLeft;
--							valid <= '1';						
--						when x"52" =>  --ASCII: 52 = R 
--							direction <= dirRight;
--							valid <= '1';						
--						when others => --other ASCII characters are not valid
--							valid <= '0';
--					end case;
--				else
--					valid <= '0';
--				end if;
--			end if;			
--		end if;		
--	end process;	

	process(input_character)
	begin
					case input_character is
						when x"55" =>  --ASCII: 55 = U 
							direction <= dirUp;
							valid <= '1';
						when x"44" =>  --ASCII: 44 = D 
							direction <= dirDown;
							valid <= '1';
						when x"4C" =>  --ASCII: 4C = L 
							direction <= dirLeft;
							valid <= '1';						
						when x"52" =>  --ASCII: 52 = R 
							direction <= dirRight;
							valid <= '1';						
						when others => --other ASCII characters are not valid
							valid <= '0';
							direction <="00";
					end case;

	end process;	

end Behavioral;

