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
USE ieee.std_logic_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tile is

	generic ( busWidth : integer := 12 ; boardSize : integer := 4 ); --width on 12 for max value of 2048
	
    Port ( CLK 					: in  STD_LOGIC;
	 
           VALUE 					: out  STD_LOGIC_VECTOR ((busWidth-1) downto 0);
          -- COMMAND 				: in  STD_LOGIC;

           DIRECTION 			: in  STD_LOGIC_VECTOR 	(1 downto 0);
			  
           EXECUTE 				: in  STD_LOGIC;

           INIT					: in  STD_LOGIC;
           INITVAL 				: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
			  
			  ISZERO : out std_logic;
			  ISIDLE: out std_logic;
			  CANMOVE: out std_logic_vector(3 downto 0);

			  
			  MOVE_OUT_LEFT		: OUT  STD_LOGIC_VECTOR 	(1 downto 0);
			  MOVE_OUT_RIGHT		: OUT  STD_LOGIC_VECTOR 	(1 downto 0);
			  MOVE_OUT_TOP			: OUT  STD_LOGIC_VECTOR 	(1 downto 0);
			  MOVE_OUT_BOTTOM		: OUT  STD_LOGIC_VECTOR 	(1 downto 0);
			  
			  MOVE_IN_LEFT			: in  STD_LOGIC_VECTOR 	(1 downto 0);
			  MOVE_IN_RIGHT		: in  STD_LOGIC_VECTOR 	(1 downto 0);
			  MOVE_IN_TOP			: in  STD_LOGIC_VECTOR 	(1 downto 0);
			  MOVE_IN_BOTTOM		: in  STD_LOGIC_VECTOR 	(1 downto 0);
			  
			  LEFT_TILE 			: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
           RIGHT_TILE 			: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
           TOP_TILE 				: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
           BOTTOM_TILE 			: in  STD_LOGIC_VECTOR 	((busWidth-1) downto 0);
			  
			  RESET 					: in  STD_LOGIC
			  );
end tile;

architecture Behavioral of tile is
-------------------------------------------------------------
type state_type is (s_Reset, s_Init, s_Idle, s_CheckMove_preMerge, s_Move_preMerge, s_Merge, s_CheckMove_postMerge, s_Move_postMerge);
signal currentState:state_type := s_Reset;
signal nextState: state_type := s_Idle;

constant dirLeft: std_logic_vector(1 downto 0) := "00";
constant dirUp: std_logic_vector(1 downto 0) := "01";
constant dirRight: std_logic_vector(1 downto 0) := "10";
constant dirDown: std_logic_vector(1 downto 0) := "11";

constant zeroes: std_logic_vector((busWidth-1) downto 0) := (others => '0');
constant ones: std_logic_vector((busWidth-1) downto 0) := (others => '1');

signal sigVALUE: std_logic_vector ((busWidth-1) downto 0);
signal sigVALUE_REG: std_logic_vector ((busWidth-1) downto 0);
signal ISZERO_sig: std_logic;



signal ALLOW_MOVE_FROM_LEFT		:   STD_LOGIC;
signal ALLOW_MOVE_FROM_RIGHT		:   STD_LOGIC;
signal ALLOW_MOVE_FROM_TOP			:   STD_LOGIC;
signal ALLOW_MOVE_FROM_BOTTOM		:   STD_LOGIC;
signal ALLOW_MERGE_FROM_LEFT		:   STD_LOGIC;
signal ALLOW_MERGE_FROM_RIGHT		:   STD_LOGIC;
signal ALLOW_MERGE_FROM_TOP		:   STD_LOGIC;
signal ALLOW_MERGE_FROM_BOTTOM	:   STD_LOGIC;

signal  		MOVE_INTO_LEFT			:   STD_LOGIC;
signal	  	MOVE_INTO_RIGHT		:   STD_LOGIC;
signal	  	MOVE_INTO_TOP			:   STD_LOGIC;
signal	  	MOVE_INTO_BOTTOM		: 	 STD_LOGIC;
			  

			  
signal	  MERGE_INTO_LEFT		:   STD_LOGIC;
signal	  MERGE_INTO_RIGHT	:   STD_LOGIC;
signal	  MERGE_INTO_TOP		:   STD_LOGIC;
signal	  MERGE_INTO_BOTTOM	:   STD_LOGIC;

