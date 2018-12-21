onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tomasulim/step
add wave -noupdate /tomasulim/counter
add wave -noupdate /tomasulim/maisAntiga
add wave -noupdate /tomasulim/quemSai
add wave -noupdate /tomasulim/ID_out
add wave -noupdate /tomasulim/OP_Rd
add wave -noupdate /tomasulim/CDB
add wave -noupdate -divider PC
add wave -noupdate /tomasulim/addrOut
add wave -noupdate -divider {Memoria de Inst}
add wave -noupdate /tomasulim/instrUnit/address
add wave -noupdate /tomasulim/instrUnit/data
add wave -noupdate /tomasulim/instrUnit/wren
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
add wave -noupdate -radix unsigned -childformat {{{/tomasulim/RF/regs[7]} -radix decimal} {{/tomasulim/RF/regs[6]} -radix decimal} {{/tomasulim/RF/regs[5]} -radix decimal} {{/tomasulim/RF/regs[4]} -radix decimal} {{/tomasulim/RF/regs[3]} -radix decimal} {{/tomasulim/RF/regs[2]} -radix decimal} {{/tomasulim/RF/regs[1]} -radix decimal} {{/tomasulim/RF/regs[0]} -radix decimal}} -expand -subitemconfig {{/tomasulim/RF/regs[7]} {-height 15 -radix decimal} {/tomasulim/RF/regs[6]} {-height 15 -radix decimal} {/tomasulim/RF/regs[5]} {-height 15 -radix decimal} {/tomasulim/RF/regs[4]} {-height 15 -radix decimal} {/tomasulim/RF/regs[3]} {-height 15 -radix decimal} {/tomasulim/RF/regs[2]} {-height 15 -radix decimal} {/tomasulim/RF/regs[1]} {-height 15 -radix decimal} {/tomasulim/RF/regs[0]} {-height 15 -radix decimal}} /tomasulim/RF/regs
add wave -noupdate -expand /tomasulim/RF/depRegs
add wave -noupdate /tomasulim/wren
add wave -noupdate /tomasulim/numW
add wave -noupdate /tomasulim/depW
add wave -noupdate /tomasulim/depR0
add wave -noupdate /tomasulim/depR1
add wave -noupdate /tomasulim/numR0
add wave -noupdate /tomasulim/numR1
add wave -noupdate /tomasulim/dataR0
add wave -noupdate /tomasulim/dataR1
add wave -noupdate /tomasulim/start
add wave -noupdate /tomasulim/busy
add wave -noupdate -divider {Estacao de Reserva 01 Add Sub}
add wave -noupdate /tomasulim/Est1/start
add wave -noupdate /tomasulim/Est1/busy
add wave -noupdate /tomasulim/Est1/cont
add wave -noupdate -radix unsigned /tomasulim/Est1/Vj
add wave -noupdate -radix unsigned /tomasulim/Est1/Vk
add wave -noupdate /tomasulim/Est1/Qj
add wave -noupdate /tomasulim/Est1/Qk
add wave -noupdate /tomasulim/Est1/OPcode
add wave -noupdate /tomasulim/Est1/ID_out
add wave -noupdate /tomasulim/Est1/despacho
add wave -noupdate -radix unsigned /tomasulim/Est1/Valor1
add wave -noupdate -radix unsigned /tomasulim/Est1/Valor2
add wave -noupdate /tomasulim/Est1/clockInstr
add wave -noupdate /tomasulim/Est1/OP_Rd
add wave -noupdate -divider {Estacao de Reserva 02}
add wave -noupdate /tomasulim/Est2/start
add wave -noupdate /tomasulim/Est2/busy
add wave -noupdate /tomasulim/Est2/cont
add wave -noupdate /tomasulim/Est2/Vj
add wave -noupdate /tomasulim/Est2/Vk
add wave -noupdate /tomasulim/Est2/Qj
add wave -noupdate /tomasulim/Est2/Qk
add wave -noupdate /tomasulim/Est2/OPcode
add wave -noupdate /tomasulim/Est2/ID_out
add wave -noupdate /tomasulim/Est2/despacho
add wave -noupdate /tomasulim/Est2/Valor1
add wave -noupdate /tomasulim/Est2/Valor2
add wave -noupdate /tomasulim/Est2/clockInstr
add wave -noupdate /tomasulim/Est2/OP_Rd
add wave -noupdate -divider {Estacao de Reserva 01 Load - Store}
add wave -noupdate /tomasulim/Est5/start
add wave -noupdate /tomasulim/Est5/busy
add wave -noupdate /tomasulim/Est5/cont
add wave -noupdate /tomasulim/Est5/confirma
add wave -noupdate /tomasulim/Est5/Vj
add wave -noupdate /tomasulim/Est5/Vk
add wave -noupdate /tomasulim/Est5/Qj
add wave -noupdate /tomasulim/Est5/Qk
add wave -noupdate /tomasulim/Est5/OPcode
add wave -noupdate /tomasulim/Est5/ID_out
add wave -noupdate /tomasulim/Est5/despacho
add wave -noupdate /tomasulim/Est5/Valor1
add wave -noupdate /tomasulim/Est5/Valor2
add wave -noupdate /tomasulim/Est5/clockInstr
add wave -noupdate /tomasulim/Est5/OP_Rd
add wave -noupdate -divider {Estacao de Reserva 02 Load-Store}
add wave -noupdate /tomasulim/Est6/start
add wave -noupdate /tomasulim/Est6/busy
add wave -noupdate /tomasulim/Est6/cont
add wave -noupdate /tomasulim/Est6/confirma
add wave -noupdate /tomasulim/Est6/Vj
add wave -noupdate /tomasulim/Est6/Vk
add wave -noupdate /tomasulim/Est6/Qj
add wave -noupdate /tomasulim/Est6/Qk
add wave -noupdate /tomasulim/Est6/OPcode
add wave -noupdate /tomasulim/Est6/ID_out
add wave -noupdate /tomasulim/Est6/despacho
add wave -noupdate /tomasulim/Est6/Valor1
add wave -noupdate /tomasulim/Est6/Valor2
add wave -noupdate /tomasulim/Est6/Valor3
add wave -noupdate /tomasulim/Est6/clockInstr
add wave -noupdate /tomasulim/Est6/OP_Rd
add wave -noupdate -divider {UA (addSub)}
add wave -noupdate /tomasulim/addSub/start
add wave -noupdate -radix decimal /tomasulim/addSub/Dado1
add wave -noupdate -radix decimal /tomasulim/addSub/Dado2
add wave -noupdate /tomasulim/addSub/confirmacao
add wave -noupdate /tomasulim/addSub/busy
add wave -noupdate -radix binary /tomasulim/addSub/Resultado
add wave -noupdate /tomasulim/addSub/cont
add wave -noupdate /tomasulim/addSub/OP_Rd
add wave -noupdate -divider decAddSub
add wave -noupdate /tomasulim/decConfAddSub/CLK
add wave -noupdate /tomasulim/decConfAddSub/ID
add wave -noupdate /tomasulim/decConfAddSub/confirma
add wave -noupdate -divider {UA (loadStore)}
add wave -noupdate /tomasulim/loadStore/start
add wave -noupdate -radix unsigned /tomasulim/loadStore/Dado1
add wave -noupdate -radix unsigned /tomasulim/loadStore/Dado2
add wave -noupdate /tomasulim/loadStore/confirmacao
add wave -noupdate /tomasulim/loadStore/busy
add wave -noupdate /tomasulim/loadStore/Resultado
add wave -noupdate /tomasulim/loadStore/cont
add wave -noupdate /tomasulim/loadStore/OP_Rd
add wave -noupdate -divider decLoadStore
add wave -noupdate /tomasulim/decConfLoadStore/CLK
add wave -noupdate /tomasulim/decConfLoadStore/ID
add wave -noupdate /tomasulim/decConfLoadStore/confirma
add wave -noupdate -divider {CDB Arb}
add wave -noupdate /tomasulim/Arb/CLR
add wave -noupdate /tomasulim/Arb/CLK1
add wave -noupdate /tomasulim/Arb/CLK2
add wave -noupdate /tomasulim/Arb/controle
add wave -noupdate -radix binary /tomasulim/Arb/resultadoAddSub
add wave -noupdate /tomasulim/Arb/resultadoLoadStore
add wave -noupdate /tomasulim/Arb/wren_banco
add wave -noupdate /tomasulim/Arb/RD
add wave -noupdate -divider Edicoes
add wave -noupdate /tomasulim/CLK
add wave -noupdate /tomasulim/CLR
add wave -noupdate /tomasulim/CLK
add wave -noupdate /tomasulim/CLR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1894 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 245
configure wave -valuecolwidth 163
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
WaveRestoreZoom {1621 ps} {3459 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 2000ps sim:/tomasulim/CLK 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 2000ps sim:/tomasulim/CLR 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 10ps Edit:/tomasulim/CLR 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 4000ps Edit:/tomasulim/CLK 
wave modify -driver freeze -pattern constant -value St0 -starttime 10ps -endtime 4000ps Edit:/tomasulim/CLR 
wave modify -driver freeze -pattern clock -initialvalue St0 -period 100ps -dutycycle 50 -starttime 4000ps -endtime 5000ps Edit:/tomasulim/CLK 
wave modify -driver freeze -pattern constant -value 0 -starttime 4000ps -endtime 5000ps Edit:/tomasulim/CLR 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 5000ps -endtime 6000ps Edit:/tomasulim/CLK 
wave modify -driver freeze -pattern constant -value 0 -starttime 5000ps -endtime 6000ps Edit:/tomasulim/CLR 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 6000ps -endtime 7000ps Edit:/tomasulim/CLK 
wave modify -driver freeze -pattern constant -value 0 -starttime 6000ps -endtime 7000ps Edit:/tomasulim/CLR 
WaveCollapseAll -1
wave clipboard restore
