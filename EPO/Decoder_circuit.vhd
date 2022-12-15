library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Decoder_Circuit is
	port (  clk: in    std_logic;
		reset: 	in std_logic;
		sig:	in std_logic;
		sync: out std_logic;
		colour: out std_logic);
	
end entity Decoder_circuit;

architecture structural of Decoder_circuit is

Component decoder is
	port(	reset: 	in std_logic;
		sig:	in std_logic;
		count_in: in std_logic_vector (16 downto 0);
		clk: in std_logic;
		Reset_count: out std_logic;
		sync: out std_logic;
		colour: out std_logic);
end component decoder;

Component counter is
	port(	reset: 	in std_logic;
		Reset_count: in std_logic;
		clk: in std_logic;
		count_out:  out std_logic_vector (16 downto 0)	
	);
end component counter;


signal Reset_count, motor_r_reset: std_logic;
signal count: std_logic_vector (16 downto 0);



begin
	lb11: decoder port map	(	clk			=> clk,
					reset			=> reset,
					count_in		=> count,
					sig			=> sig,
					Reset_count		=> Reset_count,
					sync			=> sync,
					colour			=> colour
	);

	lb12: counter port map	(	clk			=> clk,
					reset			=> reset,
					count_out		=> count,
					Reset_count		=> Reset_count
	);

end architecture;					

