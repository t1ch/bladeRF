# 1. Define the input reference clock (38.4 MHz, Period = 26.042ns)
create_clock -name {c5_clock2} -period 26.042ns [get_ports {c5_clock2}]

# 2. Instruct the tool to automatically derive clocks from the PLL 
#    fed by c5_clock2. This is what generates the 80 MHz clock domain (sys_clock).
#    (This step is typically handled by 'derive_pll_clocks' if your tool flow uses it.)
derive_pll_clocks

# 3. (Optional but good practice) Ensure the timing path between clock domains is correctly handled,
#    especially for the high-speed FX3 PCLK (100MHz)
create_clock -name {fx3_pclk} -period 10.0ns [get_ports {fx3_pclk}]
