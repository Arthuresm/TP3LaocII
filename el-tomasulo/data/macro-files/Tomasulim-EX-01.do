onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tomasulim/CLK
add wave -noupdate /tomasulim/CLR
add wave -noupdate /tomasulim/step
add wave -noupdate /tomasulim/counter
add wave -noupdate /tomasulim/maisAntiga
add wave -noupdate /tomasulim/quemSai
add wave -noupdate /tomasulim/OP
add wave -noupdate /tomasulim/ID_out
add wave -noupdate -divider PC
add wave -noupdate /tomasulim/addrOut
add wave -noupdate -divider {Memoria de Inst}
add wave -noupdate /tomasulim/q
add wave -noupdate -divider {Fila de Instrucoes}
add wave -noupdate /tomasulim/iq/instrIn
add wave -noupdate /tomasulim/iq/frente
add wave -noupdate /tomasulim/iq/tras
add wave -noupdate /tomasulim/iq/iValid
add wave -noupdate /tomasulim/iq/instrs
add wave -noupdate /tomasulim/cheio
add wave -noupdate /tomasulim/vazio
add wave -noupdate /tomasulim/adc
add wave -noupdate /tomasulim/rtr
add wave -noupdate /tomasulim/instrOut
add wave -noupdate -divider {Registrador de Instrucoes}
add wave -noupdate /tomasulim/IRin
add wave -noupdate /tomasulim/IRout
add wave -noupdate -divider {Banco de Registradores}
add wave -noupdate /tomasulim/RF/regs
add wave -noupdate /tomasulim/RF/depRegs
add wave -noupdate /tomasulim/wren
add wave -noupdate /tomasulim/numW
add wave -noupdate /tomasulim/depW
add wave -noupdate /tomasulim/dataW
add wave -noupdate /tomasulim/depR0
add wave -noupdate /tomasulim/depR1
add wave -noupdate /tomasulim/numR0
add wave -noupdate /tomasulim/numR1
add wave -noupdate /tomasulim/dataR0
add wave -noupdate /tomasulim/dataR1
add wave -noupdate -divider {Estacao de Reserva}
add wave -noupdate /tomasulim/start
add wave -noupdate /tomasulim/busy
add wave -noupdate /tomasulim/Est1/cont
add wave -noupdate /tomasulim/Est1/Vj
add wave -noupdate /tomasulim/Est1/Vk
add wave -noupdate /tomasulim/Est1/Qj
add wave -noupdate /tomasulim/Est1/Qk
add wave -noupdate /tomasulim/Est1/OPcode
add wave -noupdate /tomasulim/Est1/ID_out
add wave -noupdate /tomasulim/Est1/despacho
add wave -noupdate /tomasulim/Est1/OP
add wave -noupdate /tomasulim/Est1/Valor1
add wave -noupdate /tomasulim/Est1/Valor2
add wave -noupdate /tomasulim/Est1/clockInstr
add wave -noupdate -divider {UA (addSub)}
add wave -noupdate /tomasulim/addSub/start
add wave -noupdate /tomasulim/addSub/Dado1
add wave -noupdate /tomasulim/addSub/Dado2
add wave -noupdate /tomasulim/addSub/op
add wave -noupdate /tomasulim/addSub/ID_out
add wave -noupdate /tomasulim/addSub/confirmacao
add wave -noupdate /tomasulim/addSub/busy
add wave -noupdate /tomasulim/addSub/Resultado
add wave -noupdate /tomasulim/addSub/cont
add wave -noupdate -divider decAddSub
add wave -noupdate /tomasulim/decConfAddSub/CLK
add wave -noupdate /tomasulim/decConfAddSub/ID
add wave -noupdate /tomasulim/decConfAddSub/confirma
add wave -noupdate -divider Edicoes
add wave -noupdate /tomasulim/CLK
add wave -noupdate /tomasulim/CLR
add wave -noupdate /tomasulim/CLK
add wave -noupdate /tomasulim/CLR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {524 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 245
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
WaveRestoreZoom {0 ps} {2041 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 2000ps sim:/tomasulim/CLK 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 2000ps sim:/tomasulim/CLR 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 10ps Edit:/tomasulim/CLR 
WaveCollapseAll -1
wave clipboard restore
