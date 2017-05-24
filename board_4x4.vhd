----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:08:52 05/23/2017 
-- Design Name: 
-- Module Name:    board_4x4 - Behavioral 
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

entity board_4x4 is
	generic ( busWidth : integer := 12); --width on 12 for max value of 2048
    Port ( CLK : in  STD_LOGIC;
           INITVAL : in  STD_LOGIC_VECTOR (busWidth-1 downto 0);
           DIRECTION : in  STD_LOGIC_VECTOR (1 downto 0);
           EXECUTE : in  STD_LOGIC;
           
           RESET : in  STD_LOGIC;
			  
			  
			  INITLOC : in  STD_LOGIC_VECTOR(15 downto 0);
           ISZERO_VECT : out  STD_LOGIC_VECTOR (15 downto 0);
			  
			  
 OUT_VALUE_BL11: out std_logic_vector(busWidth-1 downto 0);
 OUT_VALUE_BL12: out std_logic_vector(busWidth-1 downto 0);
 OUT_VALUE_BL13: out std_logic_vector(busWidth-1 downto 0);
 OUT_VALUE_BL14: out std_logic_vector(busWidth-1 downto 0);

 OUT_VALUE_BL21: out std_logic_vector(busWidth-1 downto 0);
 OUT_VALUE_BL22: out std_logic_vector(busWidth-1 downto 0);
 OUT_VALUE_BL23: out std_logic_vector(busWidth-1 downto 0);
 OUT_VALUE_BL24: out std_logic_vector(busWidth-1 downto 0);

 OUT_VALUE_BL31: out std_logic_vector(busWidth-1 downto 0);
 OUT_VALUE_BL32: out std_logic_vector(busWidth-1 downto 0);
 OUT_VALUE_BL33: out std_logic_vector(busWidth-1 downto 0);
 OUT_VALUE_BL34: out std_logic_vector(busWidth-1 downto 0);

 OUT_VALUE_BL41: out std_logic_vector(busWidth-1 downto 0);
 OUT_VALUE_BL42: out std_logic_vector(busWidth-1 downto 0);
 OUT_VALUE_BL43: out std_logic_vector(busWidth-1 downto 0);
 OUT_VALUE_BL44: out std_logic_vector(busWidth-1 downto 0));
			  
			  
			  
			  
			  
			  
end board_4x4;

architecture Behavioral of board_4x4 is

