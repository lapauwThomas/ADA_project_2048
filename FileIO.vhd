----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:20:22 05/22/2017 
-- Design Name: 
-- Module Name:    FileIO - Behavioral 
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


--TO DO: endoffile signal mag er uit
			--and not(valid_grid) toevoegen bij enable van read_moves process
			--remove tile<x>_load?
			

--include this library for file handling in VHDL.
library std;
use std.textio.all;  --include package textio.vhd

library ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.all; --conv_integer

--entity declaration
entity FileIO is
end FileIO;

--architecture definition
architecture Behavioral of FileIO is

	--CLK definitions
	--signal clk , endoffile : bit := '0';
	signal clk : std_logic := '0';
   constant clk_period : time := 2 ns;	
	
	------------------------------------------------------------------------------
	--Read and write signals
	------------------------------------------------------------------------------
	--bit for indicating end of file.
	--signal endoffile : bit := '0';
	signal endoffile , endoffile_grid : std_logic := '0';
	signal read_newline : std_logic := '1';
	
	
	--data read from the file.
	--signal    dataread : character;
   signal  dataread : std_logic_vector(7 downto 0) := (others => '0'); --ASCII representation of character
	signal dataread_grid : string(1 to 4);
	
	--data to be saved into the output file.
	--signal    datatosave : character;
	--line number of the file read or written.
	--signal    linenumber : integer:=1; 
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------

	
	
	------------------------------------------------------------------------------
	--Move generator
	------------------------------------------------------------------------------
	COMPONENT MOVE_GEN
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         enable : IN  std_logic;
         input_character : IN  std_logic_vector(7 downto 0);
         direction : OUT  std_logic_vector(1 downto 0);
         valid : OUT  std_logic
        );
    END COMPONENT;
	 
	--Inputs
   signal reset : std_logic := '0';
   --signal enable : std_logic := '0';

 	--Outputs
   signal direction : std_logic_vector(1 downto 0);
   signal valid , valid_grid : std_logic;	
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------
	
	
	------------------------------------------------------------------------------
	--Signals used to load a custom grid at initialisation
	--Initialisation is done by pulling load_grid high for 1 clk pulse
	------------------------------------------------------------------------------
	type array_type_2 is array (0 to 35) of string(1 to 4);
	signal configuration_array : array_type_2 := (others => "0000");
	
	signal load_grid : std_logic := '0';
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------
	
	
	--general signals
	signal enable_move_generator : std_logic := '1';
	signal enable_reading_moves : std_logic := '1';
	signal move_string : string(1 to 5);
	
		
	------------------------------------------------------------------------------
	--test signals
	------------------------------------------------------------------------------	
	----value for border tile
	signal border : std_logic_vector(11 downto 0) := (0 => '1' , others => '0');
	
	----dummy tiles to test with
	signal tile1_out , tile2_out , tile3_out , tile4_out : std_logic_vector(11 downto 0) := (others => '0');
	signal tile5_out , tile6_out , tile7_out , tile8_out : std_logic_vector(11 downto 0) := (others => '0');
	signal tile9_out , tile10_out , tile11_out , tile12_out : std_logic_vector(11 downto 0) := (others => '0');
	signal tile13_out , tile14_out , tile15_out , tile16_out : std_logic_vector(11 downto 0) := (others => '0');
	
	----array for dummy tiles
	type array_type is array (0 to 15) of std_logic_vector(11 downto 0);
	signal tile_output_array : array_type;  
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------
	

