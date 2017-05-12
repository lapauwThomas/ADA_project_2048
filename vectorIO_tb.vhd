-- TestBench Template 

  LIBRARY ieee;
  
  LIBRARY std;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  use std.textio.all;
  
use ieee.std_logic_textio.all;
  
entity example_file_io_tb is
end example_file_io_tb;
 
 
architecture behave of example_file_io_tb is
 

  file file_VECTORS : text;
  file file_RESULTS : text;
 
  constant c_WIDTH : natural := 4;
 
  signal r_ADD_TERM1 : std_logic_vector(c_WIDTH-1 downto 0) := (others => '0');
  signal r_ADD_TERM2 : std_logic_vector(c_WIDTH-1 downto 0) := (others => '0');
  signal w_SUM       : std_logic_vector(c_WIDTH downto 0);
   
begin
 
  
  process
    variable v_ILINE     : line;
    variable v_OLINE     : line;
    variable v_ADD_TERM1 : std_logic_vector(c_WIDTH-1 downto 0);
    variable v_ADD_TERM2 : std_logic_vector(c_WIDTH-1 downto 0);
    variable v_SPACE     : character;
	 variable my_string   : string(0 to 3);
     
  begin
 
    file_open(file_VECTORS, "input.txt",  read_mode);
    file_open(file_RESULTS, "output.txt", write_mode);
 
    while not endfile(file_VECTORS) loop
      readline(file_VECTORS, v_ILINE);
      read(v_ILINE, v_ADD_TERM1);
		read(v_ILINE, v_SPACE);
		read(v_ILINE, my_string);
		
		report my_string;
      --read(v_ILINE, v_SPACE);           -- read in the space character
      --read(v_ILINE, v_ADD_TERM2);
 
      -- Pass the variable to a signal to allow the ripple-carry to use it
      r_ADD_TERM1 <= v_ADD_TERM1;
      --r_ADD_TERM2 <= v_ADD_TERM2;
 
      wait for 60 ns;
 
      write(v_OLINE, r_ADD_TERM1, right, r_ADD_TERM1'length);
      writeline(file_RESULTS, v_OLINE);
    end loop;
 
    file_close(file_VECTORS);
    file_close(file_RESULTS);
     
    wait;
  end process;
  
  end;