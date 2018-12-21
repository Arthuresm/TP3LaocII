onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate /ASRS/CLK
add wave -noupdate /ASRS/CLR
add wave -noupdate /ASRS/start
add wave -noupdate /ASRS/ID_in
add wave -noupdate /ASRS/CDB
add wave -noupdate /ASRS/IRout
add wave -noupdate /ASRS/depR0
add wave -noupdate /ASRS/depR1
add wave -noupdate /ASRS/dataR0
add wave -noupdate /ASRS/dataR1
add wave -noupdate /ASRS/confirma
add wave -noupdate -divider Outputs
add wave -noupdate /ASRS/ID_out
add wave -noupdate /ASRS/busy
add wave -noupdate /ASRS/despacho
add wave -noupdate /ASRS/OP
add wave -noupdate /ASRS/Valor1
add wave -noupdate /ASRS/Valor2
add wave -noupdate -divider {Variaveis auxiliares}
add wave -noupdate /ASRS/Qk
add wave -noupdate /ASRS/cont
add wave -noupdate /ASRS/Vj
add wave -noupdate /ASRS/Vk
add wave -noupdate /ASRS/Qj
add wave -noupdate /ASRS/OPcode
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {101 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 265
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
WaveRestoreZoom {0 ps} {1050 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/ASRS/CLK 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/ASRS/CLR 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 10ps Edit:/ASRS/CLR 
wave create -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 1000ps sim:/ASRS/start 
wave create -driver freeze -pattern constant -value 011 -range 2 0 -starttime 0ps -endtime 1000ps sim:/ASRS/ID_in 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 1010101010101010 -range 18 0 -starttime 0ps -endtime 1000ps sim:/ASRS/CDB 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 1010101010101001 -range 15 0 -starttime 0ps -endtime 1000ps sim:/ASRS/IRout 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 010 -range 2 0 -starttime 0ps -endtime 1000ps sim:/ASRS/depR0 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 011 -range 2 0 -starttime 0ps -endtime 1000ps sim:/ASRS/depR1 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0000000000000001 -range 15 0 -starttime 0ps -endtime 1000ps sim:/ASRS/dataR0 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0000000000000001 -range 15 0 -starttime 0ps -endtime 1000ps sim:/ASRS/dataR1 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/ASRS/confirma 
wave modify -driver freeze -pattern constant -value 1 -starttime 900ps -endtime 1000ps Edit:/ASRS/confirma 
WaveCollapseAll -1
wave clipboard restore