begin
	
	tile_output_array <= (tile1_out,tile2_out,tile3_out,tile4_out,tile5_out,tile6_out,tile7_out,tile8_out,tile9_out,tile10_out,tile11_out,tile12_out,tile13_out,tile14_out,tile15_out,tile16_out);
	
	
	--move generater should be disabled if global enable = '0' or if reading_moves is disabled or 
	--if the end of the file containing the moves is reached
	--enable_move_generator <= enable AND enable_reading_moves AND not(endoffile);
	enable_move_generator <= enable_reading_moves AND not(endoffile);

	
	-- Instantiate move generator
	MOVE_GEN_1: MOVE_GEN PORT MAP (
          clk => clk,
          reset => reset,
          enable => enable_move_generator, --if end of file reached, move generator is disabled
          input_character => dataread,  --converted character read from file, is input to move_gen
          direction => direction,
          valid => valid
        );

	-- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

	--clk <= not (clk) after 1 ns;    --clock with time period 2 ns



	------------------------------------------------------------------------------
	--Read in initial grid 
	--1 clk pulse on load_grid will initialise the load of the grid
	------------------------------------------------------------------------------
	loading_grid: process
		 file   infile_grid    : text is in  "initial_grid.txt";   --declare input file
		 variable  inline_grid    : line; --line number declaration
		 variable  dataread1_grid    : character;
	begin
		wait until rising_edge(clk); 
			if reset = '1' then
				dataread_grid <= (others => '0');
				endoffile_grid <= '0';
				valid_grid <= '0';
			else
				if load_grid = '1' then --enable signal
					
					--valid_grid <= '1';
					
					--use 3 for loops to read in grid
					for k in 0 to 5 loop --iterate vertically
						
					   --always first read 1 line from a file
						readline(infile_grid, inline_grid); 
					  
					   for l in 0 to 5 loop --iterate horizontally
						
								for m in 0 to 3 loop --read in the values from 0-2048
									--read 1 character from a line
									read(inline_grid, dataread1_grid);
									--put the character into a string
									--dataread_grid(m+1) <= dataread1_grid; --4 characters into 1 string
									
									configuration_array(k*6 + l)(m+1) <= dataread1_grid;

									
								end loop; --m
						
								
								--wait until rising_edge(clk);
						
						end loop; --l
					
					end loop; --k 				  
					 
					valid_grid <= '1';	
				else
					valid_grid <= '0';
					
				end if; --load_grid
			
			end if;	--reset			

	end process loading_grid;
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------



	------------------------------------------------------------------------------
	--Reading moves
	------------------------------------------------------------------------------
