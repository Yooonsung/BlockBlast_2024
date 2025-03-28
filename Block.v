
module Block(iCLK, reset, HCNT, VCNT, R ,G, B, random);

input iCLK, reset;
input [15:0] random;
input [11:0] HCNT;
input [10:0] VCNT;
output [7:0] R, G, B;

wire iCLK, reset;
wire [15:0] random;
wire [2:0] Shape;
wire [1:0] M_C;
reg [7:0] R, G, B;
reg color;
wire [11:0] HCNT;
wire [10:0] VCNT;
wire [11:0] hd_block; 
wire [10:0] vd_block; 
wire [11:0] block_addr;
wire [1:0] block_q;

parameter ths_block = 12'd0; 
parameter tvs_block = 11'd0;

assign hd_block = HCNT - ths_block;
assign vd_block = VCNT - tvs_block;

assign block_addr = {vd_block[5:0],hd_block[5:0]}; //image block

always @(posedge iCLK)
begin
	if(Shape == 3'd0)
	begin
		if ((VCNT >= 11'd0) && (VCNT < 11'd64) && (HCNT >= 12'd0) && (HCNT < 12'd256))
			color <= 1'b1;
		else
			color <= 1'b0;
	end
	else if (Shape == 3'd1)
	begin
		if ((VCNT >= 11'd0) && (VCNT < 11'd64) && (HCNT >= 12'd0) && (HCNT < 12'd192))
			color <= 1'b1;
		else if ((VCNT >= 11'd64) && (VCNT < 11'd128) && (HCNT >= 12'd64) && (HCNT < 12'd128)) 
			color <= 1'b1;
		else
			color <= 1'b0;
	end
	else if (Shape == 3'd2)
	begin
		if ((VCNT >= 11'd0) && (VCNT < 11'd128) && (HCNT >= 12'd0) && (HCNT < 12'd192))
			color <= 1'b1;
		else
			color <= 1'b0;
	end
	else if (Shape == 3'd3)
	begin
		if ((VCNT >= 11'd0) && (VCNT < 11'd64) && (HCNT >= 12'd0) && (HCNT < 12'd256))
			color <= 1'b1;
		else if ((VCNT >= 11'd64) && (VCNT < 11'd128) && (HCNT >= 12'd128) && (HCNT < 12'd192))
			color <= 1'b1;
		else
			color <= 1'b0;
	end
	else if (Shape == 3'd4)
	begin
		if ((VCNT >= 11'd0) && (VCNT < 11'd64) && (HCNT >= 12'd0) && (HCNT < 12'd128)) 
			color <= 1'b1;
		else
			color <= 1'b0;
	end
	else if (Shape == 3'd5)
	begin
		if ((VCNT >= 11'd0) && (VCNT < 11'd64) && (HCNT >= 12'd0) && (HCNT < 12'd64))
			color <= 1'b1;
		else
			color <= 1'b0;
	end
	else if (Shape == 3'd6)
	begin
		if ((VCNT >= 11'd0) && (VCNT < 11'd128) && (HCNT >= 12'd0) && (HCNT < 12'd128)) 
			color <= 1'b1;
		else
			color <= 1'b0;
	end
	else
	begin
		if ((VCNT >= 11'd0) && (VCNT < 11'd64) && (HCNT >= 12'd0) && (HCNT < 12'd64))
			color <= 1'b1;
		else if ((VCNT >= 11'd64) && (VCNT < 11'd128) && (HCNT >= 12'd0) && (HCNT < 12'd192))
			color <= 1'b1;
		else
			color <= 1'b0;
	end
end

always @(posedge iCLK)
begin
	if (color == 1'b0) 
		begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end // background
	else
	if(M_C == 2'd0) // blue 
		begin
			if (block_q == 2'b00)
				begin R <= 8'd153; G <= 8'd195; B <= 8'd38; end 
			else if (block_q == 2'b01)
				begin R <= 8'd87; G <= 8'd126; B <= 8'd242; end 
			else if (block_q == 2'b10)
				begin R <= 8'd72; G <= 8'd108; B <= 8'd217; end 
			else
				begin R <= 8'd46; G <= 8'd70; B <= 8'd140; end 
		end
	else if(M_C == 2'd1) // yellow
		begin
			if (block_q == 2'b00)
				begin R <= 8'd246; G <= 8'd227; B <= 8'd120; end 
			else if (block_q == 2'b01)
				begin R <= 8'd250; G <= 8'd201; B <= 8'd65; end 
			else if (block_q == 2'b10)
				begin R <= 8'd232; G <= 8'd179; B <= 8'd54; end 
			else
				begin R <= 8'd173; G <= 8'd112; B <= 8'd21; end 
		end
	else if(M_C == 2'd2) // orange
		begin
			if (block_q == 2'b00)
				begin R <= 8'd242; G <= 8'd181; B <= 8'd128; end 
			else if (block_q == 2'b01)
				begin R <= 8'd242; G <= 8'd118; B <= 8'd46; end 
			else if (block_q == 2'b10)
				begin R <= 8'd217; G <= 8'd99; B <= 8'd30; end 
			else
				begin R <= 8'd40; G <= 8'd54; B <= 8'd4; end 
		end
	else // red ...?
		begin
			if (block_q == 2'b00)
				begin R <= 8'd130; G <= 8'd0; B <= 8'd0; end 
			else if (block_q == 2'b01)
				begin R <= 8'd185; G <= 8'd0; B <= 8'd0; end 
			else if (block_q == 2'b10)
				begin R <= 8'd225; G <= 8'd0; B <= 8'd0; end 
			else
				begin R <= 8'd225; G <= 8'd0; B <= 8'd0; end 
				begin
		if (block_q == 2'b00)
			begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end // so dark
		else if (block_q == 2'b01)
			begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end // dark
		else if (block_q == 2'b10)
			begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end // bright
		else 
			begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end // bright
	end
		end
end



game_block t1 (.address(block_addr), .clock(iCLK), .q(block_q));
HVCNT H1 (.reset(reset), .iCLK(iCLK), .HCNT(HCNT), .VCNT(VCNT));

endmodule
