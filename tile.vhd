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
          -- COMMAND 				: in  STD_LOGIC;

           DIRECTION 			: in  STD_LOGIC_VECTOR 	(1 downto 0);
			  
           EXECUTE 				: in  STD_LOGIC;
			  
           INIT					: in  STD_LOGIC;
           INITVAL 				: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);

			  
			  ALLOW_MOVE_FROM_LEFT		: out  STD_LOGIC;
			  ALLOW_MOVE_FROM_RIGHT		: out  STD_LOGIC;
			  ALLOW_MOVE_FROM_TOP		: out  STD_LOGIC;
			  ALLOW_MOVE_FROM_BOTTOM	: out  STD_LOGIC;
			  
			  MOVE_INTO_LEFT		: in  STD_LOGIC;
			  MOVE_INTO_RIGHT		: in  STD_LOGIC;
			  MOVE_INTO_TOP		: in  STD_LOGIC;
			  MOVE_INTO_BOTTOM	: in  STD_LOGIC;
			  
			  ALLOW_MERGE_FROM_LEFT			: out  STD_LOGIC;
			  ALLOW_MERGE_FROM_RIGHT		: out  STD_LOGIC;
			  ALLOW_MERGE_FROM_TOP			: out  STD_LOGIC;
			  ALLOW_MERGE_FROM_BOTTOM		: out  STD_LOGIC;
			  
			  MERGE_INTO_LEFT		: in  STD_LOGIC;
			  MERGE_INTO_RIGHT	: in  STD_LOGIC;
			  MERGE_INTO_TOP		: in  STD_LOGIC;
			  MERGE_INTO_BOTTOM	: in  STD_LOGIC;
			  
			  
			  LEFT_TILE 			: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
           RIGHT_TILE 			: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
           TOP_TILE 				: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
           BOTTOM_TILE 			: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
			  
			  RESET 					: in  STD_LOGIC
			  );
end tile;

architecture Behavioral of tile is
-------------------------------------------------------------
type state_type is (s_Reset, s_Init, s_Idle, s_CheckMerge, s_Merge, s_CheckMove, s_Move);
signal currentState:state_type := s_Reset;
signal nextState: state_type := s_Idle;

constant dirLeft: std_logic_vector(1 downto 0) := "00";
constant dirUp: std_logic_vector(1 downto 0) := "01";
constant dirRight: std_logic_vector(1 downto 0) := "10";
constant dirDown: std_logic_vector(1 downto 0) := "11";

constant zeroes: std_logic_vector((busWidth-1) downto 0) := (others => '0');

signal sigVALUE: std_logic_vector ((busWidth-1) downto 0);
signal sigVALUE_REG: std_logic_vector ((busWidth-1) downto 0);
signal canDoMove: std_logic;

begin


---------------------------------------------------------------------------------------------
fsmProcess: process(CLK, RESET,INIT)
begin
	if rising_edge(clk) then
		if RESET = '1' then -- reset state
			currentState <= s_Reset;
		elsif INIT = '1' then --goto init state
			currentState <= s_Init;
		else
			currentState <= nextState;
			sigVALUE_REG <= sigVALUE;
		end if;
	end if;
end process fsmProcess;
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
fsmStateLogic: process(currentState, canDoMove, sigVALUE_REG, INITVAL, EXECUTE, DIRECTION, MERGE_INTO_LEFT, RIGHT_TILE, MERGE_INTO_RIGHT, LEFT_TILE, MERGE_INTO_TOP, BOTTOM_TILE, MERGE_INTO_BOTTOM, TOP_TILE)
begin
	case currentState is
		
		when s_Reset =>
			sigVALUE <= (others => '0'); --reset tile value
			nextState <= s_Idle; -- prepare next state. This is only executed if reset is not high

			
		when s_Init =>
			sigVALUE <= INITVAL;
			nextState <= s_Idle;
			
			
		when s_Idle =>
			if(EXECUTE = '1') then -- wait for newMove trigger
				nextState <= s_Merge;
			else
				nextState <= s_Idle;
			end if;
			sigVALUE <= sigVALUE_REG;
			
			--Idle state

		--///////////////////////////////////// MERGE /////////////////////////////////////	
		when s_Merge =>
			case DIRECTION is
				when dirLeft =>
					if  MERGE_INTO_LEFT = '1' then --if block can merge into left block
						sigVALUE <= ( others => '0'); --Clear value if merged into neighbour
					elsif sigVALUE_REG = RIGHT_TILE then --can be merged into from right block
						sigVALUE <= sigVALUE_REG((busWidth-1) downto 1)&'0'; -- merge is left shift in standard rules
					else
						sigVALUE <= sigVALUE_REG;
					end if;

					
				when dirRight =>					
					if  MERGE_INTO_RIGHT = '1' then --if block can merge into left block
						sigVALUE <= ( others => '0'); --Clear value if merged into neighbour
					elsif sigVALUE_REG = LEFT_TILE then --can be merged into from left block
							sigVALUE <= sigVALUE_REG((busWidth-1) downto 1)&'0'; -- merge is left shift in standard rules
					else
						sigVALUE <= sigVALUE_REG;
					end if;
					
					
				when dirUp =>
					if  MERGE_INTO_TOP = '1' then --if block can merge into left block
						sigVALUE <= ( others => '0'); --Clear value if merged into neighbour
					elsif sigVALUE_REG = BOTTOM_TILE then --can be merged into from top block
						sigVALUE <= sigVALUE_REG((busWidth-1) downto 1)&'0'; -- merge is left shift in standard rules
					else
						sigVALUE <= sigVALUE_REG;
					end if;
					

				when dirDown =>
					if  MERGE_INTO_BOTTOM = '1' then --if block can merge into left block
						sigVALUE <= ( others => '0'); --Clear value if merged into neighbour
					elsif sigVALUE_REG = TOP_TILE then --can be merged into from top block
							sigVALUE <= sigVALUE_REG((busWidth-1) downto 1)&'0'; -- merge is left shift in standard rules
					else
						sigVALUE <= sigVALUE_REG;
					end if;
					
				when others =>
					sigVALUE <= sigVALUE_REG;
					
			end case;
			
			nextState <= s_CheckMove;
			
		when s_CheckMove =>
			if (canDoMove ='1') then --if more moves can be done do moves
					nextState <= s_Move;
			else
				nextState <= s_Idle;	--if no more moves are possible go to idle state
			end if;
			sigVALUE <= sigVALUE_REG;
			
