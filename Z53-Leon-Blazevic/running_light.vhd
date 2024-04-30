library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity running_light is
	port(
		CLK : in STD_LOGIC;
		SW : in STD_LOGIC_VECTOR(1 downto 0);
		LED : out STD_LOGIC_VECTOR(7 downto 0)
		);
end running_light;

architecture Behavioral of running_light is
	signal brojac: integer range 0 to 25_000_000; --pocetni brojac za frek 32Hz
	signal LED_index : integer range 0 to 7 := 0; --pocetni indeks postavljen na 0
	
	constant CLK_FREQ: integer := 50_000_000; --Frekvencija sata u Hz
	
	
	--konstante za dostupne frekvencije
	constant FREQ_4HZ: integer :=4;
	constant FREQ_8HZ: integer :=8;
	constant FREQ_16HZ: integer :=16;
	constant FREQ_32HZ: integer :=32;
	
	
	--racun za konstante
	constant COUNTER_MAX_4HZ : integer := CLK_FREQ / (2* FREQ_4HZ);
	constant COUNTER_MAX_8HZ : integer := CLK_FREQ / (2* FREQ_8HZ);
	constant COUNTER_MAX_16HZ : integer := CLK_FREQ / (2* FREQ_16HZ);
	constant COUNTER_MAX_32HZ : integer := CLK_FREQ / (2* FREQ_32HZ);
begin
	process(CLK,SW)
		begin
			if (clk'event and clk='1') then
				case SW is
					when "00" =>
						brojac <= brojac +1;
						if brojac = COUNTER_MAX_4HZ then
							brojac <= 0;
							LED_index <= LED_index + 1;
						end if;
						
					when "01" =>
						brojac <= brojac +1;
						if brojac = COUNTER_MAX_8HZ then
							brojac <= 0;
							LED_index <= LED_index + 1;
						end if;
						
					when "10" =>
						brojac <= brojac +1;
						if brojac = COUNTER_MAX_16HZ then
							brojac <= 0;
							LED_index <= LED_index + 1;
						end if;
						
					when "11" =>
						brojac <= brojac +1;
						if brojac = COUNTER_MAX_32HZ then
							brojac <= 0;
							LED_index <= LED_index + 1;
						end if;
						
					when others => null;
				end case;
			
			
				--resetiranje indeksa LED kada su sve prošle nazad na 0
				if LED_index = 8 then 
					LED_index <= 0;
				end if;
				
				
				--postavljanje da samo jedna LED svijetli s indeksom
				LED <= (others => '0');
				LED(LED_index) <= '1';
			end if;
		end process;
end Behavioral;

