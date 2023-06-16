

module MSBDetection(
    clk,
	 nRESET,
	 in_data,
	 result,
	 busy_o);
	 
parameter DATA_WIDTH = 23;

input clk;
input nRESET;
input [DATA_WIDTH-1:0] in_data;
output [$clog2(DATA_WIDTH)-1:0] result;
output busy_o;

reg [$clog2(DATA_WIDTH):0] result_o;
reg [$clog2(DATA_WIDTH)-1:0] counter;
reg [DATA_WIDTH-1:0] previous_data;
reg busy;

assign result = result_o;
assign busy_o = busy;

	always @(negedge nRESET or posedge clk)
		if (nRESET == 0) begin
			result_o <= 0;
			counter <= 0;
			busy <= 1'b0;
			previous_data <= 0;
			end
		else
			begin
			if(busy == 1)
				begin
					result_o <= in_data[DATA_WIDTH-1-counter]? DATA_WIDTH - counter - 1: result_o + in_data[counter];  
					counter <= counter + 1;
					previous_data <= previous_data;
				end
			else
				begin
					result_o <= result_o;
					counter <= 0;
					previous_data <= in_data;
				end
				
			if (previous_data != in_data) busy <= 1; 
			else
			if (busy && (in_data[DATA_WIDTH-1-counter] || (result_o + in_data[counter] == ($clog2(DATA_WIDTH)>>1) + 1))) 
					busy <= 0;
			else
					busy <= busy;
			
		end


endmodule 