--	reading : process
--		 file   infile    : text is in  "input.txt";   --declare input file
--		 variable  inline    : line; --line number declaration
--		 variable  dataread1    : character;
--	begin
--		wait until rising_edge(clk);
--		while (not endfile(infile)) loop   --checking the "END OF FILE" is not reached.
--			
--			--always first read a line from file
--			readline(infile, inline);     
--			  
--			--reading the data from the line and reading it character per character
--			while ( not(inline'length = 0) ) loop
--				--read a character into a variable
--				read(inline, dataread1);
--				--put the value available in variable in a signal
--				--dataread <= dataread1; 		
--				
--				--'pos gives the numerical position of a given character in the ASCII table enumeration 
--				dataread <= conv_std_logic_vector(character'pos(dataread1),8);
--								
--				wait until rising_edge(clk);
--			end loop;
--			
--		end loop;		
--
--		--signal to warn writing process that end of file is reached
--		endoffile <='1';		
--
--	end process reading;



	reading_moves : process(clk)
		 file   infile    : text is in  "input.txt";   --declare input file
		 variable  inline    : line; --line number declaration
		 variable  dataread1    : character;
	begin
		if (rising_edge(clk)) then
			if reset = '1' then
				read_newline <= '1';
				dataread <= (others => '0');
				endoffile <= '0';
			else
				if enable_reading_moves = '1' then --enable signal
			
					if (not endfile(infile)) then   --checking the "END OF FILE" is not reached.	
									
						--always first read a line from file, and next read characters from line
						if read_newline = '1' then					
							readline(infile, inline);     
							read_newline <= '0';
						end if;
						  
						--if we arrive at the last character, set signal to fetch a new line
						if inline'length = 1 then
							read_newline <= '1';
						end if;	  
						
						--read a new character as long as we are not at the end of the line
						if ( not(inline'length = 0) ) then		
							--read 1 character from a line
							read(inline, dataread1);
							--put the character into a signal
							--dataread <= dataread1; 		
							
							--'pos gives the numerical position of a given character in the ASCII table enumeration 
							dataread <= conv_std_logic_vector(character'pos(dataread1),8);		
						end if;
		
						
					else
						--signal to warn writing process that end of file is reached
						endoffile <='1';		
					end if; --endoffile
				
				end if; --enable_reading_moves
			
			end if;	--reset			
		end if;	--clk 
	end process reading_moves;
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------



	------------------------------------------------------------------------------
	--Writing grid
	------------------------------------------------------------------------------
--	writing : process
--		 file      outfile  : text is out "output.txt";  --declare output file
--		 variable  outline  : line;   --line number declaration  
--	begin
--	wait until falling_edge(clk);
--		if(endoffile='0') then   --if the file end is not reached.
--			--write(linenumber,value(real type),justified(side),field(width),digits(natural));
--			--write(outline, dataread, right, 16, 12);
--			write(outline, dataread, right, 1);
--			-- write line to external file.
--			writeline(outfile, outline);
--			linenumber <= linenumber + 1;
--		else
--			null;
--		end if;
--
--	end process writing;




	writing_grid : process(clk)
		 file      outfile  : text is out "output.txt";  --declare output file
		 variable  outline  : line;   --line number declaration  
	begin
		if falling_edge(clk) then
			if valid_grid = '1' then
				
				--use 2 for loops to write the 2D grid into output file
				for n in 0 to 5 loop --vertically
				
					write(outline,integer'value(configuration_array(n*6 + 0)), right, 2);
					
					for o in 0 to 3 loop --horizontally
					
						write(outline,integer'value(configuration_array(n*6 + o + 1)), right, 12); --configuration_array is an 
																															-- array of strings
						
					end loop; --o
					
					write(outline,integer'value(configuration_array(n*6 + 5)), right, 2);
					
					writeline(outfile, outline);
					
				end loop; --n	
			
			else --only if no initial grid is being loaded, the output values of the tiles can be written
		
				--write whenever valid goes high: this means a valid move was read
				if(valid='1') then
								
					--1st row of white spaces before each move
					write(outline,character'val(32), right, 1); --32 is ASCII (decimal) code for a space
					writeline(outfile, outline);
					
					--Write move
					write(outline,move_string, right, 1); --32 is ASCII (decimal) code for a space
					writeline(outfile, outline);
					
					--2nd row of white spaces before each move
					write(outline,character'val(32), right, 1); --32 is ASCII (decimal) code for a space
					writeline(outfile, outline);
					
					--top row of border
					--write(outline,CONV_INTEGER(unsigned(border)), right, 2); -- " 1"
					write(outline,character'val(35), right, 2); -- 35 is ASCII code for #
					for j in 0 to 3 loop
						----border tile
						write(outline,character'val(35), right, 12); -- 35 is ASCII code for #
					end loop; --j1		
					write(outline,character'val(35), right, 2); -- 35 is ASCII code for #
					writeline(outfile, outline);
					
					for j in 0 to 3 loop
						--first write into line
						
						--border tile in front of actual tile
						write(outline,character'val(35), right, 2); -- 35 is ASCII code for #
						
						----actual tiles
						for i in 0 to 3 loop	
							write(outline,CONV_INTEGER(unsigned(tile_output_array(j*4+i))), right, 12);  --no write function to write std_logic_vector		
						end loop; --i
						
						--border tile after actual tile
						write(outline,character'val(35), right, 2); -- 35 is ASCII code for #
					
						--second write line into file
						writeline(outfile, outline);
					end loop; --j2	
					
					--bottom row of border
					write(outline,character'val(35), right, 2); -- 35 is ASCII code for #
					for j in 0 to 3 loop
						----border tile
						write(outline,character'val(35), right, 12); -- 35 is ASCII code for #          1"
					end loop; --j3
					write(outline,character'val(35), right, 2); -- 35 is ASCII code for #
					writeline(outfile, outline);				
					
				end if; --valid
			end if; --load_grid			
		end if; --clk	
	end process writing_grid;
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------



	------------------------------------------------------------------------------
	-- To write move inside output file
	------------------------------------------------------------------------------
	with direction select 
		move_string <= 	"Up   " when "00",
								"Down " when "01",
								"Left " when "10",
								"Right" when "11",
								"     " when others;
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------



		
	------------------------------------------------------------------------------
	-- Stimulus process
	------------------------------------------------------------------------------
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      reset <= '1';
		enable_reading_moves <= '0';
		load_grid <= '0';
		wait for 10*clk_period;
		reset <= '0';
		wait for clk_period;
		load_grid <= '1';
		wait for clk_period;
		load_grid <= '0';
		wait for clk_period;
		enable_reading_moves <= '1';
      wait;
   end process;
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------
	

end Behavioral;