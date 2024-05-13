
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name Z53-Leon-Blazevic -dir "E:/Z53-Leon-Blazevic/planAhead_run_2" -part xc6slx45fgg676-2
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "running_light.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {running_light.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top running_light $srcset
add_files [list {running_light.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx45fgg676-2
