
-----------------------------------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: Shyama Gandhi and Bruce Cockburn
--
-- Create Date: 10/11/2021 09:50:46 PM
-- Design Name:
-- Module Name: vending - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: VENDING MACHINE - LAB 2 : ECE 410 (2021)
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--*********************************************************************************
-- The Vending Machine accepts 1$, 2$ and 3$ denominations. soft drink price : 2$, granola bar : 4$
-- The current sum of the total money inserted should be displayed on the seven segment.
-- Hand over the change to the customer, and then dispense the item (soft drink/granola bar)
----------------------------------------------------------------------------------

-- 7 segment display
-- 0: ABCDEF    1111110
-- 1: BC        0110000
-- 2: ABDEG     1101101
-- 3: ABCDG     1111001
-- 4: BCEFG     0110111
-- 5: ACDFG     1011011
-- 6: ACDEFG    1011111
-- 7: ABC       1110000
-- 8: ABCDEFG   1111111
-- 9: ABCFG     1110011


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity vending_m is
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
         
end vending_m;

architecture Behavioral of vending_m is

---------------------------------------------
-- *** Add the clk_divider component here
-- Remember, you want to add this component here and then use it later when you wish to have the divided clock by a factor of 62500000
---------------------------------------------
component clk_divider is
    Port (clk_in : in STD_LOGIC;
            clk_out : out STD_LOGIC);
end component;

signal clk_o : std_logic;
type state_type is (sum_0,         -- state names represent the total sum of inserted money by the user
                    sum_1,
                    sum_2,
                    sum_3,
                    sum_4,
                    sum_5,
                    sum_6,
                    dispense);

signal present_state,next_state: state_type;    -- current and next state declaration.

begin

---------------------------------------------
-- *** port map the clk_divider here

---------------------------------------------
-- port map the clk_divider here
    label_clk_divider:
        clk_divider port map(
            clk_in => clk,
            clk_out => clk_o);

    select_segment <= '0';  -- you may use either the left or the right seven segment.

--  the process below uses the 'clk' i.e. the undivided clock , i.e. the clock signal from the entity.
--  you can replace it with the divided clock signal later on when you add the 'clk_divider' component.
--  same way, you will need to change the clock signal in the 'elsif' statement inside the process below, later on!

    process(clk,reset)
    begin
        if(reset = '1')then
        ---------------------------------------------
        -- *** write one line of code to update the present state when reset=1
        present_state <= sum_0;
        ---------------------------------------------
        elsif(rising_edge(clk))then
        ---------------------------------------------
        -- *** write one line of code to update the present state
        present_state <= next_state;
        ---------------------------------------------
        end if;
    end process;

    process(next_state, coins_in) --*** complete the sensitivity list
        begin
        case present_state is
            when sum_0 =>
                            soft_drink <= '0';
                            granola_bar <= '0';
                            change_out <= "00";
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------
                            display_sum <= "1111110";

                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            -- for example, if the coins inserted is "10" i.e., 2$, go to state sum_2.
                            
                            ---------------------------------------------
                            case coins_in is 
                                when "00" =>
                                    next_state <= sum_0;
                                when "01" =>
                                    display_sum <= "0110000"; --sum of 1
                                    next_state <= sum_1;
                                when "10" =>
                                    display_sum <= "1011011"; --sum of 2
--                                    if (item_sel = '0') then
--                                        next_state <= dispense;
--                                        change_out <= "00";
--                                    else
                                        next_state <= sum_2;
                                    --end if;
                                when others =>
                                    display_sum <= "1011011";-- sum of 3
--                                    if (item_sel = '0') then
--                                        next_state <= dispense; --dispense soft drink
--                                        change_out <= "01";
--                                    else
                                        next_state <= sum_3;
                                    --end if;
                            end case;
                            
            when sum_1 =>
                           soft_drink <= '0';
                           granola_bar <= '0';
                            change_out <= "00";
                            
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------
                            display_sum <= "0110000";
                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            -- for example, if the coins inserted is "10" i.e., 2$,
                            -- the total amount inserted till now is 2$ + 1$ = 3$. So, you wish to update the next_state accordingly.
                            
                            
                            -- For example, say, if item_sel=0, and user inserted 1$, so the total amount is 2$. The next state is now, sum_2.
                            -- In this case inside sum_2, you now want to return if any change and then dispense the soft drink.
                            -- Make sure, from "sum_2" to "sum_6", you also take care to even check if item_sel=0 or item_sel=1 and update the state accordingly. 
                            ---------------------------------------------
                            case coins_in is
                                when "00" =>
                                    next_state <= sum_1; --stays in same state
                                when "01" =>
                                    display_sum <= "1101101";-- sum of 2
--                                    if (item_sel = '0') then
--                                        next_state <= dispense;
--                                        change_out <= "00";
--                                    else
                                        next_state <= sum_2;
                                    --end if;
                                when "10" =>
                                    display_sum <= "1111001";-- sum of 3
--                                    if (item_sel = '0') then
--                                        next_state <= dispense;
--                                        change_out <= "01";
--                                    else 
                                        next_state <= sum_3;
                                    --end if;
                                when others =>
                                    display_sum <= "0110111";-- sum of 4
--                                    if (item_sel = '0') then
--                                        next_state <= dispense; --dispense soft drink
--                                        change_out <= "10";
--                                    elsif (item_sel = '1') then
--                                        next_state <= dispense; --dispense granola bar
--                                        change_out <= "00";
--                                    else
                                        next_state <= sum_4;
                                    --end if;
                              end case;

            when sum_2 =>
