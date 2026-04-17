`define DWIDTH 9


module simple_counter (clk, reset, counter);

input clk, reset;
output reg [`DWIDTH-1:0] counter;



always @(posedge clk)
begin
	if (reset) begin
        counter <= 0;
	end
	else begin
        if (counter < 128)
            counter <= counter + 1;
        else 
            counter <= counter + 4;
	end
end


endmodule