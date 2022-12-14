library ieee;
use ieee.std_logic_1164.all;

entity decoder is
	port(	reset: 	in std_logic;
		sig:	in std_logic;
		count_in: in std_logic_vector (16 downto 0);
		clk: in std_logic;
		Reset_count: out std_logic;
		sync: out std_logic;
		colour: out std_logic);
end decoder;

library ieee;
use ieee.std_logic_1164.all;

architecture behaviour of decoder is
	type decoder_state is (R, S1, S2, S3 , W, Z, SC_W, SC_Z);
	signal state, new_state: decoder_state;

begin
	lbl3: process (clk)
	begin
	if (clk'event and clk = '1') then
	if reset = '1' then
	state <= R;
	else
	state <= new_state;
	end if;
	end if;
end process;

	lb14: process (state, sig, count_in, clk)
	begin

	case state is

when R =>
	Reset_count <= '1';
	sync <= '0';
	colour <=  '0';
	if (sig = '1') then
	new_state <= S1;
	else
	new_state <= R;
	end if;

when S1 =>
	Reset_count <= '0';
	sync <= '0';
	colour <=  '0';
	if (sig = '0' and count_in > "11011011101110011") then -- meer dan 112499 tellen
	new_state <= S2;
	elsif (sig = '0' and count_in < "11011011101110100") then -- minder dan 112500 (gelijk aan 4.5 ms) tellen
	new_state <= R;
	else
	new_state <= S1;
	end if;


when S2 =>
	Reset_count <= '1';
	sync <= '0';
	colour <=  '0';
	if (sig = '1') then
	new_state <= S3;
	else
	new_state <= S2;
	end if;

when S3 =>
	Reset_count <= '0';
	sync <= '0';
	colour <=  '0';
	if (sig = '0' and count_in > "01100001101001111") then -- meer dan 49999 tellen
	new_state <= Z;
	elsif (sig = '0' and count_in < "01100001101010000") then --minder dan 50 000 (gelijk aan 2 ms) tellen
	new_state <= W;
	else
	new_state <= S3;
	end if;

when W =>
	Reset_count <= '1';
	sync <= '1';
	colour <=  '0';
	new_state <= SC_W;

when Z =>
	Reset_count <= '1';
	sync <= '1';
	colour <=  '1';
	new_state <= SC_Z;

when SC_W =>
	Reset_count <= '0';
	sync <= '1';
	colour <=  '0';
	if (count_in > "01100001101001001") then -- meer dan 9 tellen
	new_state <= S2;
	else
	new_state <= SC_W;
	end if;

when SC_Z =>
	Reset_count <= '0';
	sync <= '1';
	colour <=  '1';
	if (count_in > "01100001101001001") then -- meer dan 9 tellen
	new_state <= S2;
	else
	new_state <= SC_Z;
	end if;						-- tellen = clock cycles

	end case;
	end process;

end behaviour;