--                            soft_drink <= '0';
--                            granola_bar <= '0';
--                            change_out <= "00";
                            
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------
                            display_sum <= "1101101";
                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            
                            ---------------------------------------------
                            if (item_sel = '0') then
                                next_state <= dispense;
                                --change_out <= "00";
                            else
                                
                            case coins_in is
                                when "00" =>
                                    next_state <= sum_2;
                                when "01" =>
                                    display_sum <= "1111001";-- sum of 3 
--                                    if (item_sel = '0') then
--                                        next_state <= dispense;
--                                        change_out <= "01";
--                                    else
                                        next_state <= sum_3;
                                    --end if;
                                when "10" =>
                                    display_sum <= "0110111";-- sum of 4
--                                    next_state <= dispense; --dispense granola bar
--                                    change_out <= "00";
                                        next_state <= sum_4;
                                when others =>
--                                    display_sum <= "1011011";-- sum of 5
--                                    next_state <= dispense; --dispense granola bar
--                                    change_out <= "01";
                                    next_state <= sum_5;
                              end case;
                             end if;
            when sum_3 =>
--                            soft_drink <= '0';
--                            granola_bar <= '0';
--                            change_out <= "00";
                            
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------
                            display_sum <= "1001111"; --sum of 3

                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            
                            ---------------------------------------------
                            if (item_sel = '0') then
                                next_state <= sum_2;
                                change_out <= "01";
                            else
                            case coins_in is 
                                when "00" =>
                                    next_state <= sum_3;
                                when "01" =>
--                                    display_sum <= "0110111"; --sum of 4
--                                    next_state <= dispense;
--                                    change_out <= "00";
                                    next_state <= sum_4;
                                when "10" =>
--                                        display_sum <= "1011011"; --sum of 5
--                                        next_state <= dispense;
--                                        change_out <= "01";
                                    next_state <= sum_5;
                                when others =>
--                                    display_sum <= "1011111"; --sum of 6
--                                    next_state <= dispense;
--                                    change_out <= "10";
                                        next_state <= sum_6;
                             end case;
                             end if;
            when sum_4 =>
--                            soft_drink <= '0';
--                            granola_bar <= '0';
                            
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------
                            display_sum <= "0110111";
                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            
                            ---------------------------------------------
                            if (item_sel = '0') then
                                next_state <= dispense;
                                change_out <= "10";
                            else 
                                next_state <= dispense;
                            end if;
--                            case coins_in is 
--                                when "00" =>
--                                    next_state <= sum_4;
--                                when "01" =>
--                                    display_sum <= "1011011";-- sum of 5
--                                    if (item_sel = '0') then
--                                        next_state <= dispense;
--                                        change_out <= "11";
--                                    elsif (item_sel = '1') then
--                                        next_state <= dispense;
--                                        change_out <= "01";   
--                                    else
--                                        next_state <= sum_5;
--                                    end if;
--                                when "10" =>
--                                    display_sum <= "1011111";-- sum of 6
--                                    if (item_sel = '1') then
--                                        next_state <= dispense;
--                                        change_out <= "10";   
--                                    else
--                                        next_state <= sum_6;
--                                    end if;
--                                when others =>
--                                    display_sum <= "1110000";-- sum of 7
--                             end case;

            when sum_5 =>
--                            soft_drink <= '0';
--                            granola_bar <= '0';
                            
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------
                            display_sum <= "1011011";
                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            
                            ---------------------------------------------
                            
                            next_state <= sum_4;
                            --next_state <= dispense;
                            change_out <= "01";
                            
--                            case coins_in is 
--                                when "00" =>
--                                    next_state <= sum_5;
--                                when "01" =>
--                                    display_sum <= "1011111";-- sum of 6
--                                    if (item_sel = '1') then
--                                        next_state <= dispense;
--                                        change_out <= "10";   
--                                    else
--                                        next_state <= sum_6;
--                                    end if;
--                                when "10" =>
--                                    display_sum <= "1110000";-- sum of 7
--                                    if (item_sel = '1') then
--                                        next_state <= dispense;
--                                        change_out <= "11";   
--                                    end if;
--                                when others =>
--                                    display_sum <= "1111111";-- sum of 8
--                             end case;
            when sum_6 =>
--                            soft_drink <= '0';                       
--                            granola_bar <= '0';                            
                            
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------
                            display_sum <= "1011111";
                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            
                            ---------------------------------------------
                            next_state <= sum_4;
                            change_out <= "10";
--                           case coins_in is 
--                                when "00" =>
--                                    next_state <= sum_6;
--                                when "01" =>
--                                    display_sum <= "1110000";-- sum of 7
--                                    if (item_sel = '1') then
--                                        next_state <= dispense;
--                                        change_out <= "11";
--                                    end if;
--                                when "10" =>
--                                    display_sum <= "1111111";-- sum of 8
--                                    if (item_sel = '1') then
--                                        next_state <= dispense;
--                                        change_out <= "11";   
--                                    end if;
--                                when others =>
--                                    display_sum <= "1110011";-- sum of 9
--                             end case;
            when dispense =>
--                            change_out <= "00";
--                            display_sum <= "0111111";

                            if(item_sel='0')then
                            ---------------------------------------------
                            --** write two assignment statements to dispense the soft drink and granola bar
                                
                            ---------------------------------------------
                                soft_drink <= '1';
                                granola_bar <= '0';
                            else
                            ---------------------------------------------
                            --** write two assignment statements to dispense the soft drink and granola bar
                            
                            ---------------------------------------------
                               soft_drink <= '0';
                               granola_bar <= '1';
                                
                            end if;
                            next_state <= sum_0;

            end case;
    end process;
end Behavioral;