signal COUNTER_enable: STD_LOGIC;


signal counter: integer :=0;

constant maxMoves_preMerge : integer := boardSize-2;
constant maxMoves_postMerge : integer := boardSize/2;

			  

begin
--merging of signals into vector for easier top level interconnect
MOVE_OUT_LEFT 		<= ALLOW_MOVE_FROM_LEFT & ALLOW_MERGE_FROM_LEFT;
MOVE_OUT_RIGHT 	<= ALLOW_MOVE_FROM_RIGHT & ALLOW_MERGE_FROM_RIGHT;
MOVE_OUT_TOP 		<= ALLOW_MOVE_FROM_TOP & ALLOW_MERGE_FROM_TOP;
MOVE_OUT_BOTTOM	<= ALLOW_MOVE_FROM_BOTTOM & ALLOW_MERGE_FROM_BOTTOM;

MOVE_INTO_LEFT		<= MOVE_IN_LEFT(1);
MOVE_INTO_RIGHT	<= MOVE_IN_RIGHT(1);	
MOVE_INTO_TOP		<= MOVE_IN_TOP(1);	
MOVE_INTO_BOTTOM	<= MOVE_IN_BOTTOM(1);	
MERGE_INTO_LEFT	<= MOVE_IN_LEFT(0);
MERGE_INTO_RIGHT	<= MOVE_IN_RIGHT(0);
MERGE_INTO_TOP		<= MOVE_IN_TOP(0);
MERGE_INTO_BOTTOM	<= MOVE_IN_BOTTOM(0);

---------------------------------------------------------------------------------------------
fsmProcess: process(CLK, RESET,INIT)
begin
	if rising_edge(clk) then
		if RESET = '1' then -- reset state
			currentState <= s_Reset;
			sigVALUE_REG <= (OTHERS => '0');
			counter <= 0;
	
		else
			currentState <= nextState;
			sigVALUE_REG <= sigVALUE;
			if counter_enable = '0' then
				counter <= 0;
			else
				counter <= counter +1;
			end if;
		end if;
	end if;
end process fsmProcess;
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
fsmStateLogic: process(currentState, sigVALUE_REG, INITVAL, EXECUTE, DIRECTION, MERGE_INTO_LEFT, RIGHT_TILE, MERGE_INTO_RIGHT, 
								LEFT_TILE, MERGE_INTO_TOP, BOTTOM_TILE, MERGE_INTO_BOTTOM, TOP_TILE,    
								MOVE_INTO_LEFT, MOVE_INTO_TOP, MOVE_INTO_RIGHT, MOVE_INTO_BOTTOM, counter, INIT)