COMPONENT tile
    PORT(
         CLK : IN  std_logic;
         VALUE : OUT  std_logic_vector(11 downto 0);
         DIRECTION : IN  std_logic_vector(1 downto 0);
         EXECUTE : IN  std_logic;
         INIT : IN  std_logic;
		 
         INITVAL : IN  std_logic_vector(11 downto 0);
			ISZERO : out std_logic;
		 
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

	constant boardSize : integer := 4 ;
	constant WALL_VAL: std_logic_vector(busWidth-1 downto 0) := (others => '1');
	constant WALL_MOVE: std_logic_vector(1 downto 0) := (others => '0');

--value signals from each block
signal VALUE_BL11: std_logic_vector(busWidth-1 downto 0);
signal VALUE_BL12: std_logic_vector(busWidth-1 downto 0);
signal VALUE_BL13: std_logic_vector(busWidth-1 downto 0);
signal VALUE_BL14: std_logic_vector(busWidth-1 downto 0);

signal VALUE_BL21: std_logic_vector(busWidth-1 downto 0);
signal VALUE_BL22: std_logic_vector(busWidth-1 downto 0);
signal VALUE_BL23: std_logic_vector(busWidth-1 downto 0);
signal VALUE_BL24: std_logic_vector(busWidth-1 downto 0);

signal VALUE_BL31: std_logic_vector(busWidth-1 downto 0);
signal VALUE_BL32: std_logic_vector(busWidth-1 downto 0);
signal VALUE_BL33: std_logic_vector(busWidth-1 downto 0);
signal VALUE_BL34: std_logic_vector(busWidth-1 downto 0);

signal VALUE_BL41: std_logic_vector(busWidth-1 downto 0);
signal VALUE_BL42: std_logic_vector(busWidth-1 downto 0);
signal VALUE_BL43: std_logic_vector(busWidth-1 downto 0);
signal VALUE_BL44: std_logic_vector(busWidth-1 downto 0);


-- init trigger signals to each blocks

signal INIT_BL11: std_logic;
signal INIT_BL12: std_logic;
signal INIT_BL13: std_logic;
signal INIT_BL14: std_logic;

signal INIT_BL21: std_logic;
signal INIT_BL22: std_logic;
signal INIT_BL23: std_logic;
signal INIT_BL24: std_logic;

signal INIT_BL31: std_logic;
signal INIT_BL32: std_logic;
signal INIT_BL33: std_logic;
signal INIT_BL34: std_logic;

signal INIT_BL41: std_logic;
signal INIT_BL42: std_logic;
signal INIT_BL43: std_logic;
signal INIT_BL44: std_logic;

signal ISZERO_BL11: std_logic;
signal ISZERO_BL12: std_logic;
signal ISZERO_BL13: std_logic;
signal ISZERO_BL14: std_logic;

signal ISZERO_BL21: std_logic;
signal ISZERO_BL22: std_logic;
signal ISZERO_BL23: std_logic;
signal ISZERO_BL24: std_logic;

signal ISZERO_BL31: std_logic;
signal ISZERO_BL32: std_logic;
signal ISZERO_BL33: std_logic;
signal ISZERO_BL34: std_logic;

signal ISZERO_BL41: std_logic;
signal ISZERO_BL42: std_logic;
signal ISZERO_BL43: std_logic;
signal ISZERO_BL44: std_logic;


--move signals between vertical collumns
signal MV_BL11_BL12:  std_logic_vector(1 downto 0);
signal MV_BL12_BL11:  std_logic_vector(1 downto 0);
signal MV_BL12_BL13:  std_logic_vector(1 downto 0);
signal MV_BL13_BL12:  std_logic_vector(1 downto 0);
signal MV_BL13_BL14:  std_logic_vector(1 downto 0);
signal MV_BL14_BL13:  std_logic_vector(1 downto 0);

signal MV_BL21_BL22:  std_logic_vector(1 downto 0);
signal MV_BL22_BL21:  std_logic_vector(1 downto 0);
signal MV_BL22_BL23:  std_logic_vector(1 downto 0);
signal MV_BL23_BL22:  std_logic_vector(1 downto 0);
signal MV_BL23_BL24:  std_logic_vector(1 downto 0);
signal MV_BL24_BL23:  std_logic_vector(1 downto 0);

signal MV_BL31_BL32:  std_logic_vector(1 downto 0);
signal MV_BL32_BL31:  std_logic_vector(1 downto 0);
signal MV_BL32_BL33:  std_logic_vector(1 downto 0);
signal MV_BL33_BL32:  std_logic_vector(1 downto 0);
signal MV_BL33_BL34:  std_logic_vector(1 downto 0);
signal MV_BL34_BL33:  std_logic_vector(1 downto 0);

signal MV_BL41_BL42:  std_logic_vector(1 downto 0);
signal MV_BL42_BL41:  std_logic_vector(1 downto 0);
signal MV_BL42_BL43:  std_logic_vector(1 downto 0);
signal MV_BL43_BL42:  std_logic_vector(1 downto 0);
signal MV_BL43_BL44:  std_logic_vector(1 downto 0);
signal MV_BL44_BL43:  std_logic_vector(1 downto 0);

--move signals between HORIZONTAL ROWS
signal MV_BL11_BL21:  std_logic_vector(1 downto 0);
signal MV_BL21_BL11:  std_logic_vector(1 downto 0);
signal MV_BL21_BL31:  std_logic_vector(1 downto 0);
signal MV_BL31_BL21:  std_logic_vector(1 downto 0);
signal MV_BL31_BL41:  std_logic_vector(1 downto 0);
signal MV_BL41_BL31:  std_logic_vector(1 downto 0);

signal MV_BL12_BL22:  std_logic_vector(1 downto 0);
signal MV_BL22_BL12:  std_logic_vector(1 downto 0);
signal MV_BL22_BL32:  std_logic_vector(1 downto 0);
signal MV_BL32_BL22:  std_logic_vector(1 downto 0);
signal MV_BL32_BL42:  std_logic_vector(1 downto 0);
signal MV_BL42_BL32:  std_logic_vector(1 downto 0);

signal MV_BL13_BL23:  std_logic_vector(1 downto 0);
signal MV_BL23_BL13:  std_logic_vector(1 downto 0);
signal MV_BL23_BL33:  std_logic_vector(1 downto 0);
signal MV_BL33_BL23:  std_logic_vector(1 downto 0);
signal MV_BL33_BL43:  std_logic_vector(1 downto 0);
signal MV_BL43_BL33:  std_logic_vector(1 downto 0);

signal MV_BL14_BL24:  std_logic_vector(1 downto 0);
signal MV_BL24_BL14:  std_logic_vector(1 downto 0);
signal MV_BL24_BL34:  std_logic_vector(1 downto 0);
signal MV_BL34_BL24:  std_logic_vector(1 downto 0);
signal MV_BL34_BL44:  std_logic_vector(1 downto 0);
signal MV_BL44_BL34:  std_logic_vector(1 downto 0);







begin


 OUT_VALUE_BL11 <= VALUE_BL11;
 OUT_VALUE_BL12 <= VALUE_BL12;
 OUT_VALUE_BL13 <= VALUE_BL13;
 OUT_VALUE_BL14 <= VALUE_BL14;

 OUT_VALUE_BL21 <= VALUE_BL21;
 OUT_VALUE_BL22 <= VALUE_BL22;
 OUT_VALUE_BL23 <= VALUE_BL23;
 OUT_VALUE_BL24 <= VALUE_BL24;

 OUT_VALUE_BL31 <= VALUE_BL31;
 OUT_VALUE_BL32 <= VALUE_BL32;
 OUT_VALUE_BL33 <= VALUE_BL33;
 OUT_VALUE_BL34 <= VALUE_BL34;

 OUT_VALUE_BL41 <= VALUE_BL41;
 OUT_VALUE_BL42 <= VALUE_BL42;
 OUT_VALUE_BL43 <= VALUE_BL43;
 OUT_VALUE_BL44 <= VALUE_BL44;


  INIT_BL11 <= INITLOC(0);
  INIT_BL12 <= INITLOC(1);
  INIT_BL13 <= INITLOC(2);
  INIT_BL14 <= INITLOC(3);

  INIT_BL21 <= INITLOC(4);
  INIT_BL22 <= INITLOC(5);
  INIT_BL23 <= INITLOC(6);
  INIT_BL24 <= INITLOC(7);

  INIT_BL31 <= INITLOC(8);
  INIT_BL32 <= INITLOC(9);
  INIT_BL33 <= INITLOC(10);
  INIT_BL34 <= INITLOC(11);

  INIT_BL41 <= INITLOC(12);
  INIT_BL42 <= INITLOC(13);
  INIT_BL43 <= INITLOC(14);
  INIT_BL44 <= INITLOC(15);
  
  ISZERO_VECT <= ISZERO_BL11 & ISZERO_BL12 & ISZERO_BL13 & ISZERO_BL14 & ISZERO_BL21 & ISZERO_BL22 & ISZERO_BL23 & ISZERO_BL24 & ISZERO_BL31 & ISZERO_BL32 & ISZERO_BL33 & ISZERO_BL34 & ISZERO_BL41 & ISZERO_BL42 & ISZERO_BL43 & ISZERO_BL44; 



BL11: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL11,
INIT => INIT_BL11,
ISZERO => ISZERO_BL11,

MOVE_OUT_LEFT => open,
MOVE_OUT_RIGHT => MV_BL11_BL12,
MOVE_OUT_TOP => OPEN,
MOVE_OUT_BOTTOM => MV_BL11_BL21,

MOVE_IN_LEFT => WALL_MOVE,
MOVE_IN_RIGHT => MV_BL12_BL11,
MOVE_IN_TOP => WALL_MOVE,
MOVE_IN_BOTTOM => MV_BL21_BL11,

LEFT_TILE => WALL_VAL,
RIGHT_TILE => VALUE_BL12,
TOP_TILE => WALL_VAL,
BOTTOM_TILE => VALUE_BL21

);

