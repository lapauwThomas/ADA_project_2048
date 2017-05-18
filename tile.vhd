----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:05:42 05/18/2017 
-- Design Name: 
-- Module Name:    tile - Behavioral 
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

entity tile is

	generic ( busWidth : integer := 12 ); --width on 12 for max value of 2048
	
    Port ( CLK 					: in  STD_LOGIC;
           VALUE 					: out  STD_LOGIC_VECTOR ((busWidth-1) downto 0);
           COMMAND 				: in  STD_LOGIC;
           LEFT_TILE 			: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
           RIGHT_TILE 			: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
           TOP_TILE 				: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
           BOTTOM_TILE 			: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
           DIRECTION 			: in  STD_LOGIC_VECTOR 	(2 downto 0);
           EXECUTE 				: in  STD_LOGIC;
           INIT					: in  STD_LOGIC;
           INITVAL 				: in  STD_LOGIC_VECTOR 	(3 downto 0);

			  
			  ALLOW_FROM_LEFT		: out  STD_LOGIC;
			  ALLOW_FROM_RIGHT	: out  STD_LOGIC;
			  ALLOW_FROM_TOP		: out  STD_LOGIC;
			  ALLOW_FROM_BOTTOM	: out  STD_LOGIC;
			  
			  MOVE_INTO_LEFT		: in  STD_LOGIC;
			  MOVE_INTO_RIGHT		: in  STD_LOGIC;
			  MOVE_INTO_TOP		: in  STD_LOGIC;
			  MOVE_INTO_BOTTOM	: in  STD_LOGIC;
			  
			  RESET 					: in  STD_LOGIC
			  );
end tile;

architecture Behavioral of tile is
-------------------------------------------------------------
type state_type is (s_Reset, s_Idle, s_checkMerge, s_Merge, s_checkMove,  s_Move);
signal currentState ,nextState: state_type;

constant dirLeft: std_logic_vector(1 downto 0) := "00";
constant dirUp: std_logic_vector(1 downto 0) := "01";
constant dirRight: std_logic_vector(1 downto 0) := "10";
constant dirDown: std_logic_vector(1 downto 0) := "11";


begin


---------------------------------------------------------------------------------------------
fsmProcess: process(CLK, RESET,INIT)
begin
	if rising_edge(clk) then
		if RESET = '1' then
			currentState <= s_Reset;
		else
			currentState <= nextState;
		end if;
	end if;
end process fsmProcess;
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
fsmStateLogic: process
begin
	case currentState is
		when s_Reset =>
			-- reset state
			
			
		when s_Idle =>
			--Idle state

		--///////////////////////////////////// CHECK MERGE /////////////////////////////////////	
		when s_checkMerge =>  --move this into a combinatorial block???
			case DIRECTION is
				when dirLeft =>
						if (MOVE_INTO_LEFT = '0'  and VALUE = RIGHT_TILE) then --if block cannot merge into left block, check if can be merged into from right block and let it know
							ALLOW_FROM_RIGHT <= '1';
						else
							ALLOW_FROM_RIGHT <= '0';
						end if;

					
				when dirRight =>					
						if (MOVE_INTO_RIGHT = '0'  and VALUE = LEFT_TILE) then --if block cannot merge into right block, check if can be merged into from right block and let it know
							ALLOW_FROM_LEFT <= '1';
						else
							ALLOW_FROM_LEFT <= '0';
						end if;

					
					
				when dirUp =>
						if (MOVE_INTO_TOP = '0')  and (VALUE = BOTTOM_TILE) then --if block cannot merge into left block, check if can be merged into from right block and let it know
							ALLOW_FROM_BOTTOM <= '1';
						else
							ALLOW_FROM_BOTTOM <= '0';
						end if;



				when dirDown =>
						if (MOVE_INTO_BOTTOM = '0')  and (VALUE = TOP_TILE) then --if block cannot merge into left block, check if can be merged into from right block and let it know
							ALLOW_FROM_TOP <= '1';
						else
							ALLOW_FROM_TOP <= '0';
						end if;

			end case;
			currentState <= s_Merge;
			
		--///////////////////////////////////// MERGE /////////////////////////////////////	
		when s_Merge =>
			case DIRECTION is
				when dirLeft =>
					if  MOVE_INTO_LEFT = '1' then --if block can merge into left block
						VALUE <= ( others => 0); --Clear value if merged into neighbour
					else
						if VALUE = RIGHT_TILE then --can be merged into from right block
							VALUE <= VALUE((busWidth-1) downto 1)&'0'; -- merge is left shift in standard rules
						end if;
						-- No else cause nothing else can happen
					end if;
					
				when dirRight =>					
					if  MOVE_INTO_RIGHT = '1' then --if block can merge into left block
						VALUE <= ( others => 0); --Clear value if merged into neighbour
					else
						if VALUE = LEFT_TILE then --can be merged into from left block
							VALUE <= VALUE((busWidth-1) downto 1)&'0'; -- merge is left shift in standard rules
						end if;
						-- No else cause nothing else can happen
					end if;
					
					
				when dirUp =>
					if  MOVE_INTO_TOP = '1' then --if block can merge into left block
						VALUE <= ( others => 0); --Clear value if merged into neighbour
					else
						if VALUE = BOTTOM_TILE then --can be merged into from top block
							VALUE <= VALUE((busWidth-1) downto 1)&'0'; -- merge is left shift in standard rules
						end if;
						-- No else cause nothing else can happen
					end if;
					

				when dirDown =>
					if  MOVE_INTO_BOTTOM = '1' then --if block can merge into left block
						VALUE <= ( others => 0); --Clear value if merged into neighbour
					else
						if VALUE = TOP_TILE then --can be merged into from top block
							VALUE <= VALUE((busWidth-1) downto 1)&'0'; -- merge is left shift in standard rules
						end if;
						-- No else cause nothing else can happen
					end if;
					
			end case;
			
			nextState <= s_Move;
			
		when s_Move =>
						-- Move state
			case DIRECTION is
				when dirLeft =>
					VALUE <= RIGHT_TILE; --Move the value from the opposite direction in the current tile into the current and shift
				when dirUp =>
					VALUE <= BOTTOM_TILE;
				when dirRight =>
					VALUE <= LEFT_TILE;
				when dirDown =>
					VALUE <= TOP_TILE;
			end case;
			--Do merge
			nextState <= s_Merge;
		
		
		

	end case;
end process fsmStateLogic;
---------------------------------------------------------------------------------------------


end Behavioral;

