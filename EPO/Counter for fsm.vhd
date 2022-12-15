library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
	port(	reset: 	in std_logic;
		Reset_count: in std_logic;
		clk: in std_logic;
		count_out:  out std_logic_vector (16 downto 0)	);
end counter;

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behaviour of counter is
	signal count, new_count		: unsigned (16 downto 0);

begin
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


	-- Adder process
	process (count)
	begin
		new_count 	<= count + 1;
	end process;

	count_out	<= std_logic_vector(count);

end architecture behaviour;
