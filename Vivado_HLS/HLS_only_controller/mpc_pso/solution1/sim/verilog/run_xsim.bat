
call xelab xil_defaultlib.apatb_Compult_top -prj Compult.prj --lib "ieee_proposed=./ieee_proposed" -s Compult 
call xsim --noieeewarnings Compult -tclbatch Compult.tcl

