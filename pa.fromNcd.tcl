
# PlanAhead Launch Script for Post PAR Floorplanning, created by Project Navigator

create_project -name project -dir "C:/Users/thoma/CloudStation/School/2MA/semester2/ADA/labs/project/planAhead_run_1" -part xc3s400fg456-5
set srcset [get_property srcset [current_run -impl]]
set_property design_mode GateLvl $srcset
set_property edif_top_file "C:/Users/thoma/CloudStation/School/2MA/semester2/ADA/labs/project/Game_logic.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/thoma/CloudStation/School/2MA/semester2/ADA/labs/project} }
set_property target_constrs_file "Game_logic.ucf" [current_fileset -constrset]
add_files [list {Game_logic.ucf}] -fileset [get_property constrset [current_run]]
link_design
read_xdl -file "C:/Users/thoma/CloudStation/School/2MA/semester2/ADA/labs/project/Game_logic.ncd"
if {[catch {read_twx -name results_1 -file "C:/Users/thoma/CloudStation/School/2MA/semester2/ADA/labs/project/Game_logic.twx"} eInfo]} {
   puts "WARNING: there was a problem importing \"C:/Users/thoma/CloudStation/School/2MA/semester2/ADA/labs/project/Game_logic.twx\": $eInfo"
}
