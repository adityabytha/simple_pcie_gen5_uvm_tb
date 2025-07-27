//TEST BENCH TOP FILE of PCIE
//
//

`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "uvm_macros.svh"

//`include "pcie_pkg.sv"
//import pcie_pkg::*;
`include "uvm_commons.sv"
`include "pcie_env.sv"
`include "pcie_test_lib.sv"

module tb_top;

	initial begin

		`uvm_info("TB_TOP","THIS IS IN TOP OF TB",UVM_INFO)
		//$display("THSI\n");
		run_test();
	end

endmodule
