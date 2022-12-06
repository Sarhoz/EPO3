library ieee;
use ieee.std_logic_1164.all;

entity decoder is
	port(	reset: 	in std_logic;
		sig:	in std_logic;
		count: in std_logic;
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
	lbl1: process (clk)
	begin
	if (clk'event and clk = '1') then
	if res = '1' then
	state <= R;
	else
	state <= new_state;
	end if;
	end if;
end process

	lb12: process (state, sig, count, clk)
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
	if (sig = '0' and count > '??') then
	new_state <= S2;
	elsif (sig = '1' and count < '??') then
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
	if (sig = '0' and count > '??') then
	new_state <= W;
	elsif (sig = '0' and count < '??') then
	new_state <= Z;
	else
	new_state <= S3;
	end if;

when W =>
	Reset_count <= '1';
	sync <= '1';
	colour <=  '0';
	new_state <= SC_W;
	end if;

when Z =>
	Reset_count <= '1';
	sync <= '1';
	colour <=  '1';
	new_state <= SC_Z;
	end if;

when Z =>
	Reset_count <= '1';
	sync <= '1';
	colour <=  '1';
	new_state <= SC_Z;
	end if;

when SC_W =>
	Reset_count <= '0';
	sync <= '1';
	colour <=  '0';
	if (count > '??') then
	new_state <= S2;
	else
	new_state <= SC_W;
	end if;

when SC_Z =>
	Reset_count <= '0';
	sync <= '1';
	colour <=  '1';
	if (count > '??') then
	new_state <= S2;
	else
	new_state <= SC_Z;
	end if;

	end case;
	end process;

end behaviour;