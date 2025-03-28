
module Random (reset, iCLK, random);

input iCLK, reset;
output [2:0] random;

reg[2:0]random;
wire feedback;

assign feedback = random[2]^random[1];

always @(posedge iCLK or negedge reset)
begin
	if (reset == 1'b0)
		random <= 3'hffff;
	else
		random <= {random[1:0],feedback};
end

endmodule
