library ieee;
use ieee.std_logic_1164.all;

entity counter is
	port(	reset: 	in std_logic;
		Reset_count: in std_logic;
		clk: in std_logic;
		count:  out std_logic_vector (19 downto 0)	);
end counter;

library ieee;
use ieee.std_logic_1164.all;

architecture behaviour of counter is
	signal count, new_count		: unsigned (19 downto 0);

-- Register process
	process (clk)
	begin
		if (rising_edge (clk)) then
			if (Reset_count = '1') then
				count <= (others => '0');
			else
				count <= new_count;
			end if;
		end if;
	end process;
