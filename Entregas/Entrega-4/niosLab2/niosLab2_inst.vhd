	component niosLab2 is
		port (
			clk_clk         : in  std_logic                    := 'X';             -- clk
			leds_export     : out std_logic_vector(5 downto 0);                    -- export
			reset_reset_n   : in  std_logic                    := 'X';             -- reset_n
			inputs_in_port  : in  std_logic_vector(5 downto 0) := (others => 'X'); -- in_port
			inputs_out_port : out std_logic_vector(5 downto 0)                     -- out_port
		);
	end component niosLab2;

	u0 : component niosLab2
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --    clk.clk
			leds_export     => CONNECTED_TO_leds_export,     --   leds.export
			reset_reset_n   => CONNECTED_TO_reset_reset_n,   --  reset.reset_n
			inputs_in_port  => CONNECTED_TO_inputs_in_port,  -- inputs.in_port
			inputs_out_port => CONNECTED_TO_inputs_out_port  --       .out_port
		);

