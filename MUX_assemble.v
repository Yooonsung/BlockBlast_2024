
module MUX_assemble (iCLK, reset, HCNT, VCNT, R, G, B, back_R, back_G, back_B, block_R, block_G, block_B);

input iCLK, reset;
input [7:0] back_R, back_G, back_B, block_R, block_G, block_B;
input [11:0] HCNT;
input [10:0] VCNT;
output [7:0] R, G, B;


wire [7:0] back_R, back_G, back_B, block_R, block_G, block_B;
wire iCLK, reset;
wire [11:0] HCNT;
wire [10:0] VCNT;
wire [11:0] hd_table;
wire [10:0] vd_table;
wire [17:0] table_addr;
wire [1:0] table_q;
reg [7:0] R, G, B;
reg selp0;
wire [14:0] block_addr;

parameter tvs = 11'd500;
parameter ths = 12'd500;

assign vd = VCNT - tvs;
assign hd = HCNT - ths;

assign block_addr = {vd[6:0],hd[7:0]}; //image block

always @(posedge iCLK)
begin
	if ((VCNT >= tvs) && (VCNT < (tvs + 11'd128)) && (HCNT >= ths) && (HCNT < (ths + 12'd256)))
		selp0 <= 1'b1; 
	else
		selp0 <= 1'b0;
end

always @(posedge iCLK or negedge reset)
begin
	if (reset == 1'b0)
		selp0 <= 1'b0;
	else
	begin
		if (selp0 == 1'b0)
		begin R <= back_R; G <= back_G; B <= back_B; end
		else
		begin R <= block_R; G <= block_G; B <= block_B; end		
	end
end

BackGround u1 (.iCLK(iCLK), .reset(reset), .HCNT(HCNT), .VCNT(VCNT), .R(back_R) , .G(back_G), .B(back_B));

Block u2 (.iCLK(iCLK), .reset(reset), .HCNT(HCNT), .VCNT(VCNT), .R(block_R), .G(block_G), .B(block_B), .random(random));

endmodule
