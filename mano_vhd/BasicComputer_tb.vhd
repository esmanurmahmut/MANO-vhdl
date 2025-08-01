library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BasicComputer_tb is
end BasicComputer_tb;

architecture sim of BasicComputer_tb is

    component BasicComputer
        Port (
            clk        : in  std_logic;
            reset      : in  std_logic;
            fgi        : in  std_logic;
            INPR       : in  std_logic_vector(7 downto 0);
            OUTR       : out std_logic_vector(7 downto 0);
            timeCount  : out std_logic_vector(3 downto 0)
        );
    end component;

    signal clk        : std_logic := '0';
    signal reset      : std_logic := '1';
    signal fgi        : std_logic := '0';
    signal INPR       : std_logic_vector(7 downto 0) := (others => '0');
    signal OUTR       : std_logic_vector(7 downto 0);
    signal timeCount  : std_logic_vector(3 downto 0);

    -- 16x4096 ROM placeholder (dummy)
    signal mem_dout_dummy : std_logic_vector(15 downto 0) := (others => '0');

begin

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0'; wait for 10 ns;
            clk <= '1'; wait for 10 ns;
        end loop;
    end process;

    -- DUT
    uut: BasicComputer
        port map (
            clk       => clk,
            reset     => reset,
            fgi       => fgi,
            INPR      => INPR,
            OUTR      => OUTR,
            timeCount => timeCount
        );

    stimulus : process
    begin
        -- Initial reset
        wait for 30 ns;
        reset <= '0';

        -- Simulate normal operation for some time
        wait for 200 ns;

        -- Trigger interrupt by setting fgi high
        fgi <= '1';
        wait for 100 ns;

        -- Clear fgi again
        fgi <= '0';

        -- Continue simulation for a bit
        wait for 30000 ns;

        -- Finish simulation
        assert false report "Simulation Ended" severity failure;
    end process;

end sim;