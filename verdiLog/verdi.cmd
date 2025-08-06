debImport "-sv"
wvCreateWindow
wvSetPosition -win $_nWave2 {("G1" 0)}
wvOpenFile -win $_nWave2 {/home/pcs/Documents/Aditya_data/pcie_uvm_tb/novas.fsdb}
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
nsMsgSwitchTab -tab general
debImport "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/pcie_agent.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/pcie_driver.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/pcie_env.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/pcie_intf.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/pcie_monitor.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/pcie_pkg.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/pcie_scoreboard.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/pcie_seq_lib.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/pcie_seqr.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/pcie_test_lib.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/pcie_tl_src.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/pcie_tx.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/tb_top.sv" \
          "/home/pcs/Documents/Aditya_data/pcie_uvm_tb/uvm_commons.sv" "-2012" \
          -path {/home/pcs/Documents/Aditya_data/pcie_uvm_tb}
debLoadSimResult /home/pcs/Documents/Aditya_data/pcie_uvm_tb/novas.fsdb
srcHBSelect "tb_top.intf" -win $_nTrace1
srcHBSelect "tb_top.intf" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvCreateWindow
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave3
verdiWindowBeWindow -win $_nWave3
wvResizeWindow -win $_nWave3 0 0 1920 977
wvSelectGroup -win $_nWave3 {G2}
wvZoomAll -win $_nWave3
wvSetCursor -win $_nWave3 94.905978 -snap {("intf(pcie_intf)" 10)}
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 10 )} 
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 10 )} 
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 11 )} 
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 12 )} 
wvSetCursor -win $_nWave3 125.686295 -snap {("intf(pcie_intf)" 2)}
wvSetCursor -win $_nWave3 192.376982 -snap {("intf(pcie_intf)" 1)}
wvSetCursor -win $_nWave3 61.560634 -snap {("intf(pcie_intf)" 1)}
wvSetCursor -win $_nWave3 128.251321 -snap {("intf(pcie_intf)" 1)}
wvSetCursor -win $_nWave3 48.735502 -snap {("intf(pcie_intf)" 2)}
wvSetCursor -win $_nWave3 51.300528 -snap {("intf(pcie_intf)" 1)}
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 30 )} 
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 4 )} 
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 10 )} 
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 10 )} 
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 11 )} 
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 31 )} 
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 31 )} 
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 32 )} 
wvSelectSignal -win $_nWave3 {( "intf(pcie_intf)" 33 )} 
wvGetSignalClose -win $_nWave3
wvCloseWindow -win $_nWave3
verdiSetActWin -dock widgetDock_<Inst._Tree>
debReload
verdiSetActWin -win $_OneSearch
srcHBSelect "tb_top.intf" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_top.intf" -win $_nTrace1
wvCreateWindow
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave4
verdiWindowBeWindow -win $_nWave4
wvResizeWindow -win $_nWave4 0 0 1920 977
wvSelectGroup -win $_nWave4 {G2}
wvZoomAll -win $_nWave4
wvSetCursor -win $_nWave4 775.738174 -snap {("G2" 0)}
wvGetSignalClose -win $_nWave4
wvCloseWindow -win $_nWave4
verdiSetActWin -dock widgetDock_<Inst._Tree>
debExit