BL12: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL12,
INIT => INIT_BL12,
ISZERO => ISZERO_BL12,



MOVE_OUT_LEFT => MV_BL12_BL11,
MOVE_OUT_RIGHT => MV_BL12_BL13,
MOVE_OUT_TOP => OPEN,
MOVE_OUT_BOTTOM => MV_BL12_BL22,

MOVE_IN_LEFT => MV_BL11_BL12,
MOVE_IN_RIGHT => MV_BL13_BL12,
MOVE_IN_TOP => WALL_MOVE,
MOVE_IN_BOTTOM => MV_BL22_BL12,

LEFT_TILE => VALUE_BL11,
RIGHT_TILE => VALUE_BL13,
TOP_TILE => WALL_VAL,
BOTTOM_TILE => VALUE_BL22

);

BL13: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL13,
INIT => INIT_BL13,
ISZERO => ISZERO_BL13,



MOVE_OUT_LEFT => MV_BL13_BL12,
MOVE_OUT_RIGHT => MV_BL13_BL14,
MOVE_OUT_TOP => OPEN,
MOVE_OUT_BOTTOM => MV_BL13_BL23,

MOVE_IN_LEFT => MV_BL12_BL13,
MOVE_IN_RIGHT => MV_BL14_BL13,
MOVE_IN_TOP => WALL_MOVE,
MOVE_IN_BOTTOM => MV_BL23_BL13,

