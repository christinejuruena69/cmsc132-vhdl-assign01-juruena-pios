library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alarm_tb is
	constant MAX_COMB: integer := 64; -- number of 4-bit combinations (2^6 = 64)
	constant DELAY: time := 1 ns; -- time delay for testing
end entity alarm_tb;

architecture tb of alarm_tb is
	signal alarm: std_logic; -- validity indicator from UUT
	signal i: std_logic_vector(5 downto 0); --inputs to UUT
	
	component barn_alarm is
		port(	alarm: out std_logic; 
				i: in std_logic_vector(5 downto 0));
		
	end component barn_alarm;
	
begin
	UUT: component barn_alarm port map(alarm, i);
	
	main: process is
		variable temp: unsigned(5 downto 0);
		variable expected_alarm: std_logic;
		variable error_count: integer := 0; -- for counting errors
		
	begin
		report "Start simulation.";
		
		for count in 0 to 63 loop -- since there are 16 possible combinations of 4-bit binary values
			temp := TO_UNSIGNED(count, 6);
			i(5) <= std_logic(temp(5)); -- bit #6
			i(4) <= std_logic(temp(4)); -- bit #5
			i(3) <= std_logic(temp(3)); -- bit #4
			i(2) <= std_logic(temp(2)); -- bit #3
			i(1) <= std_logic(temp(1)); -- bit #2
			i(0) <= std_logic(temp(0)); -- bit #1
			
			if (count=3)or(count=6)or(count=7)or(count=9)or(count=12)or(count=13)or(count=15)or(count=18)or(count=19)or((count>=22)and(count<=25))or((count>=27)and(count<=31))or(count=33)or(count=36)or(count=37)or(count=39)or(count=45)or(count=48)or(count=49)or((count>=51)and(count<=55))or(count=57)or(count=60)or(count=61)or(count=63) then expected_alarm := '1';
			
			else expected_alarm := '0';
			end if;
			
			wait for DELAY;
			
			assert (expected_alarm = alarm)
				-- error report
				report "ERROR: Expected alarm " & 
					std_logic'image(expected_alarm) &
					" but found " &
					std_logic'image(alarm) &
					" at time " & time'image(now);
					
			if(expected_alarm /= alarm)
				then error_count := error_count + 1; -- increments error_count value when errors are encountered
			end if;
		end loop;
		
		wait for DELAY;
		
		assert (error_count = 0) -- checks if there were errors and displays the number
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
				
		if(error_count = 0) then -- displays message when no errors were found
			report "Simulation completed with NO errors.";
		end if;
		
		wait;
	end process;
end architecture tb;		
