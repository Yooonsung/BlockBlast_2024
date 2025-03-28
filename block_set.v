

module block_set(iCLK, reset, HCNT, VCNT, R ,G, B, ps2Clk, ps2Dat, led, M_S_1, M_S_2, M_S_3, mem1, mem2, mem3);

input iCLK, reset;
input [11:0] HCNT;
input [10:0] VCNT;
output [7:0] R, G, B;
output [2:0] M_S_1, M_S_2, M_S_3;

reg [7:0] R, G, B;
reg selp0;
wire iCLK;
wire [11:0] HCNT;
wire [10:0] VCNT;
wire [11:0] hd_table, hd_block1, hd_block2, hd_block3, hd_blockh;
wire [10:0] vd_table, vd_block1, vd_block2, vd_block3, vd_blockh;
reg [11:0] block_addr;
wire [1:0] block_q;
wire [2:0] random1, random2, random3; 

parameter tvs_table = 11'd256;
parameter ths_table = 12'd512;
parameter ths_block1 = 12'd1088; 
parameter tvs_block1 = 11'd256;
parameter ths_block2 = 12'd1088; 
parameter tvs_block2 = 11'd448;
parameter ths_block3 = 12'd1088; 
parameter tvs_block3 = 11'd640;
parameter ths_blockh = 12'd1408; 
parameter tvs_blockh = 11'd256;

assign vd_table = VCNT - ths_table;
assign hd_table = HCNT - ths_table;
assign vd_block1 = VCNT - tvs_block1;
assign hd_block1 = HCNT - ths_block1;
assign vd_block2 = VCNT - tvs_block2;
assign hd_block2 = HCNT - ths_block2;
assign vd_block3 = VCNT - tvs_block3;
assign hd_block3 = HCNT - ths_block3;
assign vd_blockh = VCNT - tvs_blockh;
assign hd_blockh = HCNT - ths_blockh;

reg [2:0] M_S_1, M_S_2, M_S_3; 

reg mem1, mem2, mem3;
output led, mem1, mem2, mem3;
input ps2Clk, ps2Dat;

