library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity OA_I is 
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
end OA_I;

architecture OA_I of OA_I is 
	signal A, Ain : STD_LOGIC_VECTOR(7 downto 0);
	signal B, Bin :	STD_LOGIC_VECTOR(7 downto 0);
	signal C, Cin : STD_LOGIC_VECTOR(7 downto 0);
	signal CnT : integer range 0 to 8;
	signal TgB : STD_LOGIC;
	signal A1 : STD_LOGIC_VECTOR(7 downto 0);
	signal A2 : STD_LOGIC;
	signal A3 : STD_LOGIC;
	signal A4 : integer range 0 to 1;
	signal CF : STD_LOGIC;
	signal OF1 : STD_LOGIC;
	signal SUM : STD_LOGIC_VECTOR(8 downto 0);
begin
	process(clk, rst)
	begin
		if rst = '1' then
			A <= (others => '0');
			B <= (others => '0');
			C <= (others => '0');
			CnT <= 0;
			TgB <= '0';
		elsif rising_edge(clk) then
			A <= Ain;
			B <= Bin;
			C <= Cin;
			
			if y(4) = '1' then
				CnT <= 8;
			elsif y(8) = '1' then 
				CnT <= CnT - 1;
			elsif y(13) = '1' then
				CnT <= 1;
			end if;
			
			if y(6) = '1' then
				TgB <= B(0);
			end if;
			
			if (y(5) or y(11) or y(14) or y(18)) = '1' then
				CF <= SUM(8);
				OF1 <= C(7) xor A1(7) xor SUM(7) xor SUM(8);
			end if;
		end if;
	end process;
	
	A1 <= 	A(7 downto 0) when y(5) = '1' else
			(not(A(7 downto 0))) when y(11) = '1' else 
			"0000" & A(7 downto 4) when y(14) = '1' else
			B(7 downto 0) when y(18) = '1' else 
			A1;
	A2 <=  '1' when y(11) = '1' else 
			'0';
	A3 <=	CF when y(9) = '1' else
			C(7) when y(10) = '1' else
			A3;
			
	SUM <= "0"&C(7 downto 0) + A1 + A2 when (y(5) or y(11) or y(14) or y(18)) = '1' else SUM;
		
	Ain <= 	d1 when y(1) = '1' else
			A(6 downto 0)&"0" when y(16) = '1' else
			A;
			
	Bin <= 	d2 when y(2) = '1' else
			C(0)&B(7 downto 1) when y(7) = '1' else 
			C(7 downto 0) when y(17) = '1' else
			B;
			
	Cin <= 	"00000000" when y(3) = '1' else
			SUM(7 downto 0) when (y(5) or y(11) or y(14) or y(18)) = '1' else
		  	A3&C(7 downto 1) when (y(9) or y(10)) = '1' else 
			C(6 downto 0)&"0" when y(15) = '1' else
			C; 
			
	x(1) <= '1' when cop = '1' else '0';
	x(2) <= '1' when B(0) = '1' else '0';
	x(3) <= '1' when OF1 = '1' else '0';	
	x(4) <= '1' when Cnt = 0 else '0';
	x(5) <= '1' when TgB = '1' else '0'; 
	
	R <= C(7 downto 0) & B(7 downto 0) when y(12) = '1' else
		"00000000" & C(7 downto 0) when y(19) = '1' else (others => 'Z');
end OA_I;
