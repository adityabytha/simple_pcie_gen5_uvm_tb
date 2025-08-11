Not done yet. PLEASE DO NOT CLONE just yet.

This is PCIE gen5 but not that exactly.



PCIe Gen5:
Config header is 64B of 32-bit registers i.e. 16 regs
	1. { device_id [31:16] , vendor_id [15:0 ] }
	2. { status    [31:16] , command   [15:0 ] }
	3. { class_code [31:8] , revision_id [7:0] }
	4. { bist [31:24] , header_type [23:16] , latency_timer [15:8] , cache_line_size [7:0] }
	5. { bar_0 [31:0] }
	
TLP Header is 3 or 4 DWs (Double Words = 32'b):
	1. [2:0] fmt - format
	2. [4:0] type1 - type
	3. [2:0] tc - traffic class
	4. 	ln - 
	5.      th - TLP processing hints
	6. [2:0] attr - Attributes
	7. [1:0] at - Address Translation
	8. 	td - ECRC there or not
	9. 	ep - Poisoned TLP data
	10. [9:0] length - payload length
	11. [15:0] requester_id - bdf id of requester
	12. [9:0] tag - tag to identify TLP
	13. [3:0] first_be - first byte enable for start of unalgined wr/rd
	14. [3:0] last_be - last byte enable for end of unaligned wr/rd
	15. [63:0] address - address of data
	16. [255:0] data - Assume 256-bit payload

Traffic class for prioritisation using TC/VC mapping.
TLP processing hints present if th = 1b
TLP is errenous and get rid of it if ep = 1b
Attributes have each bit meaning [2] = 1b - ID based reordering can be done
				[1] = 1b - PCI-X relaxed ordering model
				[0]  = 1b - No snoop required (cache related)
Address Translation at = 1b - convert virtual address to physical address.
Requester id - is present in Cpl and CplDs. It has BDF values that tell RC where the data came from.
(*important)LN means length in bytes, it specifics that length of tlp is in Bytes instead of DWs. Only used in specailized packets. Should be hardcoded to 0 in standard TLPs (memRd, memWr, Cpl, etc).
