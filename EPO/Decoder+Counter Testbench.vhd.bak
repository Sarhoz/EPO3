library IEEE;
use IEEE.std_logic_1164.all;

entity Decoder_Circuit_tb is
end entity Decoder_Circuit_tb;

architecture structural of Decoder_Circuit_tb is

component Decoder_Circuit is
	port (  clk: in    std_logic;
		reset: 	in std_logic;
		sig:	in std_logic;
		sync: out std_logic;
		colour: out std_logic);
	
end component Decoder_circuit;

	signal	clk, reset 		: std_logic;
	signal	sig,sync, colour	: std_logic;

begin 

	lbl5: Decoder_circuit port map	(clk 			=> clk,
					reset			=> reset,
					sig			=> sig,
					sync			=> sync,
					colour			=> colour
				);

	clk			<=	'0' after 0 ns,
					'1' after 40 ns when clk /= '1' else '0' after 40 ns;

	reset			<=	'1' after 0 ns,
					'0' after 5 ms;

	sig			<=	'0' after 0 ms,
					'1' after 10 ms,
					'0' after 13 ms,
					'1' after 20 ms,
					'0' after 25 ms,
					'1' after 30 ms,
					'0' after 31 ms,
					'1' after 33 ms,
					'0' after 34 ms;

end architecture structural;