LEFT_TILE => VALUE_BL12,
RIGHT_TILE => VALUE_BL14,
TOP_TILE => WALL_VAL,
BOTTOM_TILE => VALUE_BL23


);

BL14: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL14,
INIT => INIT_BL14,
ISZERO => ISZERO_BL14,

MOVE_OUT_LEFT => MV_BL14_BL13,
MOVE_OUT_RIGHT => OPEN,
MOVE_OUT_TOP => OPEN,
MOVE_OUT_BOTTOM => MV_BL14_BL24,

MOVE_IN_LEFT => MV_BL13_BL14,
MOVE_IN_RIGHT => WALL_MOVE,
MOVE_IN_TOP => WALL_MOVE,
MOVE_IN_BOTTOM => MV_BL24_BL14,

LEFT_TILE => VALUE_BL13,
RIGHT_TILE => WALL_VAL,
TOP_TILE => WALL_VAL,
BOTTOM_TILE => VALUE_BL24


);

BL21: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL21,
INIT => INIT_BL21,
ISZERO => ISZERO_BL21,

MOVE_OUT_LEFT => OPEN,
MOVE_OUT_RIGHT => MV_BL21_BL22,
MOVE_OUT_TOP => MV_BL21_BL11,
MOVE_OUT_BOTTOM => MV_BL21_BL31,

MOVE_IN_LEFT => WALL_MOVE,
MOVE_IN_RIGHT => MV_BL22_BL21,
MOVE_IN_TOP => MV_BL11_BL21,
MOVE_IN_BOTTOM => MV_BL31_BL21,

LEFT_TILE => WALL_VAL,
RIGHT_TILE => VALUE_BL22,
TOP_TILE => VALUE_BL11,
BOTTOM_TILE => VALUE_BL31

);

BL22: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL22,
INIT => INIT_BL22,
ISZERO => ISZERO_BL22,

MOVE_OUT_LEFT => MV_BL22_BL21,
MOVE_OUT_RIGHT => MV_BL22_BL23,
MOVE_OUT_TOP => MV_BL22_BL12,
MOVE_OUT_BOTTOM => MV_BL22_BL32,

MOVE_IN_LEFT => MV_BL21_BL22,
MOVE_IN_RIGHT => MV_BL23_BL22,
MOVE_IN_TOP => MV_BL12_BL22,
MOVE_IN_BOTTOM => MV_BL32_BL22,

LEFT_TILE => VALUE_BL21,
RIGHT_TILE => VALUE_BL23,
TOP_TILE => VALUE_BL12,
BOTTOM_TILE => VALUE_BL32

);

