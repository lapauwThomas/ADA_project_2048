----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:09:26 05/25/2017 
-- Design Name: 
-- Module Name:    Game_logic - Behavioral 
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

entity Game_logic is
    Port ( 
           CLK : in  STD_LOGIC;
			  input_character : IN STD_LOGIC_VECTOR(7 downto 0); --ASCII representation
			  RESET: IN STD_LOGIC;
			  GAMEOVER: out STD_LOGIC;
			  START: IN STD_LOGIC;
			  LOAD: IN STD_LOGIC;
			  
			  ENABLE_READMOVE: out std_logic;
			OUT_VALUE_BL11 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL12 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL13 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL14 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL21 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL22 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL23 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL24 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL31 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL32 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL33 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL34 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL41 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL42 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL43 : OUT std_logic_vector(11 downto 0);
			OUT_VALUE_BL44 : OUT std_logic_vector(11 downto 0)
			  
			  
			  );
end Game_logic;

	
architecture Behavioral of Game_logic is
type state_type is (s_Reset, s_LoadBoard, s_GenerateBoard_tile1, s_GenerateBoard_tile2, s_WaitForStart, s_GetMove, s_Execute, s_waitForIdle, s_randomTile, s_gameOver);

signal currentState:state_type := s_Reset;
signal nextState: state_type := s_GenerateBoard;

signal ISZERO_VECT : std_logic_vector(15 downto 0);

signal INITLOC_VECT : std_logic_vector(15 downto 0);
signal INITVAL : std_logic_vector(11 downto 0);


COMPONENT board_4x4
	PORT(
		CLK : IN std_logic;
		INITVAL : IN std_logic_vector(11 downto 0);
		DIRECTION : IN std_logic_vector(1 downto 0);
		EXECUTE : IN std_logic;
		RESET : IN std_logic;
		INITLOC : IN std_logic_vector(15 downto 0);          
		BOARDIDLE : OUT std_logic;
		GAMEOVER : out STD_LOGIC;
		ISZERO_VECT : OUT std_logic_vector(15 downto 0);
		OUT_VALUE_BL11 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL12 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL13 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL14 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL21 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL22 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL23 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL24 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL31 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL32 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL33 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL34 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL41 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL42 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL43 : OUT std_logic_vector(11 downto 0);
		OUT_VALUE_BL44 : OUT std_logic_vector(11 downto 0)
		);
		
	END COMPONENT;
	
	
	COMPONENT MOVE_GEN
	PORT(
		--clk : IN std_logic;
		--reset : IN std_logic;
		--enable : IN std_logic;
		input_character : IN std_logic_vector(7 downto 0);          
		direction : OUT std_logic_vector(1 downto 0);
		valid : OUT std_logic
		);
	END COMPONENT;
	
	SIGNAL DIRECTION: std_logic_vector(1 downto 0);
	signal EXECUTE: std_logic;
	signal BOARDIDLE: std_logic;
	signal DIR_VALID: std_logic;
	signal ENABLE_MVGEN:std_logic;
	signal GAMEOVER_SIG:std_logic;

begin


Inst_board_4x4: board_4x4 PORT MAP(
		CLK => CLK,
		INITVAL => INITVAL,
		DIRECTION => DIRECTION,
		EXECUTE => EXECUTE,
		RESET => RESET,
		BOARDIDLE => BOARDIDLE,
		INITLOC => INITLOC_VECT,
		ISZERO_VECT => ISZERO_VECT,
		GAMEOVER => GAMEOVER_SIG,
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


	Inst_MOVE_GEN: MOVE_GEN PORT MAP(
		--clk => CLK,
		--reset => reset,
		--enable => ENABLE_MVGEN,
		input_character =>input_character ,
		direction => DIRECTION,
		valid => DIR_VALID
	);


fsmProcess: process(CLK, RESET)
begin
	if rising_edge(clk) then
		if RESET = '1' then -- reset state
			currentState <= s_Reset;
		elsif GAMEOVER_SIG = '1' then
			currentState <= s_GameOver;
		else
			currentState <= nextState;
		end if;
	end if;
end process fsmProcess;
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
fsmStateLogic: process(currentState)
begin

--Default values for signals
	EXECUTE <='0'; 
	GAMEOVER <= '0';
	ENABLE_READMOVE <= '0';
	INITLOC_VECT <= (others => '0');
	ENABLE_LFSR <= '0';
	
	case currentState is
		
		when s_Reset =>
			nextState <= s_GenerateBoard;
			ENABLE_LFSR <= '1';

			
		when s_GenerateBoard_tile1 =>
			if tileValid = '1' then
				ENABLE_LFSR <= '0';
				INITLOC_VECT <= INITLOC_VECT_LFSR;
				nextState <= s_GenerateBoard_tile2;
			else
				ENABLE_LFSR <= '1';
				nextState <= s_randomTile;
			end if;
			
		when s_GenerateBoard_tile2 =>
				if tileValid = '1' then
					ENABLE_LFSR <= '0';
					INITLOC_VECT <= INITLOC_VECT_LFSR;
					nextState <= s_GetMOVE;
					ENABLE_READMOVE <= '1'; --set readmove high to get new move
			else
					ENABLE_LFSR <= '1';
					nextState <= s_randomTile;
			end if;
			
		

		when s_WaitForStart => -- do nothing until start high, if load high goto the load state;
			if START = '1' then
				nextState <= s_GetMove;
				ENABLE_READMOVE <= '1'; --set readmove high to get new move
			elsif LOAD = '1' then
				nextState <= s_LoadBoard;
			else
				nextState <= s_WaitForStart;
			end if;
			
			
		when s_GetMove => --enable 
			if DIR_VALID = '1' then
				ENABLE_READMOVE <= '0'; -- stop reading moves since move is valid
				EXECUTE <= '1'; -- pulse execute high for one cycle
				nextState <= s_WaitForIdle; -- go to wait for idle
			else
				ENABLE_READMOVE <= '1'; --if no move found yet get new moves until valid
				nextState <= s_getMove;
			end if;
			
			
--		when s_Execute =>
--				EXECUTE <= '1';
--				nextState <= s_waitForIdle;
--		
		when s_WaitForIdle =>
				if BOARDIDLE = '1' then
					nextState <= s_randomTile;
					ENABLE_LFSR <= '1';
				else
					nextState <= s_WaitForIdle;
				end if;

		
		when s_randomTile =>
			if tileValid = '1' then
				ENABLE_LFSR <= '0';
				INITLOC_VECT <= INITLOC_VECT_LFSR;
				nextState <= s_GetMOVE;
				ENABLE_READMOVE <= '1'; --set readmove high to get new move
			else
				ENABLE_LFSR <= '1';
				nextState <= s_randomTile;
			end if;

		
		when s_GameOver => 
			GAMEOVER <= '1';
			nextState <= s_GameOver; --keep in currend state (DEAD END) only get out trough reset;
		
		when others =>
			nextState <= s_reset;
	end case;
	
	
	
end process fsmStateLogic;






end Behavioral;

