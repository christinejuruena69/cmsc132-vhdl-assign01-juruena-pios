library IEEE;
use IEEE.std_logic_1164.all;

entity andGate4 is 
   port( i0, i1, i2, i3: in std_logic;
          o0 : out std_logic);
end andGate4;

architecture func of andGate4 is 
begin
   o0 <= (i0 and i1 and i2 and i3);
end func;
-----------------------------------------------------------
--library IEEE;
--use IEEE.std_logic_1164.all;
--
--entity andGate5 is 
--  port( i0, i1, i2, i3, i4: in std_logic;
--          o0 : out std_logic);
--end andGate5;
--
--architecture func of andGate5 is 
--begin
--   o0 <= (i0 and i1 and i2 and i3 and i4);
--end func;
-----------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity orGateAll is 
   port( i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18: in std_logic;
          o0 : out std_logic);
end orGateAll;

architecture func of orGateAll is 
begin
   o0 <= (i0 or i1 or i2 or i3 or i4 or i5 or i6 or i7 or i8 or i9 or i10 or i11 or i12 or i13 or i14 or i15 or i16 or i17 or i18);
end func;
----------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity notGate is 
  port( i0 : in std_logic;
          o0 : out std_logic);
end notGate;

architecture func of notGate is 
begin
   o0 <= not i0;
end func;

------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity barn_alarm is
	port(alarm: out std_logic;
		i: in std_logic_vector(5 downto 0));
end barn_alarm;

architecture structural of barn_alarm is
	signal negA, negB, negC, negD, negE, negF, gate1, gate2, gate3, gate4, gate5, gate6, gate7, gate8, gate9, gate10, gate11, gate12, gate13, gate14, gate15, gate16, gate17, gate18, gate19 : std_logic; -- declare signals
	
	
	 component andGate4 is 
   		port( i0, i1, i2, i3: in std_logic;
          o0 : out std_logic);
	end component;
	
	--component andGate5 is 
   		--port( i0, i1, i2, i3, i4: in std_logic;
          --o0 : out std_logic);
	--end component;

 
   component orGateAll is     
     port(i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18: in std_logic;
          o0 : out std_logic);
   end component;

   component notGate is       
      port( i0 : in std_logic;
           o0 : out std_logic);
   end component;
   
begin
	-- i(5) = a
	-- i(4) = b
	-- i(3) = c
	-- i(2) = d
	-- i(1) = e
	-- i(0) = f

	g1: notGate  port map(i(5), negA);
	g2: notGate  port map(i(4), negB);
	g3: notGate  port map(i(3), negC);
	g4: notGate  port map(i(2), negD);
	g5: notGate  port map(i(1), negE);
	g6: notGate  port map(i(0), negF);

	-- gate 1: a'c'ef
		g7: andGate4  port map(negA, negC, i(1), i(0), gate1);
		
	-- gate 2: a'c'de
		g8: andGate4  port map(negA, negC, i(2), i(1), gate2);
	
	-- gate 3: a'def
		g9: andGate4  port map(negA, i(2), i(1), i(0), gate3);
	
	-- gate 4: c'def
		g10: andGate4  port map(negC, i(2), i(1), i(0), gate4);
	
	-- gate 5: a'ce'f
		g13: andGate4  port map(negA, i(3), negE, i(0), gate5);
	
	-- gate 6: a'cde'
		g14: andGate4 port map(negA, i(3), i(2), negE, gate6);
	
	-- gate 7: cde'f
	 	g15: andGate4 port map(i(3), i(2), negE, i(0), gate7);
	 	
	-- gate 8: a'bc'e
		g16: andGate4 port map(negA, i(4), negC, i(1), gate8);
	
	-- gate 9: a'bef
		g17: andGate4 port map(negA, i(4), i(1), i(0), gate9);
	
	-- gate 10: bc'ef
		g18: andGate4 port map(i(4), negC, i(1), i(0), gate10);
		
	-- gate 11: a'bde
		g19: andGate4 port map(negA, i(4), i(2), i(1), gate11);
	
	-- gate 12: bc'de
		g20: andGate4 port map(i(4), negC, i(2), i(1), gate12);
	
	-- gate 13: bdef
		g21: andGate4 port map(i(4), i(2), i(1), i(0), gate13);
	
	-- gate 14: a'bce'
		g22: andGate4 port map(negA, i(4), i(3), negE, gate14); 
	
	-- gate 15: bce'f
		g23: andGate4 port map(i(4), i(3), negE, i(0), gate15);
	
	-- gate 16: bcde'
		g24: andGate4 port map(i(4), i(3), i(2), negE, gate16);
	
	-- gate 17: ac'e'f
		g25: andGate4 port map(i(4), negC, negE, i(0), gate17);
	
	-- gate 18: a'c'de'
		g26: andGate4 port map(i(5), negC, i(2), negE, gate18);
	
	-- gate 19: abc'e'
		g27: andGate4 port map(i(5), i(4), negC, negE, gate19);

	-- final output
		g28: orGateAll port map(gate1, gate2, gate3, gate4, gate5, gate6, gate7, gate8, gate9, gate10, gate11, gate12, gate13, gate14, gate15, gate16, gate17, gate18, gate19, alarm);
	
	
end structural;
