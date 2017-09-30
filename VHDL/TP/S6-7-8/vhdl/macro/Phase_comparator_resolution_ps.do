onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /phase_comparator/clk_i
add wave -noupdate -format Logic /phase_comparator/clr_cnt_s
add wave -noupdate -format Analog-Step -height 40 -max 5.0 -min -0.0 /phase_comparator/cnt_s
add wave -noupdate -format Analog-Step -height 30 -max 5.0 -min -0.0 /phase_comparator/delta_phase_mod_old_s
add wave -noupdate -format Analog-Step -height 30 -max 5.0 -min -0.0 /phase_comparator/delta_phase_new_s
add wave -noupdate -format Analog-Step -height 40 -max 25.0 -min -9.0 -radix decimal /phase_comparator/delta_phase_o
add wave -noupdate -format Logic /phase_comparator/fref_flk_s
add wave -noupdate -format Logic /phase_comparator/fcomp_flk_s
add wave -noupdate -format Logic /phase_comparator/en_cnt_s
add wave -noupdate -format Logic /phase_comparator/en_s
add wave -noupdate -format Logic /phase_comparator/end_s
add wave -noupdate -format Logic /phase_comparator/fref_i
add wave -noupdate -format Logic /phase_comparator/fref_synchro_s
add wave -noupdate -format Logic /phase_comparator/fref_delay_s
add wave -noupdate -format Logic /phase_comparator/fref_delay_not_s
add wave -noupdate -format Logic /phase_comparator/fcomp_i
add wave -noupdate -format Logic /phase_comparator/fcomp_synchro_s
add wave -noupdate -format Logic /phase_comparator/fcomp_delay_s
add wave -noupdate -format Logic /phase_comparator/fcomp_delay_not_s
add wave -noupdate -format Logic /phase_comparator/fin_calcul_dp_s
add wave -noupdate -format Logic /phase_comparator/moins_1_s
add wave -noupdate -format Logic /phase_comparator/moins_2_s
add wave -noupdate -format Logic /phase_comparator/moins_3_s
add wave -noupdate -format Logic /phase_comparator/pas_de_dephasage_s
add wave -noupdate -format Logic /phase_comparator/plus_1_s
add wave -noupdate -format Logic /phase_comparator/plus_2_s
add wave -noupdate -format Logic /phase_comparator/plus_3_s
add wave -noupdate -format Logic /phase_comparator/preset_s
add wave -noupdate -format Logic /phase_comparator/reset_i
add wave -noupdate -format Logic /phase_comparator/reset_s
add wave -noupdate -format Logic /phase_comparator/set_s
add wave -noupdate -format Logic /phase_comparator/start_calcul_dp_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2481800 ps} 0}
configure wave -namecolwidth 336
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2627363 ps}


force -freeze sim:/phase_comparator/clk_i 1 0, 0 {50 ps} -r 100
force -freeze sim:/phase_comparator/reset_i 1 0
run 50
force -freeze sim:/phase_comparator/fref_i 1 0, 0 {300 ps} -r 600
run 200
force -freeze sim:/phase_comparator/fcomp_i 1 0, 0 {300 ps} -r 600
force -freeze sim:/phase_comparator/reset_i 0 0
run 2000

noforce sim:/phase_comparator/fcomp_i
force -freeze sim:/phase_comparator/fcomp_i 1 0, 0 {301 ps} -r 602
run 500000

noforce sim:/phase_comparator/fcomp_i
force -freeze sim:/phase_comparator/fcomp_i 1 0, 0 {299 ps} -r 598
run 1000000

noforce sim:/phase_comparator/fcomp_i
force -freeze sim:/phase_comparator/fcomp_i 1 0, 0 {301 ps} -r 602
run 1000000