--///////////////////////////////////// Move /////////////////////////////////////				
		when s_Move =>
						-- Move state
	
			case DIRECTION is
				when dirLeft =>
					sigVALUE <= RIGHT_TILE;
					
				when dirUp =>
					sigVALUE <= BOTTOM_TILE;
					
				when dirRight =>
					sigVALUE <= LEFT_TILE;
					
				when dirDown =>
					sigVALUE <= TOP_TILE;
					
				when others =>
					--nothing
			end case;
			nextState <= s_CheckMove;
			sigVALUE <= sigVALUE_REG;
			
			
--///////////////////////////////////// OTHERS /////////////////////////////////////			
		when others => --if into unknown state go to reset state
			nextState <= s_Reset;
		sigVALUE <= sigVALUE_REG;
		

	end case;
end process fsmStateLogic;

VALUE <= sigVALUE_REG;
---------------------------------------------------------------------------------------------
moveChecks:process(DIRECTION, MOVE_INTO_LEFT, MOVE_INTO_RIGHT, MOVE_INTO_TOP, MOVE_INTO_BOTTOM, LEFT_TILE, TOP_TILE, RIGHT_TILE, BOTTOM_TILE)
begin

		if ((LEFT_TILE = zeroes) or (MOVE_INTO_LEFT = '1')) then  --if the tile to the left is empty it will absorb the current value, set own value to zero
			ALLOW_MOVE_FROM_RIGHT <= '1';
		else
			ALLOW_MOVE_FROM_RIGHT <= '0';
		end if;
		
		if ((TOP_TILE = zeroes) or (MOVE_INTO_TOP = '1')) then  --if the tile to the left is empty it will absorb the current value, set own value to zero
			ALLOW_MOVE_FROM_BOTTOM <= '1';
		else
			ALLOW_MOVE_FROM_BOTTOM <= '0';
		end if;

		if ((RIGHT_TILE = zeroes) or (MOVE_INTO_RIGHT = '1')) then  --if the tile to the left is empty it will absorb the current value, set own value to zero
			ALLOW_MOVE_FROM_LEFT <= '1';
		else
			ALLOW_MOVE_FROM_LEFT <= '0';
		end if;
		
		if ((BOTTOM_TILE = zeroes) or (MOVE_INTO_BOTTOM = '1')) then  --if the tile to the left is empty it will absorb the current value, set own value to zero
			ALLOW_MOVE_FROM_TOP <= '1';
		else
			ALLOW_MOVE_FROM_TOP <= '0';
		end if;
		
		if( (LEFT_TILE = zeroes) or (MOVE_INTO_LEFT = '1') or (TOP_TILE = zeroes) or (MOVE_INTO_TOP = '1') or (RIGHT_TILE = zeroes) or (MOVE_INTO_RIGHT = '1') or (BOTTOM_TILE = zeroes) or (MOVE_INTO_BOTTOM = '1')) then
				canDoMove <= '1';
		else
				canDoMove <= '0';
		end if;
	
end process moveChecks;

mergeChecks: process(sigVALUE, DIRECTION, MERGE_INTO_LEFT, MERGE_INTO_RIGHT, MERGE_INTO_TOP, MERGE_INTO_BOTTOM, TOP_TILE, LEFT_TILE, BOTTOM_TILE, RIGHT_TILE)
begin

		if (MERGE_INTO_LEFT = '0'  and sigVALUE = RIGHT_TILE) then --if block cannot merge into left block, check if can be merged into from right block and let it know
			ALLOW_MERGE_FROM_RIGHT <= '1';
		else
			ALLOW_MERGE_FROM_RIGHT <= '0';
		end if;

		if (MERGE_INTO_RIGHT = '0'  and sigVALUE = LEFT_TILE) then --if block cannot merge into right block, check if can be merged into from right block and let it know
			ALLOW_MERGE_FROM_LEFT <= '1';
		else
			ALLOW_MERGE_FROM_LEFT <= '0';
		end if;

		if (MERGE_INTO_TOP = '0')  and (sigVALUE = BOTTOM_TILE) then --if block cannot merge into left block, check if can be merged into from right block and let it know
			ALLOW_MERGE_FROM_BOTTOM <= '1';
		else
			ALLOW_MERGE_FROM_BOTTOM <= '0';
		end if;

		if (MERGE_INTO_BOTTOM = '0')  and (sigVALUE = TOP_TILE) then --if block cannot merge into left block, check if can be merged into from right block and let it know
			ALLOW_MERGE_FROM_TOP <= '1';
		else
			ALLOW_MERGE_FROM_TOP <= '0';
		end if;

end process mergeChecks;


end Behavioral;