BL23: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL23,
INIT => INIT_BL23,
ISZERO => ISZERO_BL23,

MOVE_OUT_LEFT => MV_BL23_BL22,
MOVE_OUT_RIGHT => MV_BL23_BL24,
MOVE_OUT_TOP => MV_BL23_BL13,
MOVE_OUT_BOTTOM => MV_BL23_BL33,

MOVE_IN_LEFT => MV_BL22_BL23,
MOVE_IN_RIGHT => MV_BL24_BL23,
MOVE_IN_TOP => MV_BL13_BL23,
MOVE_IN_BOTTOM => MV_BL33_BL23,

LEFT_TILE => VALUE_BL22,
RIGHT_TILE => VALUE_BL24,
TOP_TILE => VALUE_BL13,
BOTTOM_TILE => VALUE_BL33

);
BL24: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL24,
INIT => INIT_BL24,
ISZERO => ISZERO_BL24,

MOVE_OUT_LEFT => MV_BL24_BL23,
MOVE_OUT_RIGHT => OPEN,
MOVE_OUT_TOP => MV_BL24_BL14,
MOVE_OUT_BOTTOM => MV_BL24_BL34,

MOVE_IN_LEFT => MV_BL23_BL24,
MOVE_IN_RIGHT => WALL_MOVE,
MOVE_IN_TOP => MV_BL14_BL24,
MOVE_IN_BOTTOM => MV_BL34_BL24,

LEFT_TILE => VALUE_BL23,
RIGHT_TILE => WALL_VAL,
TOP_TILE => VALUE_BL14,
BOTTOM_TILE => VALUE_BL34

);
BL31: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL31,
INIT => INIT_BL31,
ISZERO => ISZERO_BL31,

MOVE_OUT_LEFT => OPEN,
MOVE_OUT_RIGHT => MV_BL31_BL32,
MOVE_OUT_TOP => MV_BL31_BL21,
MOVE_OUT_BOTTOM => MV_BL31_BL41,

MOVE_IN_LEFT => WALL_MOVE,
MOVE_IN_RIGHT => MV_BL32_BL31,
MOVE_IN_TOP => MV_BL21_BL31,
MOVE_IN_BOTTOM => MV_BL41_BL31,

LEFT_TILE => WALL_VAL,
RIGHT_TILE => VALUE_BL32,
TOP_TILE => VALUE_BL21,
BOTTOM_TILE => VALUE_BL41

);

BL32: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL32,
INIT => INIT_BL32,
ISZERO => ISZERO_BL32,

MOVE_OUT_LEFT => MV_BL32_BL31,
MOVE_OUT_RIGHT => MV_BL32_BL33,
MOVE_OUT_TOP => MV_BL32_BL22,
MOVE_OUT_BOTTOM => MV_BL32_BL42,

MOVE_IN_LEFT => MV_BL31_BL32,
MOVE_IN_RIGHT => MV_BL33_BL32,
MOVE_IN_TOP => MV_BL22_BL32,
MOVE_IN_BOTTOM => MV_BL42_BL32,

LEFT_TILE => VALUE_BL31,
RIGHT_TILE => VALUE_BL33,
TOP_TILE => VALUE_BL22,
BOTTOM_TILE => VALUE_BL42

);

BL33: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL33,
INIT => INIT_BL33,
ISZERO => ISZERO_BL33,

MOVE_OUT_LEFT => MV_BL33_BL32,
MOVE_OUT_RIGHT => MV_BL33_BL34,
MOVE_OUT_TOP => MV_BL33_BL23,
MOVE_OUT_BOTTOM => MV_BL33_BL43,

MOVE_IN_LEFT => MV_BL32_BL33,
MOVE_IN_RIGHT => MV_BL34_BL33,
MOVE_IN_TOP => MV_BL23_BL33,
MOVE_IN_BOTTOM => MV_BL43_BL33,

LEFT_TILE => VALUE_BL32,
RIGHT_TILE => VALUE_BL34,
TOP_TILE => VALUE_BL23,
BOTTOM_TILE => VALUE_BL43

);

BL34: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL34,
INIT => INIT_BL34,
ISZERO => ISZERO_BL34,

