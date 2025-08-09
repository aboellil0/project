create_clock -name fun_clk -period 5 -waveform {0 2.5} [get_ports fun_clk]
set_clock_uncertainty -setup 0.03 [get_clocks fun_clk]
set_clock_uncertainty -hold  0.02 [get_clocks fun_clk]

set_dont_touch_network [get_clocks {fun_clk}]

set_input_delay  -clock fun_clk -max 0.05  [remove_from_collection [all_inputs] [get_ports {fun_clk}]]
set_output_delay -max 0.05 -clock fun_clk [all_outputs] 

group_path -name "comp_paths" -to {fun_clk}
set_app_var compile_ultra_ungroup_dw false
set_wire_load_model  -name ForQA
set_case_analysis 0 test_mode

set_max_transition 0.5 [current_design]
set_max_capacitance 2.0 [current_design]
set_max_fanout 3 $design 
set_max_delay 3 -group_path "comp_paths" -to [all_outputs]

set_load 1 [all_outputs]


set_dont_use [get_lib_cells */**AND3*]
set_dont_use [get_lib_cells */*AND2X4] 
set_dont_use [get_lib_cells */*AND2X1]