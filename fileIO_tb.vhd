-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
	
library std;
use std.textio.all;

 --entity declaration
entity filehandle is
end filehandle;

--architecture definition
architecture Behavioral of filehandle is
--period of clock,bit for indicating end of file.
signal clock,endoffile : bit := '0';
--data read from the file.
signal    dataread : real;
--data to be saved into the output file.
signal    datatosave : real;
--line number of the file read or written.
signal    linenumber : integer:=1; 

begin


clock <= not (clock) after 1 ns;    --clock with time period 2 ns


--read process
reading :
process
    file   infile    : text is in  "input.txt";   --declare input file
    variable  inline    : line; --line number declaration
    variable  dataread1    : real;
begin
wait until clock = '1' and clock'event;
if (not endfile(infile)) then   --checking the "END OF FILE" is not reached.
readline(infile, inline);       --reading a line from the file.
  --reading the data from the line and putting it in a real type variable.
read(inline, dataread1);
dataread <=dataread1;   --put the value available in variable in a signal.
else
endoffile <='1';         --set signal to tell end of file read file is reached.
end if;

end process reading;

--write process
writing :
process
    file      outfile  : text is out "output.txt";  --declare output file
    variable  outline  : line;   --line number declaration  
begin
wait until clock = '0' and clock'event;
if(endoffile='0') then   --if the file end is not reached.
--write(linenumber,value(real type),justified(side),field(width),digits(natural));
write(outline, dataread, right, 16, 12);
-- write line to external file.
writeline(outfile, outline);
linenumber <= linenumber + 1;
else
null;
end if;

end process writing;

end Behavioral;