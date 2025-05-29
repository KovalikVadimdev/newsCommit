library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity OA_I_tb is
end OA_I_tb;

--}} End of automatically maintained section

architecture OA_I_tb of OA_I_tb is 

	component OA_I is 
	port (
		clk : in STD_LOGIC;
		cop : in STD_LOGIC;
		rst : in STD_LOGIC;
		d1 : in STD_LOGIC_VECTOR(7 downto 0);
		d2 : in STD_LOGIC_VECTOR(7 downto 0);
		y : in STD_LOGIC_VECTOR(19 downto 1);
		r : out STD_LOGIC_VECTOR(15 downto 0);
		x : out STD_LOGIC_VECTOR(5 downto 1)
	);
	end component;
	
	signal clk : STD_LOGIC;
	signal cop : STD_LOGIC;
	signal rst : STD_LOGIC;
	signal d1 : STD_LOGIC_VECTOR(7 downto 0);
	signal d2 : STD_LOGIC_VECTOR(7 downto 0);
	signal y : STD_LOGIC_VECTOR(19 downto 1);
	signal x : STD_LOGIC_VECTOR(5 downto 1);

	signal T : time := 20 ns;
begin

	UUT : OA_I port map (
		clk => clk,
		cop => cop,
		rst => rst,
		d1 => d1,
		d2 => d2,
		y => y,
		x => x
	);
	
	clk_proc: process
	begin
		clk <= '0';
		wait for T/2;
		clk <= '1';
		wait for T/2;
	end process;
	
	stim_proc: process
	begin
		cop <= '1';
		rst <= '1';
		d1 <= "00000010";
		d2 <= "00000010";
		wait for T;
		rst <= '0';
		wait for T;
		y <= (3 => '1', 1 => '1', 13 => '1', others => '0');
		wait for T;
		y <= (14 => '1', others => '0');
		wait for T;
		y <= (15 => '1', 16 => '1', others => '0');
		wait for T;
		y <= (17 => '1', 16 => '1', others => '0');
		wait for T;
		y <= (15 => '1', 16 => '1', others => '0');
		wait for T;
		y <= (15 => '1', 16 => '1', others => '0');
		wait for T;
		y <= (18 => '1', 8 => '1', others => '0');
		wait for T;
		y <= (14 => '1', others => '0');
		wait for T;
		y <= (19 => '1', others => '0');
		wait;
	end process;

end OA_I_tb;
