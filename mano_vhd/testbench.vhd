library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench is
end testbench;

architecture behavior of testbench is

    -- Component Under Test
    component BasicComputer
        Port (
            clk           : in  std_logic;
            ps2_clk       : in  std_logic;
            ps2_data      : in  std_logic;
            ps2_code      : out std_logic_vector(6 downto 0);
            ps2_code_new  : out std_logic;
            reset         : in  std_logic;
            fgi           : out std_logic;
            INPR          : in  std_logic_vector(7 downto 0);
            OUTR          : out std_logic_vector(7 downto 0);
            timeCount     : out std_logic_vector(3 downto 0);
            kontrol       : out std_logic;
            seg           : out std_logic_vector(6 downto 0);
            an            : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Testbench Signals
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '0';
    signal ps2_clk     : std_logic := '1';
    signal ps2_data    : std_logic := '1';
    signal ps2_code    : std_logic_vector(6 downto 0);
    signal ps2_code_new: std_logic;
    signal fgi         : std_logic;
    signal INPR        : std_logic_vector(7 downto 0) := (others => '0');
    signal OUTR        : std_logic_vector(7 downto 0);
    signal timeCount   : std_logic_vector(3 downto 0);
    signal kontrol     : std_logic;
    signal seg         : std_logic_vector(6 downto 0);
    signal an          : std_logic_vector(3 downto 0);

    constant clk_period : time := 20 ns;  -- 50 MHz clock

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: BasicComputer
        port map (
            clk           => clk,
            ps2_clk       => ps2_clk,
            ps2_data      => ps2_data,
            ps2_code      => ps2_code,
            ps2_code_new  => ps2_code_new,
            reset         => reset,
            fgi           => fgi,
            INPR          => INPR,
            OUTR          => OUTR,
            timeCount     => timeCount,
            kontrol       => kontrol,
            seg           => seg,
            an            => an
        );

    -- Clock Process
    clk_process : process
    begin
        while now < 5 ms loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        -- Apply reset
        reset <= '1';
        wait for 100 ns;
        reset <= '0';

        -- Wait a bit
        wait for 1 us;

        -- Send a fake PS/2 "A" key = 0x1C (example) 
        -- (simplified: not full PS/2 protocol, only illustrative!)
        ps2_data <= '0';  -- Start bit
        ps2_clk <= '0'; wait for 100 ns; ps2_clk <= '1'; wait for 100 ns;

        for i in 0 to 7 loop
            ps2_data <= std_logic(to_unsigned(16#1C#, 8)(i));  -- Send 0x1C bit by bit
            ps2_clk <= '0'; wait for 100 ns; ps2_clk <= '1'; wait for 100 ns;
        end loop;

        ps2_data <= '1';  -- Parity (simplified)
        ps2_clk <= '0'; wait for 100 ns; ps2_clk <= '1'; wait for 100 ns;

        ps2_data <= '1';  -- Stop bit
        ps2_clk <= '0'; wait for 100 ns; ps2_clk <= '1'; wait for 100 ns;

        -- Wait to observe effects
        wait for 10 ms;

        -- Finish simulation
        wait;
    end process;

end behavior;