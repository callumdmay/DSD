library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;

ENTITY g25_4bit_register IS PORT(
    d   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    ld  : IN STD_LOGIC; -- load/enable.
    clr : IN STD_LOGIC; -- async. clear.
    clk : IN STD_LOGIC; -- clock.
    q   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- output
);
END g25_4bit_register;

ARCHITECTURE description OF g25_4bit_register IS

BEGIN
    process(clk, clr)
    begin
        if clr = '1' then
            q <= "0000";
        elsif rising_edge(clk) then
            if ld = '1' then
                q <= d;
            end if;
        end if;
    end process;
END description;