begin
	counter_enable <= '0'; --default value
	ISIDLE<= '0'; --default value
	case currentState is
		
		when s_Reset =>
			sigVALUE <= (others => '0'); --reset tile value
			nextState <= s_Idle; -- prepare next state. This is only executed if reset is not high
			
			
			
		when s_Init =>
			sigVALUE <= INITVAL;
			nextState <= s_Idle;

			
		when s_Idle =>
			ISIDLE<= '1';
			if(EXECUTE = '1') then -- wait for newMove trigger
				nextState <= s_Move_preMerge;
				counter_enable <= '1';
			elsif (INIT = '1') then --goto init state
				nextState <= s_Init;
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
						--sigVALUE <= sigVALUE_REG((busWidth-1) downto 1)&'0'; -- merge is left shift in standard rules
						sigVALUE <= conv_std_logic_vector( unsigned(sigVALUE_REG) + unsigned(RIGHT_TILE), busWidth);
					else
						sigVALUE <= sigVALUE_REG;
					end if;

					
				when dirRight =>					
					if  MERGE_INTO_RIGHT = '1' then --if block can merge into left block
						sigVALUE <= ( others => '0'); --Clear value if merged into neighbour
					elsif sigVALUE_REG = LEFT_TILE then --can be merged into from left block
							sigVALUE <= conv_std_logic_vector( unsigned(sigVALUE_REG) + unsigned(LEFT_TILE), busWidth);
					else
						sigVALUE <= sigVALUE_REG;
					end if;
					
					
				when dirUp =>
					if  MERGE_INTO_TOP = '1' then --if block can merge into left block
						sigVALUE <= ( others => '0'); --Clear value if merged into neighbour
					elsif sigVALUE_REG = BOTTOM_TILE then --can be merged into from top block
						sigVALUE <= conv_std_logic_vector( unsigned(sigVALUE_REG) + unsigned(BOTTOM_TILE), busWidth);
					else
						sigVALUE <= sigVALUE_REG;
					end if;
					

				when dirDown =>
					if  MERGE_INTO_BOTTOM = '1' then --if block can merge into left block
						sigVALUE <= ( others => '0'); --Clear value if merged into neighbour
					elsif sigVALUE_REG = TOP_TILE then --can be merged into from top block
							sigVALUE <= conv_std_logic_vector( unsigned(sigVALUE_REG) + unsigned(TOP_TILE), busWidth);
					else
						sigVALUE <= sigVALUE_REG;
					end if;
					
				when others =>
					sigVALUE <= sigVALUE_REG;
					
			end case;
			nextState <= s_Move_postMerge;
			counter_enable <= '1';
			
--		when s_CheckMove_preMerge =>
--					if ( counter <= maxMoves_preMerge) then  --if the tile is zero or if the tile to the left can move let the neighbour move the values
--					nextState <= s_Move_preMerge;
--					else 
--					nextState <= s_Merge;
--					end if;
--			sigVALUE <= sigVALUE_REG;
--			
--///////////////////////////////////// Move /////////////////////////////////////				
		when s_Move_preMerge =>
						-- Move state -- only reached when not done moving in applicable direction is applicable
			case DIRECTION is
				when dirLeft =>
					if ((sigVALUE_REG = zeroes) or (MOVE_INTO_LEFT = '1')) then  --if the tile is zero or if the tile to the left can move let the neighbour move the values
						if(RIGHT_TILE = ones) then
							sigVALUE <= zeroes;
						else
							sigVALUE <= RIGHT_TILE;
						end if;
					else 
					sigVALUE <= sigVALUE_REG;
					end if;
					
				when dirUp =>
					if ((sigVALUE_REG = zeroes) or (MOVE_INTO_TOP = '1')) then  --if the tile is zero or if the tile to the left can move let the neighbour move the values
						if(BOTTOM_TILE = ones) then
							sigVALUE <= zeroes;
						else
							sigVALUE <= BOTTOM_TILE;
						end if;
					else 
					sigVALUE <= sigVALUE_REG;
					end if;
					
				when dirRight =>
					if ((sigVALUE_REG = zeroes) or (MOVE_INTO_RIGHT = '1')) then  --if the tile is zero or if the tile to the left can move let the neighbour move the values
						if(LEFT_TILE = ones) then
							sigVALUE <= zeroes;
						else
							sigVALUE <= LEFT_TILE;
						end if;
					else 
					sigVALUE <= sigVALUE_REG;
					end if;
					
				when dirDown =>
					if ((sigVALUE_REG = zeroes) or (MOVE_INTO_BOTTOM = '1')) then  --if the tile is zero or if the tile to the left can move let the neighbour move the values
						if(TOP_TILE = ones) then
							sigVALUE <= zeroes;
						else
							sigVALUE <= TOP_TILE;
						end if;
					else 
					sigVALUE <= sigVALUE_REG;
					end if;
					
				when others =>
					sigVALUE <= sigVALUE_REG;
					--nothing
			end case;
			
			if ( counter < maxMoves_preMerge) then 
				nextState <= s_Move_preMerge;
				counter_enable <= '1';
			else 
				nextState <= s_Merge;
				counter_enable <= '0';
			end if;
