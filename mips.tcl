# setup

set_host_options -max_cores 6

# mulyi corners 
set worst_case "said90_max.db"
set H_worst_case "said90_max.hvt.db"
set best_case "said90_min.db"
set balanced_case "said90nm_typ.db"
lappend search_path "/home/ICer/Downloads/Lib/synopsys/models"
set_app_var target_library [list $worst_case]
set_app_var link_library "* $target_library"


#work directory
sh rm -rf work 
sh mkdir -p work 
define_design_lib work -path ./work

# set top modul 
set design mips_16
# definde sructured verufucatuib format svf
set_svf ${design}.svf


#### translate 
analyze -format verilog -lib work ../../rtl/${design}.v
elaborate $design -lib work
current_design
check_design

#### constraints
source ../cons.tcl

#### optimization 
set_fix_multiple_port_nets -all -buffer_constants
link



#### reports 
report_area -nosplit > ../reports/syn_area.rpt
report_power -nosplit > ../reports/syn_power.rpt
report_cell > ../reports/syn_cells.rpt
report_qor > ../reports/syn_qor.rpt
report_clock > ../reports/clock.rpt
report_constraint -all_violators -nosplit > ../reports/syn_violations.rpt
report_timing > ../reports/critical_path_timing.rpt
report_timing -max_paths 20 > ../reports/syn_timing.rpt



#### outputs

define_name_rules no_case -case_insensitive
change_names -rule no_case -hierarchy
change_names -rule verilog -hierarchy
report_names -rules verilog
write_sdc ../output.sdc
write_sdf ../output.sdf
write -f ddc -hierarchy -output ../output.ddc
set_svf -off


