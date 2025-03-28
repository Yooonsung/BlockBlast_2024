

module BackGround(iCLK, reset, HCNT, VCNT, R ,G, B);

input iCLK, reset;
output [7:0] R, G, B;
output [11:0] HCNT;
output [10:0] VCNT;

reg [7:0] R, G, B;
reg selp0;
wire iCLK;
reg [11:0] HCNT;
reg [10:0] VCNT;
wire [11:0] hd_table;
wire [10:0] vd_table;
wire [17:0] table_addr;
wire [1:0] table_q;

parameter tvs_table = 11'd256;
parameter ths_table = 12'd512;

assign vd_table = VCNT - tvs_table;
assign hd_table = HCNT - ths_table;

assign table_addr = {vd_table[8:0],hd_table[8:0]}; //image block

always @(posedge iCLK)
begin
	if ((VCNT >= tvs_table) && (VCNT < (tvs_table + 11'd512)) && (HCNT >= ths_table) && (HCNT < (ths_table + 12'd512)))
		selp0 <= 1'b1;
	else
		selp0 <= 1'b0;
end

always@(posedge iCLK or negedge reset)
begin
if (reset ==1'b0)
	begin
			R <= 8'd0;
			G <= 8'd0;
			B <= 8'd0;
	end
else
begin
	if (selp0 == 1'b0)
		begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end // so dark background
	else 
	begin
		if (table_q == 2'b00)
			begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end // so dark
		else if (table_q == 2'b01)
			begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end // dark
		else if (table_q == 2'b10)
			begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end // bright
	end
end
end

game_table t1 (.address(table_addr), .clock(iCLK), .q(table_q));
	
endmodule
