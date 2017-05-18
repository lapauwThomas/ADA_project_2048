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

			  
			  LEFT_CANMERGE 		: out  STD_LOGIC;
			  RIGHT_CANMERGE 		: out  STD_LOGIC;
			  TOP_CANMERGE 		: out  STD_LOGIC;
			  BOTTOM_CANMERGE 	: out  STD_LOGIC;
			  
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
			
		when s_Merge =>
			-- Move state
			case DIRECTION is
				when dirLeft =>
					if VALUE = RIGHT_TILE then --if mergable in this direction
						VALUE((busWidth-1) downto 0) <= VALUE((busWidth-2) downto 0) & '0'; --Merge in standard rules equals shift to left
					end if;
				when dirUp =>
					if VALUE = BOTTOM_TILE then --if mergable in this direction
						VALUE((busWidth-1) downto 0) <= VALUE((busWidth-2) downto 0) & '0'; --Merge in standard rules equals shift to left
					end if;
				when dirRight =>					
					if VALUE = LEFT_TILE then --if mergable in this direction
						VALUE((busWidth-1) downto 0) <= VALUE((busWidth-2) downto 0) & '0'; --Merge in standard rules equals shift to left
					end if;
				when dirDown =>
					if VALUE = TOP_TILE then --if mergable in this direction
						VALUE((busWidth-1) downto 0) <= VALUE((busWidth-2) downto 0) & '0'; --Merge in standard rules equals shift to left
					end if;
			end case;
			--Do merge
			nextState <= s_Merge;
			
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

