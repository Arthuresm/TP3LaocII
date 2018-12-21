onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /registerFile/CLK
add wave -noupdate /registerFile/CLR
add wave -noupdate /registerFile/wren
add wave -noupdate -radix unsigned /registerFile/numW
add wave -noupdate -radix unsigned /registerFile/numR0
add wave -noupdate -radix unsigned /registerFile/numR1
add wave -noupdate -radix unsigned /registerFile/depW
add wave -noupdate -radix unsigned /registerFile/dataW
add wave -noupdate -radix unsigned /registerFile/depR0
add wave -noupdate -radix unsigned /registerFile/depR1
add wave -noupdate -radix unsigned /registerFile/dataR0
add wave -noupdate -radix unsigned /registerFile/dataR1
add wave -noupdate -radix unsigned /registerFile/regs
add wave -noupdate -radix unsigned /registerFile/depRegs
add wave -noupdate -radix unsigned /registerFile/R0
add wave -noupdate -radix unsigned /registerFile/R1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {941 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 165
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1155 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/registerFile/CLK 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/registerFile/CLR 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/registerFile/wren 
wave create -driver freeze -pattern counter -startvalue 000 -endvalue 111 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 2 0 -starttime 0ps -endtime 1000ps sim:/registerFile/numW 
WaveExpandAll -1
wave create -driver freeze -pattern counter -startvalue 000 -endvalue 111 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 2 0 -starttime 0ps -endtime 1000ps sim:/registerFile/numR0 
WaveExpandAll -1
wave create -driver freeze -pattern counter -startvalue 111 -endvalue 000 -type Range -direction Down -period 100ps -step 1 -repeat forever -range 2 0 -starttime 0ps -endtime 1000ps sim:/registerFile/numR1 
WaveExpandAll -1
wave create -driver freeze -pattern counter -startvalue 000 -endvalue 001 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 2 0 -starttime 0ps -endtime 1000ps sim:/registerFile/depW 
WaveExpandAll -1
wave create -driver freeze -pattern counter -startvalue 0000000000000000 -endvalue 1111111111111111 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 15 0 -starttime 0ps -endtime 1000ps sim:/registerFile/dataW 
WaveExpandAll -1
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 10ps Edit:/registerFile/CLR 
wave modify -driver freeze -pattern clock -initialvalue 1 -period 200ps -dutycycle 50 -starttime 0ps -endtime 1000ps Edit:/registerFile/wren 
wave modify -driver freeze -pattern constant -value 101 -range 15 0 -starttime 0ps -endtime 100ps Edit:/registerFile/dataW 
wave modify -driver freeze -pattern constant -value 1 -range 2 0 -starttime 300ps -endtime 700ps Edit:/registerFile/depW 
WaveCollapseAll -1
wave clipboard restore