--			nextState <= s_CheckMove_preMerge;
		
			
			
--		when s_CheckMove_postMerge =>
--				if ( counter < maxMoves_postMerge) then  --if the tile is zero or if the tile to the left can move let the neighbour move the values
--					nextState <= s_Move_postMerge;
--					counter <= counter+1;
--				else 
--					nextState <= s_Merge;
--				end if;
--				sigVALUE <= sigVALUE_REG;
				
			
		when s_Move_postMerge =>
						-- Move state -- only reached when not done moving in applicable direction is applicable
	
			case DIRECTION is
				when dirLeft =>
					if ((sigVALUE_REG = zeroes) or (MOVE_INTO_LEFT = '1')) then  --if the tile is zero or if the tile to the left can move let the neighbour move the values
						if(RIGHT_TILE = ones) then
							sigVALUE <= zeroes;
						else
							sigVALUE <= RIGHT_TILE;
						end if;
					else 
					sigVALUE <= sigVALUE_REG;
					end if;
					
				when dirUp =>
					if ((sigVALUE_REG = zeroes) or (MOVE_INTO_TOP = '1')) then  --if the tile is zero or if the tile to the left can move let the neighbour move the values
						if(BOTTOM_TILE = ones) then
							sigVALUE <= zeroes;
						else
							sigVALUE <= BOTTOM_TILE;
						end if;
					else 
					sigVALUE <= sigVALUE_REG;
					end if;
					
				when dirRight =>
					if ((sigVALUE_REG = zeroes) or (MOVE_INTO_RIGHT = '1')) then  --if the tile is zero or if the tile to the left can move let the neighbour move the values
						if(LEFT_TILE = ones) then
							sigVALUE <= zeroes;
						else
							sigVALUE <= LEFT_TILE;
						end if;
					else 
					sigVALUE <= sigVALUE_REG;
					end if;
					
				when dirDown =>
					if ((sigVALUE_REG = zeroes) or (MOVE_INTO_BOTTOM = '1')) then  --if the tile is zero or if the tile to the left can move let the neighbour move the values
						if(TOP_TILE = ones) then
							sigVALUE <= zeroes;
						else
							sigVALUE <= TOP_TILE;
						end if;
					else 
					sigVALUE <= sigVALUE_REG;
					end if;
					
				when others =>
					sigVALUE <= sigVALUE_REG;
					--nothing
			end case;
			
								


			if ( counter < maxMoves_postMerge) then 
				nextState <= s_Move_postMerge;
				counter_enable <= '1';
			else 
				nextState <= s_Idle;
				counter_enable <= '0';
			end if;

--///////////////////////////////////// OTHERS /////////////////////////////////////			
		when others => --if into unknown state go to reset state
			nextState <= s_Reset;
			sigVALUE <= sigVALUE_REG;

		

	end case;
end process fsmStateLogic;

VALUE <= sigVALUE_REG;
---------------------------------------------------------------------------------------------
moveChecks:process(sigVALUE_REG, MOVE_INTO_LEFT, MOVE_INTO_RIGHT, MOVE_INTO_TOP, MOVE_INTO_BOTTOM, LEFT_TILE, TOP_TILE, RIGHT_TILE, BOTTOM_TILE)
begin
		if ((sigVALUE_REG = zeroes) or (MOVE_INTO_LEFT = '1')) then  --if the tile to the left is empty it will absorb the current value, set own value to zero
			ALLOW_MOVE_FROM_RIGHT <= '1';
		else
			ALLOW_MOVE_FROM_RIGHT <= '0';
		end if;
		
		if ((sigVALUE_REG = zeroes) or (MOVE_INTO_TOP = '1')) then  --if the tile to the left is empty it will absorb the current value, set own value to zero
			ALLOW_MOVE_FROM_BOTTOM <= '1';
		else
			ALLOW_MOVE_FROM_BOTTOM <= '0';
		end if;

		if ((sigVALUE_REG = zeroes) or (MOVE_INTO_RIGHT = '1')) then  --if the tile to the left is empty it will absorb the current value, set own value to zero
			ALLOW_MOVE_FROM_LEFT <= '1';
		else
			ALLOW_MOVE_FROM_LEFT <= '0';
		end if;
		
		if ((sigVALUE_REG = zeroes) or (MOVE_INTO_BOTTOM = '1')) then  --if the tile to the left is empty it will absorb the current value, set own value to zero
			ALLOW_MOVE_FROM_TOP <= '1';
		else
			ALLOW_MOVE_FROM_TOP <= '0';
		end if;
		
		
	