MOVE_OUT_LEFT => MV_BL34_BL33,
MOVE_OUT_RIGHT => OPEN,
MOVE_OUT_TOP => MV_BL34_BL24,
MOVE_OUT_BOTTOM => MV_BL34_BL44,

MOVE_IN_LEFT => MV_BL33_BL34,
MOVE_IN_RIGHT => WALL_MOVE,
MOVE_IN_TOP => MV_BL24_BL34,
MOVE_IN_BOTTOM => MV_BL44_BL34,

LEFT_TILE => VALUE_BL23,
RIGHT_TILE => WALL_VAL,
TOP_TILE => VALUE_BL14,
BOTTOM_TILE => VALUE_BL44

);

BL41: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL41,
INIT => INIT_BL41,
ISZERO => ISZERO_BL41,


MOVE_OUT_LEFT => OPEN,
MOVE_OUT_RIGHT => MV_BL41_BL42,
MOVE_OUT_TOP => MV_BL41_BL31,
MOVE_OUT_BOTTOM => OPEN,

MOVE_IN_LEFT => WALL_MOVE,
MOVE_IN_RIGHT => MV_BL42_BL41,
MOVE_IN_TOP => MV_BL31_BL41,
MOVE_IN_BOTTOM => WALL_MOVE,

LEFT_TILE => WALL_VAL,
RIGHT_TILE => VALUE_BL42,
TOP_TILE => VALUE_BL31,
BOTTOM_TILE => WALL_VAL

);

BL42: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,

VALUE => VALUE_BL42,
INIT => INIT_BL42,
ISZERO => ISZERO_BL42,


MOVE_OUT_LEFT => MV_BL42_BL41,
MOVE_OUT_RIGHT => MV_BL42_BL43,
MOVE_OUT_TOP => MV_BL42_BL32,
MOVE_OUT_BOTTOM => OPEN,

MOVE_IN_LEFT => MV_BL41_BL42,
MOVE_IN_RIGHT => MV_BL43_BL42,
MOVE_IN_TOP => MV_BL32_BL42,
MOVE_IN_BOTTOM => WALL_MOVE,

LEFT_TILE => VALUE_BL41,
RIGHT_TILE => VALUE_BL43,
TOP_TILE => VALUE_BL32,
BOTTOM_TILE => WALL_VAL

);

BL43: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,


VALUE => VALUE_BL43,
INIT => INIT_BL43,
ISZERO => ISZERO_BL43,


MOVE_OUT_LEFT => MV_BL43_BL42,
MOVE_OUT_RIGHT => MV_BL43_BL44,
MOVE_OUT_TOP => MV_BL43_BL33,
MOVE_OUT_BOTTOM => OPEN,

MOVE_IN_LEFT => MV_BL42_BL43,
MOVE_IN_RIGHT => MV_BL44_BL43,
MOVE_IN_TOP => MV_BL33_BL43,
MOVE_IN_BOTTOM => WALL_MOVE,

LEFT_TILE => VALUE_BL42,
RIGHT_TILE => VALUE_BL44,
TOP_TILE => VALUE_BL33,
BOTTOM_TILE => WALL_VAL

);

BL44: tile PORT MAP (
CLK => CLK,

DIRECTION => DIRECTION,
EXECUTE => EXECUTE,
INITVAL => INITVAL,
RESET => RESET,


VALUE => VALUE_BL44,
INIT => INIT_BL44,
ISZERO => ISZERO_BL44,


MOVE_OUT_LEFT => MV_BL44_BL43,
MOVE_OUT_RIGHT => OPEN,
MOVE_OUT_TOP => MV_BL44_BL34,
MOVE_OUT_BOTTOM => OPEN,

MOVE_IN_LEFT => MV_BL43_BL44,
MOVE_IN_RIGHT => WALL_MOVE,
MOVE_IN_TOP => MV_BL34_BL44,
MOVE_IN_BOTTOM => WALL_MOVE,

LEFT_TILE => VALUE_BL43,
RIGHT_TILE => WALL_VAL,
TOP_TILE => VALUE_BL34,
BOTTOM_TILE => WALL_VAL

);
end Behavioral;

