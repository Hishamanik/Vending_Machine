
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

-- 0: ABCDEF
-- 1: BC
-- 2: ABDEG
-- 3: ABCDG
-- 4: BCEFG
-- 5: ACDFG
-- 6: ACDEFG
-- 7: ABC
-- 8: ABCDEFG
-- 9: ABCFG


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

    select_segment <= '0';  -- you may use either the left or the right seven segment.

--  the process below uses the 'clk' i.e. the undivided clock , i.e. the clock signal from the entity.
--  you can replace it with the divided clock signal later on when you add the 'clk_divider' component.
--  same way, you will need to change the clock signal in the 'elsif' statement inside the process below, later on!

    process(clk,reset)
    begin
        if(reset = '1')then
        ---------------------------------------------
        -- *** write one line of code to update the present state when reset=1
        
        ---------------------------------------------
        elsif(rising_edge(clk))then
        ---------------------------------------------
        -- *** write one line of code to update the present state
        
        ---------------------------------------------
        end if;
    end process;

    process(present_state,coins_in) --*** complete the sensitivity list
        begin
        case present_state is
            when sum_0 =>
                            soft_drink <= '0';
                            granola_bar <= '0';
                            change_out <= "00";
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------

                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            -- for example, if the coins inserted is "10" i.e., 2$, go to state sum_2.
                            
                            ---------------------------------------------
            when sum_1 =>
                            soft_drink <= '0';
                            granola_bar <= '0';
                            change_out <= "00";
                            
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------

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

            when sum_2 =>
                            soft_drink <= '0';
                            granola_bar <= '0';
                            change_out <= "00";
                            
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------
                            
                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            
                            ---------------------------------------------
            when sum_3 =>
                            soft_drink <= '0';
                            granola_bar <= '0';
                            change_out <= "00";
                            
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------

                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            
                            ---------------------------------------------
            when sum_4 =>
                            soft_drink <= '0';
                            granola_bar <= '0';
                            
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------

                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            
                            ---------------------------------------------

            when sum_5 =>
                            soft_drink <= '0';
                            granola_bar <= '0';
                            
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------

                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            
                            ---------------------------------------------
            when sum_6 =>
                            soft_drink <= '0';                       
                            granola_bar <= '0';                            
                            
                            ---------------------------------------------
                            --*** write one line of code to display the current sum of inserted money on the seven segment display
                            ---------------------------------------------

                            ---------------------------------------------
                            --*** update the design lines when coins inserted are 00/01/10/11
                            -- you may use any conditional assignment format
                            -- based on the inserted coins, update the next state
                            
                            ---------------------------------------------
            when dispense =>
                            change_out <= "00";
                            display_sum <= "0111111";

                            if(item_sel='0')then
                            ---------------------------------------------
                            --** write two assignment statements to dispense the soft drink and granola bar
                                
                            ---------------------------------------------
                            else
                            ---------------------------------------------
                            --** write two assignment statements to dispense the soft drink and granola bar
                            
                            ---------------------------------------------
                                
                            end if;
                            next_state <= sum_0;

            end case;
    end process;
end Behavioral;