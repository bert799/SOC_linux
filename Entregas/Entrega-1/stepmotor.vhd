--
-- Rafael C.
-- ref:
--   - https://www.intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjects/hdl/vhdl/vhdl_pro_state_machines.htm
--   - https://www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl/
--   - https://www.digikey.com/eewiki/pages/viewpage.action?pageId=4096117

library IEEE;
use IEEE.std_logic_1164.all;

entity stepmotor is
    port (
        -- Gloabals
        clk   : in  std_logic;

        -- controls
        en      : in std_logic;                     -- 1 on/ 0 of
        dir     : in std_logic;                     -- 1 clock wise
        vel     : in std_logic_vector(1 downto 0);  -- 00: low / 11: fast

        -- I/Os
        phases  : out std_logic_vector(3 downto 0)
  );
end entity stepmotor;

architecture rtl of stepmotor is

   TYPE STATE_TYPE IS (s0, s1, s2, s3);
   SIGNAL state  : STATE_TYPE := s0;
   signal enable : std_logic  := '0';
   signal topCounter : integer range 0 to 50000000;
	signal maxSteps : integer range 0 to 200000000;
  
begin

  process(clk)
  begin
    if (rising_edge(clk)) then
      CASE state IS
      WHEN s0=>
        if (enable = '1') then
          state <= s1;
        end if;
      WHEN s1=>
        if (enable = '1') then
          state <= s2;
        end if;
      WHEN s2=>
        if (enable = '1') then
          state <= s3;
        end if;
      WHEN s3=>
        if (enable = '1') then
          state <= s0;
        end if;
      when others=>
        state <= s0;
      END CASE;
    end if;
  end process;

  PROCESS (state, dir)
   BEGIN
      CASE state IS
        WHEN s0 =>
          phases <= "0001";
        WHEN s1 =>
			if (dir =  '0') then
          phases <= "0010";
			else
			 phases <= "1000";
			end if;
        WHEN s2 =>
          phases <= "0100";
        when s3 =>
		   if (dir = '0') then
          phases <= "1000";
			else
			 phases <= "0010";
			end if;
        when others =>
          phases <= "0000";
      END CASE;
   END PROCESS;

  topCounter <= 10000000 when vel = "00" else 
					 1000000 when vel = "01" else
					 500000 when vel = "10" else
					 100000 when vel = "11" else
                  100000;

  maxSteps <= 200000000;						
						
  process(clk, en, dir, maxSteps)
	 variable tempMaxCounter : integer range 0 to 50000000 := 10000000;
    variable counter : integer range 0 to 50000000 := 0;
	 variable steps : integer range 0 to 20000 := 0;
  begin
   if (en = '1') then
    if (rising_edge(clk) and steps <= maxSteps) then
      if (counter < tempMaxCounter) then
        counter := counter + 1;
        enable  <= '0';
      else
        counter := 0;
        enable  <= '1';
		  if tempMaxCounter >= topcounter then
			tempMaxCounter := tempMaxCounter - 100000;
		  else 
		   steps := steps + 1;
		  end if;
      end if;
    end if;
	else 
	 if en = '0' then
		steps := 0;
		tempMaxCounter := 10000000;
	 end if;
	end if;
  end process;

end rtl;