wire NewKB, ps2Clk, ps2Dat; 
wire [7:0] KB_DAT;
reg led;
RxKB k1 (.PS_CLK(ps2Clk), .PS_DAT(ps2Dat), .CLK(iCLK), .RESET(reset), .NewKB(NewKB), .KB_DAT(KB_DAT));
always @(posedge iCLK)
begin
	if (NewKB == 1'b1)
   begin
			if (KB_DAT == 8'h2d)
			begin
				mem1 <= 1'b1;
				mem2 <= 1'b1;
				mem3 <= 1'b1;
			end
			else if (KB_DAT == 8'h16)
			begin
            mem1 <= 1'b1;
				led <= 1'b1;
				M_S_1 <= 3'd0;
			end
			else if (KB_DAT == 8'h1E)
			begin
            mem2 <= 1'b1;
				led <= 1'b1;
				M_S_2 <= 3'd0;
			end
			else if (KB_DAT == 8'h26)
			begin
				mem3 <= 1'b1;
				led <= 1'b1;
				M_S_3 <= 3'd0;
			end
			else
				led <= 1'b0;
    end
	 else 
	 begin
		 if ((mem1==1'b1)&&(mem2==1'b1)&&(mem3==1'b1))
			begin
			M_S_1 <= random1; 
			mem1 <= 1'b0;
			M_S_2 <= random2;
			mem2 <= 1'b0;
			M_S_3 <= random3;
			mem3 <= 1'b0;
		end
	end
end


always @(posedge iCLK) 
begin
   if ( HCNT >= 12'd1408 )
      block_addr <= {vd_blockh[5:0], hd_blockh[5:0]};
   else if ( HCNT >= 12'd1088 )
   begin
      if ( VCNT >= 11'd640 )
         block_addr <= {vd_block1[5:0], hd_block1[5:0]};
      else if ( VCNT >= 11'd448)
         block_addr <= {vd_block2[5:0], hd_block2[5:0]};
      else 
         block_addr <= {vd_block3[5:0], hd_block3[5:0]};
   end
   else
      block_addr <= {vd_table[5:0], hd_table[5:0]}; // default address
end

always @(posedge iCLK)
begin
   if ((VCNT >= tvs_table) && (VCNT < (tvs_table + 11'd512)) && (HCNT >= ths_table) && (HCNT < (ths_table + 12'd511)))
      selp0 <= 1'b1;
   else if ((VCNT >= tvs_block1) && (VCNT < (tvs_block1 + 11'd128)) && (HCNT >= ths_block1) && (HCNT < (ths_block1 + 12'd255)))
      selp0 <= 1'b1;
   else if ((VCNT >= tvs_block2) && (VCNT < (tvs_block2 + 11'd128)) && (HCNT >= ths_block2) && (HCNT < (ths_block2 + 12'd255)))
      selp0 <= 1'b1;
   else if ((VCNT >= tvs_block3) && (VCNT < (tvs_block3 + 11'd128)) && (HCNT >= ths_block3) && (HCNT < (ths_block3 + 12'd255)))
      selp0 <= 1'b1;
   else if ((VCNT >= tvs_blockh) && (VCNT < (tvs_blockh + 11'd128)) && (HCNT >= ths_blockh) && (HCNT < (ths_blockh + 12'd255)))
      selp0 <= 1'b0;
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
      begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
   else
   begin
      if ((VCNT >= tvs_block1) && (VCNT < (tvs_block1 + 11'd128)) && (HCNT >= ths_block1) && (HCNT < (ths_block1 + 12'd256)))
      begin
      case (M_S_1)
         3'd0:
            if ((VCNT >= (tvs_block1+11'd0)) && (VCNT < (tvs_block1+11'd64)) && (HCNT >= (ths_block1+12'd0)) && (HCNT < (ths_block1+12'd256)))
            begin
               if (block_q == 2'b00)
                  begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end   
               else if (block_q == 2'b01)
                  begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end  
               else if (block_q == 2'b10)
                  begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end  
               else
                  begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end   
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd1:
            if ((VCNT >= (tvs_block1+11'd0)) && (VCNT < (tvs_block1+11'd64)) && (HCNT >= (ths_block1+12'd0)) && (HCNT < (ths_block1+12'd192))||((VCNT >= (tvs_block1+11'd64)) && (VCNT < (tvs_block1+11'd128)) && (HCNT >= (ths_block1+12'd64)) && (HCNT < (ths_block1+12'd128))))
               begin
               if (block_q == 2'b00)
                  begin R <= 8'd72; G <= 8'd108; B <= 8'd217; end
               else if (block_q == 2'b01)
                  begin R <= 8'd153; G <= 8'd192; B <= 8'd242; end
               else if (block_q == 2'b10)
                  begin R <= 8'd87; G <= 8'd126; B <= 8'd242; end
               else
                  begin R <= 8'd46; G <= 8'd70; B <= 8'd140; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd2:
            if ((VCNT >= (tvs_block1+11'd0)) && (VCNT < (tvs_block1+11'd128)) && (HCNT >= (ths_block1+12'd0)) && (HCNT < (ths_block1+12'd192)))
               begin
               if (block_q == 2'b00)
                  begin R <= 8'd72; G <= 8'd108; B <= 8'd217; end   
               else if (block_q == 2'b01)
                  begin R <= 8'd153; G <= 8'd192; B <= 8'd242; end
               else if (block_q == 2'b10)
                  begin R <= 8'd87; G <= 8'd126; B <= 8'd242; end
               else
                  begin R <= 8'd46; G <= 8'd70; B <= 8'd140; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd3:
            if (((VCNT >= (tvs_block1+11'd0)) && (VCNT < (tvs_block1+11'd64)) && (HCNT >= (ths_block1+12'd0)) && (HCNT < (ths_block1+12'd192)))||((VCNT >= (tvs_block1+11'd64)) && (VCNT < (tvs_block1+11'd128)) && (HCNT >= (ths_block1+12'd128)) && (HCNT < (ths_block1+12'd192))))
               begin
               if (block_q == 2'b00)
                  begin R <= 8'd72; G <= 8'd108; B <= 8'd217; end   
               else if (block_q == 2'b01)
                  begin R <= 8'd153; G <= 8'd192; B <= 8'd242; end
               else if (block_q == 2'b10)
                  begin R <= 8'd87; G <= 8'd126; B <= 8'd242; end
               else
                  begin R <= 8'd46; G <= 8'd70; B <= 8'd140; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd4:
            if ((VCNT >= (tvs_block1+11'd0)) && (VCNT < (tvs_block1+11'd64)) && (HCNT >= (ths_block1+12'd0)) && (HCNT < (ths_block1+12'd128)))
               begin
               if (block_q == 2'b00)
                  begin R <= 8'd72; G <= 8'd108; B <= 8'd217; end   
               else if (block_q == 2'b01)
                  begin R <= 8'd153; G <= 8'd192; B <= 8'd242; end
               else if (block_q == 2'b10)
                  begin R <= 8'd87; G <= 8'd126; B <= 8'd242; end
               else
                  begin R <= 8'd46; G <= 8'd70; B <= 8'd140; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd5:
            if ((VCNT >= (tvs_block1+11'd0)) && (VCNT < (tvs_block1+11'd64)) && (HCNT >= (ths_block1+12'd0)) && (HCNT < (ths_block1+12'd64)))
               begin
               if (block_q == 2'b00)
                  begin R <= 8'd72; G <= 8'd108; B <= 8'd217; end   
               else if (block_q == 2'b01)
                  begin R <= 8'd153; G <= 8'd192; B <= 8'd242; end
               else if (block_q == 2'b10)
                  begin R <= 8'd87; G <= 8'd126; B <= 8'd242; end
               else
                  begin R <= 8'd46; G <= 8'd70; B <= 8'd140; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd6:
            if ((VCNT >= (tvs_block1+11'd0)) && (VCNT < (tvs_block1+11'd128)) && (HCNT >= (ths_block1+12'd0)) && (HCNT < (ths_block1+12'd128)))
               begin
               if (block_q == 2'b00)
                  begin R <= 8'd72; G <= 8'd108; B <= 8'd217; end   
               else if (block_q == 2'b01)
                  begin R <= 8'd153; G <= 8'd192; B <= 8'd242; end
               else if (block_q == 2'b10)
                  begin R <= 8'd87; G <= 8'd126; B <= 8'd242; end
               else
                  begin R <= 8'd46; G <= 8'd70; B <= 8'd140; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         default:
            if (((VCNT >= (tvs_block1+11'd0)) && (VCNT < (tvs_block1+11'd64)) && (HCNT >= (ths_block1+12'd0)) && (HCNT < (ths_block1+12'd64)))|| ((VCNT >= (tvs_block1+11'd64)) && (VCNT < (tvs_block1+11'd128)) && (HCNT >= (ths_block1+12'd0)) && (HCNT < (ths_block1+12'd192))))
               begin
               if (block_q == 2'b00)
                  begin R <= 8'd72; G <= 8'd108; B <= 8'd217; end   
               else if (block_q == 2'b01)
                  begin R <= 8'd153; G <= 8'd192; B <= 8'd242; end
               else if (block_q == 2'b10)
                  begin R <= 8'd87; G <= 8'd126; B <= 8'd242; end
               else
                  begin R <= 8'd46; G <= 8'd70; B <= 8'd140; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
      endcase
      end
      else if ((VCNT >= tvs_block2) && (VCNT < (tvs_block2 + 11'd128)) && (HCNT >= ths_block2) && (HCNT < (ths_block2 + 12'd256)))
      begin
      case (M_S_2)
         3'd1:
            if ((VCNT >= (tvs_block2+11'd0)) && (VCNT < (tvs_block2+11'd64)) && (HCNT >= (ths_block2+12'd0)) && (HCNT < (ths_block2+12'd256)))
               begin
                  if (block_q == 2'b00) 
                     begin R <= 8'd232; G <= 8'd179; B <= 8'd54; end // 양옆 
                  else if (block_q == 2'b01)
                     begin R <= 8'd246; G <= 8'd227; B <= 8'd120; end // 가장 위 
                  else if (block_q == 2'b10)
                     begin R <= 8'd250; G <= 8'd201; B <= 8'd65; end // 정 중앙 
                  else
                     begin R <= 8'd173; G <= 8'd112; B <= 8'd21; end // 가장 아래 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd2:
            if (((VCNT >= (tvs_block2+11'd0)) && (VCNT < (tvs_block2+11'd64)) && (HCNT >= (ths_block2+12'd0)) && (HCNT < (ths_block2+12'd192)))||((VCNT >= (tvs_block2+11'd64)) && (VCNT < (tvs_block2+11'd128)) && (HCNT >= (ths_block2+12'd64)) && (HCNT < (ths_block2+12'd128))))
               begin
                  if (block_q == 2'b00) 
                     begin R <= 8'd232; G <= 8'd179; B <= 8'd54; end // 양옆 
                  else if (block_q == 2'b01)
                     begin R <= 8'd246; G <= 8'd227; B <= 8'd120; end // 가장 위 
                  else if (block_q == 2'b10)
                     begin R <= 8'd250; G <= 8'd201; B <= 8'd65; end // 정 중앙 
                  else
                     begin R <= 8'd173; G <= 8'd112; B <= 8'd21; end // 가장 아래 
               end 
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd3:
            if ((VCNT >= (tvs_block2+11'd0)) && (VCNT < (tvs_block2+11'd128)) && (HCNT >= (ths_block2+12'd0)) && (HCNT < (ths_block2+12'd192)))
               begin
                  if (block_q == 2'b00) 
                     begin R <= 8'd232; G <= 8'd179; B <= 8'd54; end // 양옆 
                  else if (block_q == 2'b01)
                     begin R <= 8'd246; G <= 8'd227; B <= 8'd120; end // 가장 위 
                  else if (block_q == 2'b10)
                     begin R <= 8'd250; G <= 8'd201; B <= 8'd65; end // 정 중앙 
                  else
                     begin R <= 8'd173; G <= 8'd112; B <= 8'd21; end // 가장 아래 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd4:
            if (((VCNT >= (tvs_block2+11'd0)) && (VCNT < (tvs_block2+11'd64)) && (HCNT >= (ths_block2+12'd0)) && (HCNT < (ths_block2+12'd192)))||((VCNT >= (tvs_block2+11'd64)) && (VCNT < (tvs_block2+11'd128)) && (HCNT >= (ths_block2+12'd128)) && (HCNT < (ths_block2+12'd192))))
               begin
                  if (block_q == 2'b00) 
                     begin R <= 8'd232; G <= 8'd179; B <= 8'd54; end // 양옆 
                  else if (block_q == 2'b01)
                     begin R <= 8'd246; G <= 8'd227; B <= 8'd120; end // 가장 위 
                  else if (block_q == 2'b10)
                     begin R <= 8'd250; G <= 8'd201; B <= 8'd65; end // 정 중앙 
                  else
                     begin R <= 8'd173; G <= 8'd112; B <= 8'd21; end // 가장 아래 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd5:
            if ((VCNT >= (tvs_block2+11'd0)) && (VCNT < (tvs_block2+11'd64)) && (HCNT >= (ths_block2+12'd0)) && (HCNT < (ths_block2+12'd128)))
               begin
                  if (block_q == 2'b00) 
                     begin R <= 8'd232; G <= 8'd179; B <= 8'd54; end // 양옆 
                  else if (block_q == 2'b01)
                     begin R <= 8'd246; G <= 8'd227; B <= 8'd120; end // 가장 위 
                  else if (block_q == 2'b10)
                     begin R <= 8'd250; G <= 8'd201; B <= 8'd65; end // 정 중앙 
                  else
                     begin R <= 8'd173; G <= 8'd112; B <= 8'd21; end // 가장 아래 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd6:
            if ((VCNT >= (tvs_block2+11'd0)) && (VCNT < (tvs_block2+11'd64)) && (HCNT >= (ths_block2+12'd0)) && (HCNT < (ths_block2+12'd64)))
               begin
                  if (block_q == 2'b00) 
                     begin R <= 8'd232; G <= 8'd179; B <= 8'd54; end // 양옆 
                  else if (block_q == 2'b01)
                     begin R <= 8'd246; G <= 8'd227; B <= 8'd120; end // 가장 위 
                  else if (block_q == 2'b10)
                     begin R <= 8'd250; G <= 8'd201; B <= 8'd65; end // 정 중앙 
                  else
                     begin R <= 8'd173; G <= 8'd112; B <= 8'd21; end // 가장 아래 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd7:
            if ((VCNT >= (tvs_block2+11'd0)) && (VCNT < (tvs_block2+11'd128)) && (HCNT >= (ths_block2+12'd0)) && (HCNT < (ths_block2+12'd128)))
               begin
                  if (block_q == 2'b00) 
                     begin R <= 8'd232; G <= 8'd179; B <= 8'd54; end // 양옆 
                  else if (block_q == 2'b01)
                     begin R <= 8'd246; G <= 8'd227; B <= 8'd120; end // 가장 위 
                  else if (block_q == 2'b10)
                     begin R <= 8'd250; G <= 8'd201; B <= 8'd65; end // 정 중앙 
                  else
                     begin R <= 8'd173; G <= 8'd112; B <= 8'd21; end // 가장 아래 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         default:
            if (((VCNT >= (tvs_block2+11'd0)) && (VCNT < (tvs_block2+11'd64)) && (HCNT >= (ths_block2+12'd0)) && (HCNT < (ths_block2+12'd64)))||((VCNT >= (tvs_block2+11'd64)) && (VCNT < (tvs_block2+11'd128)) && (HCNT >= (ths_block2+12'd0)) && (HCNT < (ths_block2+12'd192))))
               begin
						if (block_q == 2'b00)
							begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end   
						else if (block_q == 2'b01)
							begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end  
						else if (block_q == 2'b10)
							begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end  
						else
							begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end   
					end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
      endcase
      end
      else if ((VCNT >= tvs_block3) && (VCNT < (tvs_block3 + 11'd128)) && (HCNT >= ths_block3) && (HCNT < (ths_block3 + 12'd256)))
      begin
      case (M_S_3)
         3'd0:
            if ((VCNT >= (tvs_block3+11'd0)) && (VCNT < (tvs_block3+11'd64)) && (HCNT >= (ths_block3+12'd0)) && (HCNT < (ths_block3+12'd256)))
               begin
               if (block_q == 2'b00)
                  begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end   
               else if (block_q == 2'b01)
                  begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end  
               else if (block_q == 2'b10)
                  begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end  
               else
                  begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end   
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd1:
            if (((VCNT >= (tvs_block3+11'd0)) && (VCNT < (tvs_block3+11'd64)) && (HCNT >= (ths_block3+12'd0)) && (HCNT < (ths_block3+12'd192)))||((VCNT >= (tvs_block3+11'd64)) && (VCNT < (tvs_block3+11'd128)) && (HCNT >= (ths_block3+12'd64)) && (HCNT < (ths_block3+12'd128))))
               begin
                  if (block_q == 2'b00)
                     begin R <= 8'd217; G <= 8'd99; B <= 8'd30; end 
                  else if (block_q == 2'b01)
                     begin R <= 8'd242; G <= 8'd181; B <= 8'd128; end 
                  else if (block_q == 2'b10)
                      begin R <= 8'd242; G <= 8'd118; B <= 8'd46; end
                  else
                     begin R <= 8'd40; G <= 8'd54; B <= 8'd4; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd2:
            if ((VCNT >= (tvs_block3+11'd0)) && (VCNT < (tvs_block3+11'd128)) && (HCNT >= (ths_block3+12'd0)) && (HCNT < (ths_block3+12'd192)))
               begin
                  if (block_q == 2'b00)
                     begin R <= 8'd217; G <= 8'd99; B <= 8'd30; end 
                  else if (block_q == 2'b01)
                     begin R <= 8'd242; G <= 8'd181; B <= 8'd128; end 
                  else if (block_q == 2'b10)
                      begin R <= 8'd242; G <= 8'd118; B <= 8'd46; end
                  else
                     begin R <= 8'd40; G <= 8'd54; B <= 8'd4; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd3:
            if (((VCNT >= (tvs_block3+11'd0)) && (VCNT < (tvs_block3+11'd64)) && (HCNT >= (ths_block3+12'd0)) && (HCNT < (ths_block3+12'd192)))||((VCNT >= (tvs_block3+11'd64)) && (VCNT < (tvs_block3+11'd128)) && (HCNT >= (ths_block3+12'd128)) && (HCNT < (ths_block3+12'd192))))
               begin
                  if (block_q == 2'b00)
                     begin R <= 8'd217; G <= 8'd99; B <= 8'd30; end 
                  else if (block_q == 2'b01)
                     begin R <= 8'd242; G <= 8'd181; B <= 8'd128; end 
                  else if (block_q == 2'b10)
                      begin R <= 8'd242; G <= 8'd118; B <= 8'd46; end
                  else
                     begin R <= 8'd40; G <= 8'd54; B <= 8'd4; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd4:
            if ((VCNT >= (tvs_block3+11'd0)) && (VCNT < (tvs_block3+11'd64)) && (HCNT >= (ths_block3+12'd0)) && (HCNT < (ths_block3+12'd128)))
               begin
                  if (block_q == 2'b00)
                     begin R <= 8'd217; G <= 8'd99; B <= 8'd30; end 
                  else if (block_q == 2'b01)
                     begin R <= 8'd242; G <= 8'd181; B <= 8'd128; end 
                  else if (block_q == 2'b10)
                      begin R <= 8'd242; G <= 8'd118; B <= 8'd46; end
                  else
                     begin R <= 8'd40; G <= 8'd54; B <= 8'd4; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd5:
            if ((VCNT >= (tvs_block3+11'd0)) && (VCNT < (tvs_block3+11'd64)) && (HCNT >= (ths_block3+12'd0)) && (HCNT < (ths_block3+12'd64)))
               begin
                  if (block_q == 2'b00)
                     begin R <= 8'd217; G <= 8'd99; B <= 8'd30; end 
                  else if (block_q == 2'b01)
                     begin R <= 8'd242; G <= 8'd181; B <= 8'd128; end 
                  else if (block_q == 2'b10)
                      begin R <= 8'd242; G <= 8'd118; B <= 8'd46; end
                  else
                     begin R <= 8'd40; G <= 8'd54; B <= 8'd4; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         3'd6:
            if ((VCNT >= (tvs_block3+11'd0)) && (VCNT < (tvs_block3+11'd128)) && (HCNT >= (ths_block3+12'd0)) && (HCNT < (ths_block3+12'd128)))
               begin
                  if (block_q == 2'b00)
                     begin R <= 8'd217; G <= 8'd99; B <= 8'd30; end 
                  else if (block_q == 2'b01)
                     begin R <= 8'd242; G <= 8'd181; B <= 8'd128; end 
                  else if (block_q == 2'b10)
                      begin R <= 8'd242; G <= 8'd118; B <= 8'd46; end
                  else
                     begin R <= 8'd40; G <= 8'd54; B <= 8'd4; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
         default:
            if (((VCNT >= (tvs_block3+11'd0)) && (VCNT < (tvs_block3+11'd64)) && (HCNT >= (ths_block3+12'd0)) && (HCNT < (ths_block3+12'd64)))||((VCNT >= (tvs_block3+11'd64)) && (VCNT < (tvs_block3+11'd128)) && (HCNT >= (ths_block3+12'd0)) && (HCNT < (ths_block3+12'd192))))
               begin
                  if (block_q == 2'b00)
                     begin R <= 8'd217; G <= 8'd99; B <= 8'd30; end 
                  else if (block_q == 2'b01)
                     begin R <= 8'd242; G <= 8'd181; B <= 8'd128; end 
                  else if (block_q == 2'b10)
                      begin R <= 8'd242; G <= 8'd118; B <= 8'd46; end
                  else
                     begin R <= 8'd40; G <= 8'd54; B <= 8'd4; end 
               end
            else
               begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
      endcase
      end
      else
      begin
         if (block_q == 2'b00)
            begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end // so dark
         else if (block_q == 2'b01)
            begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
         else if (block_q == 2'b10)
            begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end // bright
         else 
            begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end // bright
      end
   end
end
end

block_single b1 (.address(block_addr), .clock(iCLK), .q(block_q));

wire iCLK1, iCLK2, iCLK3;
reg [2:0] CLK_cnt;

always @(posedge iCLK)
begin
	CLK_cnt <= CLK_cnt +3'd1;
end

assign iCLK1 = CLK_cnt[0];
assign iCLK2 = CLK_cnt[1];
assign iCLK3 = CLK_cnt[2];

Random r1 (.reset(reset), .iCLK(iCLK1), .random(random1));

Random r2 (.reset(reset), .iCLK(iCLK2), .random(random2));

Random r3 (.reset(reset), .iCLK(iCLK3), .random(random3));

endmodule
