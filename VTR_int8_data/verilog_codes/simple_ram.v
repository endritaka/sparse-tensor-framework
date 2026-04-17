`define DWIDTH 32
`define NUM_WORDS 512
`define ADDR_WIDTH 9

module simple_ram (clk, wren, addr, data, out);

input clk, wren;
input [`ADDR_WIDTH-1:0] addr;
input [`DWIDTH-1:0] data;
output reg [`DWIDTH-1:0] out;


// RAM
reg [`DWIDTH-1:0] ram[`NUM_WORDS-1:0];


always @ (posedge clk) begin 
  if (wren) begin
      ram[addr] <= data;
  end
  else begin
      out <= ram[addr];
  end
end


endmodule