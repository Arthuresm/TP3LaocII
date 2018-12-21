onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Tomasulim
add wave -noupdate /tomasulim/CLK
add wave -noupdate /tomasulim/CLR
add wave -noupdate -divider {Fila de Instrucoes}
add wave -noupdate /tomasulim/rtr
add wave -noupdate /tomasulim/adc
add wave -noupdate -radix unsigned /tomasulim/cheio
add wave -noupdate -radix unsigned /tomasulim/vazio
add wave -noupdate /tomasulim/iq/instrIn
add wave -noupdate -radix unsigned -childformat {{{/tomasulim/instrOut[15]} -radix unsigned} {{/tomasulim/instrOut[14]} -radix unsigned} {{/tomasulim/instrOut[13]} -radix unsigned} {{/tomasulim/instrOut[12]} -radix unsigned} {{/tomasulim/instrOut[11]} -radix unsigned} {{/tomasulim/instrOut[10]} -radix unsigned} {{/tomasulim/instrOut[9]} -radix unsigned} {{/tomasulim/instrOut[8]} -radix unsigned} {{/tomasulim/instrOut[7]} -radix unsigned} {{/tomasulim/instrOut[6]} -radix unsigned} {{/tomasulim/instrOut[5]} -radix unsigned} {{/tomasulim/instrOut[4]} -radix unsigned} {{/tomasulim/instrOut[3]} -radix unsigned} {{/tomasulim/instrOut[2]} -radix unsigned} {{/tomasulim/instrOut[1]} -radix unsigned} {{/tomasulim/instrOut[0]} -radix unsigned}} -subitemconfig {{/tomasulim/instrOut[15]} {-height 15 -radix unsigned} {/tomasulim/instrOut[14]} {-height 15 -radix unsigned} {/tomasulim/instrOut[13]} {-height 15 -radix unsigned} {/tomasulim/instrOut[12]} {-height 15 -radix unsigned} {/tomasulim/instrOut[11]} {-height 15 -radix unsigned} {/tomasulim/instrOut[10]} {-height 15 -radix unsigned} {/tomasulim/instrOut[9]} {-height 15 -radix unsigned} {/tomasulim/instrOut[8]} {-height 15 -radix unsigned} {/tomasulim/instrOut[7]} {-height 15 -radix unsigned} {/tomasulim/instrOut[6]} {-height 15 -radix unsigned} {/tomasulim/instrOut[5]} {-height 15 -radix unsigned} {/tomasulim/instrOut[4]} {-height 15 -radix unsigned} {/tomasulim/instrOut[3]} {-height 15 -radix unsigned} {/tomasulim/instrOut[2]} {-height 15 -radix unsigned} {/tomasulim/instrOut[1]} {-height 15 -radix unsigned} {/tomasulim/instrOut[0]} {-height 15 -radix unsigned}} /tomasulim/instrOut
add wave -noupdate -radix unsigned -childformat {{{/tomasulim/iq/instrs[7]} -radix unsigned} {{/tomasulim/iq/instrs[6]} -radix unsigned} {{/tomasulim/iq/instrs[5]} -radix unsigned} {{/tomasulim/iq/instrs[4]} -radix unsigned} {{/tomasulim/iq/instrs[3]} -radix unsigned} {{/tomasulim/iq/instrs[2]} -radix unsigned} {{/tomasulim/iq/instrs[1]} -radix unsigned} {{/tomasulim/iq/instrs[0]} -radix unsigned}} -subitemconfig {{/tomasulim/iq/instrs[7]} {-radix unsigned} {/tomasulim/iq/instrs[6]} {-radix unsigned} {/tomasulim/iq/instrs[5]} {-radix unsigned} {/tomasulim/iq/instrs[4]} {-radix unsigned} {/tomasulim/iq/instrs[3]} {-radix unsigned} {/tomasulim/iq/instrs[2]} {-radix unsigned} {/tomasulim/iq/instrs[1]} {-radix unsigned} {/tomasulim/iq/instrs[0]} {-radix unsigned}} /tomasulim/iq/instrs
add wave -noupdate /tomasulim/iq/iValid
add wave -noupdate /tomasulim/iq/frente
add wave -noupdate /tomasulim/iq/tras
add wave -noupdate -divider PC
add wave -noupdate /tomasulim/pc/incr
add wave -noupdate -radix unsigned /tomasulim/addrOut
add wave -noupdate -divider {Unidade de instrucoes}
add wave -noupdate -radix unsigned /tomasulim/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 174
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
WaveRestoreZoom {0 ps} {1103 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/tomasulim/CLK 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/tomasulim/CLR 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 10ps Edit:/tomasulim/CLR 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/tomasulim/adc 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/tomasulim/rtr 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 400ps Edit:/tomasulim/adc 
wave modify -driver freeze -pattern constant -value 1 -starttime 500ps -endtime 800ps Edit:/tomasulim/rtr 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 51ps Edit:/tomasulim/CLR 
wave modify -driver freeze -pattern constant -value 0 -starttime 500ps -endtime 800ps Edit:/tomasulim/rtr 
wave modify -driver freeze -pattern constant -value St1 -starttime 0ps -endtime 900ps Edit:/tomasulim/adc 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 1000ps Edit:/tomasulim/adc 
WaveCollapseAll -1
wave clipboard restore
