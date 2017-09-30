onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Analog-Step -height 80 -max 5.0 -min -0.0 /pll_numerique_tb/pll_numerique1/pha1/delta_phase_mod_old_s
add wave -noupdate -format Logic /pll_numerique_tb/clk_sti
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/clk3x_s
add wave -noupdate -format Logic /pll_numerique_tb/fref_sti
add wave -noupdate -format Logic /pll_numerique_tb/f_obs
add wave -noupdate -format Analog-Step -height 80 -max 10845500.0 -min 10554500.0 -radix unsigned /pll_numerique_tb/fe_input_sti
add wave -noupdate -format Analog-Step -height 60 -max 3035110.0 -min 2947980.0 -radix unsigned /pll_numerique_tb/pll_numerique1/step_s
add wave -noupdate -format Analog-Step -height 50 -max 50000.0 -min -50000.0 -radix decimal /pll_numerique_tb/pll_numerique1/fm_s
add wave -noupdate -format Analog-Step -height 80 -max 140000.0 -min -140000.0 -radix decimal /pll_numerique_tb/pll_numerique1/delta_sigma1/dna_i
add wave -noupdate -format Analog-Step -height 60 -max 40000.0 -min 20000.0 -radix decimal /pll_numerique_tb/pll_numerique1/delta_sigma1/input_resize_s
add wave -noupdate -format Analog-Step -height 80 -max 250.0 -min -200.0 -radix decimal /pll_numerique_tb/out_dec_obs
add wave -noupdate -format Analog-Step -max 5.0 -min -0.0 -radix decimal /pll_numerique_tb/pll_numerique1/pha1/delta_phase_new_s
add wave -noupdate -format Analog-Step -max 5.0 -min -0.0 /pll_numerique_tb/pll_numerique1/pha1/delta_phase_mod_old_s
add wave -noupdate -format Analog-Step -height 30 -max 5.0 -min -5.0 -radix decimal /pll_numerique_tb/pll_numerique1/pha1/delta_phase_o
add wave -noupdate -format Logic /pll_numerique_tb/out_obs
add wave -noupdate -format Analog-Step -height 80 -max 0.00040000000000000002 /pll_numerique_tb/t_v
add wave -noupdate -format Literal /pll_numerique_tb/init_temps_v
add wave -noupdate -format Literal -radix unsigned /pll_numerique_tb/inputperiod_s
add wave -noupdate -format Logic /pll_numerique_tb/reset_sti
add wave -noupdate -format Literal /pll_numerique_tb/omega_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/clk_i
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/clki_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/reset_i
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/out_o
add wave -noupdate -format Literal -radix decimal /pll_numerique_tb/pll_numerique1/delta_phase_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/fref_i
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/fcomp_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fref_synchro_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fcomp_synchro_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fref_flk_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fcomp_flk_s
add wave -noupdate -format Literal -radix decimal /pll_numerique_tb/pll_numerique1/delta_sigma1/dna_full_s
add wave -noupdate -format Literal /pll_numerique_tb/pll_numerique1/pha1/cnt_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/end_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fcomp_delay_not_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fcomp_delay_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fcomp_flk_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fcomp_i
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fcomp_synchro_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fref_delay_not_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fref_delay_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fref_flk_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fref_i
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/fref_synchro_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/moins_1_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/moins_2_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/moins_3_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/pas_de_dephasage_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/plus_1_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/plus_2_s
add wave -noupdate -format Logic /pll_numerique_tb/pll_numerique1/pha1/plus_3_s
add wave -noupdate -format Logic /pll_numerique_tb/clk_3x_sti
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 7} {179342926 ps} 0} {{Cursor 8} {259806374 ps} 0}
configure wave -namecolwidth 437
configure wave -valuecolwidth 96
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 10
configure wave -griddelta 10
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {424428822 ps}


run 400000000