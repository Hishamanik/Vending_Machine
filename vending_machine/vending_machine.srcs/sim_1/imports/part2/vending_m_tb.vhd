
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vending_m_tb is
end vending_m_tb;

architecture Behavioral of vending_m_tb is

component vending_m is 
  Port ( clk            : in std_logic;
         reset          : in std_logic;
         item_sel       : in std_logic;                           -- sel=0 for soft drink (2$), sel=1 for granola bar (4$)
         coins_in       : in std_logic_vector(1 downto 0);        -- "00" - 0$, "01" - 1$, "10" - 2$, "11" - 3$
         change_out     : out std_logic_vector(1 downto 0);       -- changeout is displayed on two leds - "00" - 0$
                                                                  -- "01" - 1$, "10" - 2$ and "11" - 3$
         display_sum    : out std_logic_vector(6 downto 0);       -- display the current sum of inserted money on the seven segment
         select_segment : out std_logic;                          -- select the left or right segment
         soft_drink       : out std_logic;                        -- turn on the LED to dispense soft drink
         granola_bar      : out std_logic);                       -- turn on the LED to dispense granola bar
end component;

signal clk_design       : std_logic;
signal rst              : std_logic;
signal item_select      : std_logic;
signal coins            : std_logic_vector(1 downto 0) ; 
signal change           : std_logic_vector(1 downto 0);
signal display          : std_logic_vector(6 downto 0);
signal segment          : std_logic;
signal soft_drink_dispense    : std_logic;
signal granola_bar_dispense   : std_logic;
--signal dispensed        : std_logic_vector(1 downto 0);

constant clk_period : time := 40 ns;

begin
    --*** add the design lines to port map the entity here
    VENDING_ENT : vending_m port map (clk => clk_design,
                                    reset => rst,
                                    item_sel => item_select,
                                    coins_in => coins,
                                    change_out => change,
                                    display_sum => display,
                                    select_segment => segment,
                                    soft_drink => soft_drink_dispense,
                                    granola_bar => granola_bar_dispense);    
                    
   clk_process :process
   begin
        clk_design <= '0';
        wait for clk_period/2;  
        clk_design <= '1';
        wait for clk_period/2;  
   end process;                                   

    stim_proc: PROCESS 
    begin 
    
    rst <= '1';
    item_select <= '0';
    --wait for clk_period;
    coins <= "11";
    wait for clk_period;
    coins <= "10";
    wait for clk_period;
--    coins <= "10";
--    wait for clk_period;
    
--    rst <= '0';
--    item_select <= '';
--    --wait for clk_period;
--    coins <= "11";
--    wait for clk_period;
--    coins <= "10";
--    wait for clk_period;
        
    end process;
end Behavioral;