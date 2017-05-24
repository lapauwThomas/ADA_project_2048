----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:21:10 05/22/2017 
-- Design Name: 
-- Module Name:    Board - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Board is
	generic ( busWidth : integer := 12 ; boardSize : integer := 4 ); --width on 12 for max value of 2048
    Port ( DIRECTION : in  STD_LOGIC_VECTOR (2 downto 0);
           EXCECUTE : in  STD_LOGIC;
           INIT : in  STD_LOGIC;
			  CLK : in  STD_LOGIC;
           INITVAL : in  STD_LOGIC_VECTOR((busWidth-1) downto 0);
           INITLOC : in  STD_LOGIC_VECTOR((32 -1) downto 0)); --Oversized but /care
end Board;


architecture Behavioral of Board is

COMPONENT tile
    PORT(
         CLK : IN  std_logic;
         VALUE : OUT  std_logic_vector(11 downto 0);
         DIRECTION : IN  std_logic_vector(1 downto 0);
         EXECUTE : IN  std_logic;
         MOVE_LEFT_NDONE : IN  std_logic;
         MOVE_RIGHT_NDONE : IN  std_logic;
         MOVE_UP_NDONE : IN  std_logic;
         MOVE_DOWN_NDONE : IN  std_logic;
         INIT : IN  std_logic;
         INITVAL : IN  std_logic_vector(11 downto 0);
         MOVE_OUT_LEFT : OUT  std_logic_vector(1 downto 0);
         MOVE_OUT_RIGHT : OUT  std_logic_vector(1 downto 0);
         MOVE_OUT_TOP : OUT  std_logic_vector(1 downto 0);
         MOVE_OUT_BOTTOM : OUT  std_logic_vector(1 downto 0);
         MOVE_IN_LEFT : IN  std_logic_vector(1 downto 0);
         MOVE_IN_RIGHT : IN  std_logic_vector(1 downto 0);
         MOVE_IN_TOP : IN  std_logic_vector(1 downto 0);
         MOVE_IN_BOTTOM : IN  std_logic_vector(1 downto 0);
         LEFT_TILE : IN  std_logic_vector(11 downto 0);
         RIGHT_TILE : IN  std_logic_vector(11 downto 0);
         TOP_TILE : IN  std_logic_vector(11 downto 0);
         BOTTOM_TILE : IN  std_logic_vector(11 downto 0);
         RESET : IN  std_logic
        );
    END COMPONENT;







constant moveInterconnectWidth: integer := integer(4*boardSize*(boardSize-1)); -- 2 times 2 signals for boardSize rows/cols and boardsize-1 cols/rows
constant valInterConnectWidth: integer := integer(busWidth*2*boardSize*(boardSize-1));

signal initInterconnect: std_logic_vector( (boardSize*boardSize) downto 0);

signal verticalMoveInterconnect: std_logic_vector(moveInterconnectWidth-1 downto 0); 
signal horizontalMoveInterconnect: std_logic_vector(moveInterconnectWidth-1 downto 0); 

signal verticalValInterconnect: std_logic_vector(valInterconnectWidth-1 downto 0); 
signal horizontalValInterconnect: std_logic_vector(valInterconnectWidth-1 downto 0); 


begin



HORIZONTAL_ROWS: for horVar in 0 to boardSize-1 generate
	VERTICAL_COLS: for verVar in 0 to boardSize-1 generate

    UL_COR: if (horVar = 0 and verVar = 0) generate
		
      UL_Tile: tile PORT MAP (
          CLK => CLK,
          
          DIRECTION => DIRECTION,
          EXECUTE => EXECUTE,
			 INITVAL => INITVAL,
			 RESET => RESET,
			 
			 VALUE => VALUE_BL1,
			 INIT => INIT_BL1,
			 
			 
          MOVE_LEFT_NDONE => MOVE_LEFT_NDONE_ROW1,
          MOVE_RIGHT_NDONE => MOVE_RIGHT_NDONE_ROW1,
          MOVE_UP_NDONE => MOVE_UP_NDONE_COL1,
          MOVE_DOWN_NDONE => MOVE_DOWN_NDONE_COL1,
          
          
          MOVE_OUT_LEFT => MOVE_OUT_LEFT_BL1,
          MOVE_OUT_RIGHT => MV_BL1_BL2,
          MOVE_OUT_TOP => MOVE_OUT_TOP_BL1,
          MOVE_OUT_BOTTOM => MOVE_OUT_BOTTOM_BL1,
			 
          MOVE_IN_LEFT => WALL_MOVE,
          MOVE_IN_RIGHT => MV_BL2_BL1,
          MOVE_IN_TOP => WALL_MOVE,
          MOVE_IN_BOTTOM => WALL_MOVE,
			 
          LEFT_TILE => WALL_VAL,
          RIGHT_TILE => VALUE_BL2,
          TOP_TILE => WALL_VAL,
          BOTTOM_TILE => WALL_VAL
          
        );
    end generate LOWER_BIT;

--    UPPER_BITS: if I>0 generate
--      UX: FULLADD port map
--         (A(I),B(I),C(I-1),S(I),C(I));
--    end generate UPPER_BITS;
	 
	 
	 
	 
	 
	 
	 
	 
	 
	end generate VERTICAL_COLS;
 end generate HORIZONTAL_ROWS;


end Behavioral;