end process moveChecks;

mergeChecks: process(sigVALUE_REG, DIRECTION, MERGE_INTO_LEFT, MERGE_INTO_RIGHT, MERGE_INTO_TOP, MERGE_INTO_BOTTOM, TOP_TILE, LEFT_TILE, BOTTOM_TILE, RIGHT_TILE)
begin

		
		if (sigVALUE_REG /= zeroes) and (MERGE_INTO_LEFT = '0')  and (sigVALUE_REG = RIGHT_TILE) then --if block cannot merge into left block, check if can be merged into from right block and let it know
			ALLOW_MERGE_FROM_RIGHT <= '1';
		else
			ALLOW_MERGE_FROM_RIGHT <= '0';
		end if;

		if (sigVALUE_REG /= zeroes) and (MERGE_INTO_RIGHT = '0')  and (sigVALUE_REG = LEFT_TILE) then --if block cannot merge into right block, check if can be merged into from right block and let it know
			ALLOW_MERGE_FROM_LEFT <= '1';
		else
			ALLOW_MERGE_FROM_LEFT <= '0';
		end if;

		if (sigVALUE_REG /= zeroes) and (MERGE_INTO_TOP = '0')  and (sigVALUE_REG = BOTTOM_TILE) then --if block cannot merge into left block, check if can be merged into from right block and let it know
			ALLOW_MERGE_FROM_BOTTOM <= '1';
		else
			ALLOW_MERGE_FROM_BOTTOM <= '0';
		end if;

		if (sigVALUE_REG /= zeroes) and (MERGE_INTO_BOTTOM = '0')  and (sigVALUE_REG = TOP_TILE) then --if block cannot merge into left block, check if can be merged into from right block and let it know
			ALLOW_MERGE_FROM_TOP <= '1';
		else
			ALLOW_MERGE_FROM_TOP <= '0';
		end if;

end process mergeChecks;

iszeroProc: process(sigVALUE_REG)
begin
if (sigVALUE_REG /= zeroes) then
ISZERO_SIG <= '0';
else
ISZERO_SIG <= '1';
end if;
end process iszeroProc;

ISZERO <= ISZERO_SIG;

--CANMOVE <= ALLOW_MOVE_FROM_RIGHT or ALLOW_MOVE_FROM_LEFT or ALLOW_MOVE_FROM_TOP or ALLOW_MOVE_FROM_BOTTOM or ALLOW_MERGE_FROM_RIGHT or ALLOW_MERGE_FROM_LEFT or ALLOW_MERGE_FROM_TOP or ALLOW_MERGE_FROM_BOTTOM;

CANMOVE(3) <= ((not ISZERO_SIG) and ALLOW_MOVE_FROM_RIGHT) or ALLOW_MERGE_FROM_RIGHT; -- output if move legal to left
CANMOVE(2) <= ((not ISZERO_SIG) and ALLOW_MOVE_FROM_LEFT) or ALLOW_MERGE_FROM_LEFT; -- output if move legal to right
CANMOVE(1) <= ((not ISZERO_SIG) and ALLOW_MOVE_FROM_BOTTOM) or ALLOW_MERGE_FROM_BOTTOM; -- output if move legal to top
CANMOVE(0) <= ((not ISZERO_SIG) and ALLOW_MOVE_FROM_TOP) or ALLOW_MERGE_FROM_TOP;  -- output if move legal to bottom
end Behavioral;


