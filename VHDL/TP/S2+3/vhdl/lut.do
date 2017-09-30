force -freeze sim:/main/new_data_i 0 0
force -freeze sim:/main/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/main/reset 0 0
run
force -freeze sim:/main/reset 1 0
run
force -freeze sim:/main/reset 0 0
run 10
force -freeze sim:/main/new_data_i 1 0
run 250000