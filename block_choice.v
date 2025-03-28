
module block_choice (iCLK, reset, HCNT, VCNT, R ,G, B, ps2Clk, ps2Dat, led, x, y, cntM1, cntS1);

input iCLK, reset;
input [11:0] HCNT;
input [10:0] VCNT;
input [3:0] cntM1, cntS1;
output [7:0] R, G, B;

reg [7:0] R, G, B;
reg selp0;
wire iCLK, reset;
wire [11:0] HCNT;
wire [10:0] VCNT;
wire [11:0] hd_table;
wire [10:0] vd_table;
wire [11:0] block_addr;
wire [1:0] block_q;

reg [2:0] mem [0:63];
reg [5:0] i;

parameter tvs_table = 11'd256;
parameter ths_table = 12'd512;

assign block_addr = {vd_table[5:0], hd_table[5:0]};

always @(posedge iCLK)
begin
   if ((VCNT >= tvs_table) && (VCNT < (tvs_table + 11'd512)) && (HCNT >= ths_table) && (HCNT < (ths_table + 12'd511)))
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
      begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
   else
   begin
			if ((mem[i] != 3'd0) && (VCNT >= (tvs_table + (i[5:3] * 11'd64))) && (VCNT < (tvs_table + (i[5:3] + 1) * 11'd64)) && (HCNT >= (ths_table + (i[2:0] * 12'd64))) && (HCNT < (ths_table + (i[2:0] + 1) * 12'd64)))
			begin
				if (mem[i] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem[i] == 3'd1) // blue
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
				else if (mem[i] == 3'd2) // yellow
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
				else if (mem[i] == 3'd3) // orange
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
				else if (mem[i] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
			else if ((mem[i+6'd1] != 3'd0) && (VCNT >= (tvs_table + (i[5:3] * 11'd64))) && (VCNT < (tvs_table + (i[5:3] + 1) * 11'd64)) && (HCNT >= (ths_table + (i[2:0] + 1) * 12'd64)) && (HCNT < (ths_table + (i[2:0] + 2) * 12'd64)))
			begin
				if (mem[i+6'd1] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem[i+6'd1] == 3'd1) // blue
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
				else if (mem[i+6'd1] == 3'd2) // yellow
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
				else if (mem[i+6'd1] == 3'd3) // orange
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
				else if (mem[i+6'd1] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
			else if ((mem[i+6'd2] != 3'd0) &&(VCNT >= (tvs_table + (i[5:3] * 11'd64))) && (VCNT < (tvs_table + (i[5:3] + 1) * 11'd64)) && (HCNT >= (ths_table + (i[2:0] + 2) * 12'd64)) && (HCNT < (ths_table + (i[2:0] + 3) * 12'd64)))
			begin
				if (mem[i+6'd2] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem[i+6'd2] == 3'd1) // blue
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
				else if (mem[i+6'd2] == 3'd2) // yellow
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
				else if (mem[i+6'd2] == 3'd3) // orange
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
				else if (mem[i+6'd2] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
			else if ((mem[i+6'd3] != 3'd0) &&(VCNT >= (tvs_table + (i[5:3] * 11'd64))) && (VCNT < (tvs_table + (i[5:3] + 1) * 11'd64)) && (HCNT >= (ths_table + (i[2:0] + 3) * 12'd64)) && (HCNT < (ths_table + (i[2:0] + 4) * 12'd64)))
			begin
				if (mem[i+6'd3] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem[i+6'd3] == 3'd1) // blue
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
				else if (mem[i+6'd3] == 3'd2) // yellow
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
				else if (mem[i+6'd3] == 3'd3) // orange
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
				else if (mem[i+6'd3] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
			else if ((mem[i+6'd8] != 3'd0) &&(VCNT >= (tvs_table + (i[5:3] + 1) * 11'd64)) && (VCNT < (tvs_table + (i[5:3] + 2) * 11'd64)) && (HCNT >= (ths_table + (i[2:0] * 12'd64)) && (HCNT < (ths_table + (i[2:0] + 1) * 12'd64))))
			begin
				if (mem[i+6'd8] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem[i+6'd8] == 3'd1) // blue
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
				else if (mem[i+6'd8] == 3'd2) // yellow
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
				else if (mem[i+6'd8] == 3'd3) // orange
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
				else if (mem[i+6'd8] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
			else if ((mem[i+6'd9] != 3'd0) &&(VCNT >= (tvs_table + (i[5:3] + 1) * 11'd64)) && (VCNT < (tvs_table + (i[5:3] + 2) * 11'd64)) && (HCNT >= (ths_table + (i[2:0] + 1) * 12'd64)) && (HCNT < (ths_table + (i[2:0] + 2) * 12'd64)))
			begin
				if (mem[i+6'd9] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem[i+6'd9] == 3'd1) // blue
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
				else if (mem[i+6'd9] == 3'd2) // yellow
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
				else if (mem[i+6'd9] == 3'd3) // orange
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
				else if (mem[i+6'd9] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
			else if ((mem[i+6'd10] != 3'd0) &&(VCNT >= (tvs_table + (i[5:3] + 1) * 11'd64)) && (VCNT < (tvs_table + (i[5:3] + 2) * 11'd64)) && (HCNT >= (ths_table + (i[2:0] + 2) * 12'd64)) && (HCNT < (ths_table + (i[2:0] + 3) * 12'd64)))
			begin
				if (mem[i+6'd10] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem[i+6'd10] == 3'd1) // blue
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
				else if (mem[i+6'd10] == 3'd2) // yellow
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
				else if (mem[i+6'd10] == 3'd3) // orange
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
				else if (mem[i+6'd10] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
			else if ((mem[i+6'd11] != 3'd0) &&(VCNT >= (tvs_table + (i[5:3] + 1) * 11'd64)) && (VCNT < (tvs_table + (i[5:3] + 2) * 11'd64)) && (HCNT >= (ths_table + (i[2:0] + 3) * 12'd64)) && (HCNT < (ths_table + (i[2:0] + 4) * 12'd64)))
			begin
				if (mem[i+6'd11] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem[i+6'd11] == 3'd1) // blue
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
				else if (mem[i+6'd11] == 3'd2) // yellow
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
				else if (mem[i+6'd11] == 3'd3) // orange
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
				else if (mem[i+6'd11] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
			else if ((VCNT >= (tvs_table + (0 * 11'd64))) && (VCNT < (tvs_table + (0 + 1) * 11'd64)) && (HCNT >= (ths_table + (0 * 12'd64))) && (HCNT < (ths_table + (0 + 1) * 12'd64)))
			begin
				if (mem_table[0] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end  
				end
				else if (mem_table[0] == 3'd1) // blue
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
				else if (mem_table[0] == 3'd2) // yellow
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
				else if (mem_table[0] == 3'd3) // orange
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
				else if (mem_table[0] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
			else if ((VCNT >= (tvs_table + (0 * 11'd64))) && (VCNT < (tvs_table + (0 + 1) * 11'd64)) && (HCNT >= (ths_table + (1 * 12'd64))) && (HCNT < (ths_table + (1 + 1) * 12'd64)))
			begin
				if (mem_table[1] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[1] == 3'd1) // blue
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
				else if (mem_table[1] == 3'd2) // yellow
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
				else if (mem_table[1] == 3'd3) // orange
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
				else if (mem_table[1] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
			else if ((VCNT >= (tvs_table + (0 * 11'd64))) && (VCNT < (tvs_table + (0 + 1) * 11'd64)) && (HCNT >= (ths_table + (2 * 12'd64))) && (HCNT < (ths_table + (2 + 1) * 12'd64)))
			begin
				if (mem_table[2] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[2] == 3'd1) // blue
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
				else if (mem_table[2] == 3'd2) // yellow
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
				else if (mem_table[2] == 3'd3) // orange
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
				else if (mem_table[2] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
			else if ((VCNT >= (tvs_table + (0 * 11'd64))) && (VCNT < (tvs_table + (0 + 1) * 11'd64)) && (HCNT >= (ths_table + (3 * 12'd64))) && (HCNT < (ths_table + (3 + 1) * 12'd64)))
			begin
				if (mem_table[3] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[3] == 3'd1) // blue
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
				else if (mem_table[3] == 3'd2) // yellow
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
				else if (mem_table[3] == 3'd3) // orange
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
				else if (mem_table[3] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
			else if ((VCNT >= (tvs_table + (0 * 11'd64))) && (VCNT < (tvs_table + (0 + 1) * 11'd64)) && (HCNT >= (ths_table + (4 * 12'd64))) && (HCNT < (ths_table + (4 + 1) * 12'd64)))
			begin
				if (mem_table[4] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[4] == 3'd1) // blue
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
				else if (mem_table[4] == 3'd2) // yellow
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
				else if (mem_table[4] == 3'd3) // orange
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
				else if (mem_table[4] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (0 * 11'd64))) && (VCNT < (tvs_table + (0 + 1) * 11'd64)) && (HCNT >= (ths_table + (5 * 12'd64))) && (HCNT < (ths_table + (5 + 1) * 12'd64)))
			begin
				if (mem_table[5] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[5] == 3'd1) // blue
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
				else if (mem_table[5] == 3'd2) // yellow
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
				else if (mem_table[5] == 3'd3) // orange
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
				else if (mem_table[5] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (0 * 11'd64))) && (VCNT < (tvs_table + (0 + 1) * 11'd64)) && (HCNT >= (ths_table + (6 * 12'd64))) && (HCNT < (ths_table + (6 + 1) * 12'd64)))
			begin
				if (mem_table[6] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[6] == 3'd1) // blue
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
				else if (mem_table[6] == 3'd2) // yellow
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
				else if (mem_table[6] == 3'd3) // orange
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
				else if (mem_table[6] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (0 * 11'd64))) && (VCNT < (tvs_table + (0 + 1) * 11'd64)) && (HCNT >= (ths_table + (7 * 12'd64))) && (HCNT < (ths_table + (7 + 1) * 12'd64)))
			begin
				if (mem_table[7] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[7] == 3'd1) // blue
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
				else if (mem_table[7] == 3'd2) // yellow
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
				else if (mem_table[7] == 3'd3) // orange
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
				else if (mem_table[7] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (1 * 11'd64))) && (VCNT < (tvs_table + (1 + 1) * 11'd64)) && (HCNT >= (ths_table + (0 * 12'd64))) && (HCNT < (ths_table + (0 + 1) * 12'd64)))
			begin
				if (mem_table[8] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[8] == 3'd1) // blue
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
				else if (mem_table[8] == 3'd2) // yellow
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
				else if (mem_table[8] == 3'd3) // orange
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
				else if (mem_table[8] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (1 * 11'd64))) && (VCNT < (tvs_table + (1 + 1) * 11'd64)) && (HCNT >= (ths_table + (1 * 12'd64))) && (HCNT < (ths_table + (1 + 1) * 12'd64)))
			begin
				if (mem_table[9] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[9] == 3'd1) // blue
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
				else if (mem_table[9] == 3'd2) // yellow
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
				else if (mem_table[9] == 3'd3) // orange
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
				else if (mem_table[9] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (1 * 11'd64))) && (VCNT < (tvs_table + (1 + 1) * 11'd64)) && (HCNT >= (ths_table + (2 * 12'd64))) && (HCNT < (ths_table + (2 + 1) * 12'd64)))
			begin
				if (mem_table[10] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[10] == 3'd1) // blue
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
				else if (mem_table[10] == 3'd2) // yellow
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
				else if (mem_table[10] == 3'd3) // orange
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
				else if (mem_table[10] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (1 * 11'd64))) && (VCNT < (tvs_table + (1 + 1) * 11'd64)) && (HCNT >= (ths_table + (3 * 12'd64))) && (HCNT < (ths_table + (3 + 1) * 12'd64)))
			begin
				if (mem_table[11] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[11] == 3'd1) // blue
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
				else if (mem_table[11] == 3'd2) // yellow
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
				else if (mem_table[9] == 3'd3) // orange
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
				else if (mem_table[11] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (1 * 11'd64))) && (VCNT < (tvs_table + (1 + 1) * 11'd64)) && (HCNT >= (ths_table + (4 * 12'd64))) && (HCNT < (ths_table + (4 + 1) * 12'd64)))
			begin
				if (mem_table[12] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[12] == 3'd1) // blue
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
				else if (mem_table[12] == 3'd2) // yellow
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
				else if (mem_table[10] == 3'd3) // orange
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
				else if (mem_table[12] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (1 * 11'd64))) && (VCNT < (tvs_table + (1 + 1) * 11'd64)) && (HCNT >= (ths_table + (5 * 12'd64))) && (HCNT < (ths_table + (5 + 1) * 12'd64)))
			begin
				if (mem_table[13] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[13] == 3'd1) // blue
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
				else if (mem_table[13] == 3'd2) // yellow
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
				else if (mem_table[13] == 3'd3) // orange
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
				else if (mem_table[13] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (1 * 11'd64))) && (VCNT < (tvs_table + (1 + 1) * 11'd64)) && (HCNT >= (ths_table + (6 * 12'd64))) && (HCNT < (ths_table + (6 + 1) * 12'd64)))
			begin
				if (mem_table[14] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[14] == 3'd1) // blue
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
				else if (mem_table[14] == 3'd2) // yellow
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
				else if (mem_table[14] == 3'd3) // orange
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
				else if (mem_table[14] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (1 * 11'd64))) && (VCNT < (tvs_table + (1 + 1) * 11'd64)) && (HCNT >= (ths_table + (7 * 12'd64))) && (HCNT < (ths_table + (7 + 1) * 12'd64)))
			begin
				if (mem_table[15] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[15] == 3'd1) // blue
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
				else if (mem_table[15] == 3'd2) // yellow
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
				else if (mem_table[15] == 3'd3) // orange
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
				else if (mem_table[15] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (2 * 11'd64))) && (VCNT < (tvs_table + (2 + 1) * 11'd64)) && (HCNT >= (ths_table + (0 * 12'd64))) && (HCNT < (ths_table + (0 + 1) * 12'd64)))
			begin
				if (mem_table[16] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[16] == 3'd1) // blue
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
				else if (mem_table[16] == 3'd2) // yellow
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
				else if (mem_table[16] == 3'd3) // orange
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
				else if (mem_table[16] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (2 * 11'd64))) && (VCNT < (tvs_table + (2 + 1) * 11'd64)) && (HCNT >= (ths_table + (1 * 12'd64))) && (HCNT < (ths_table + (1 + 1) * 12'd64)))
			begin
				if (mem_table[17] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[17] == 3'd1) // blue
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
				else if (mem_table[17] == 3'd2) // yellow
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
				else if (mem_table[17] == 3'd3) // orange
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
				else if (mem_table[15] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (2 * 11'd64))) && (VCNT < (tvs_table + (2 + 1) * 11'd64)) && (HCNT >= (ths_table + (2 * 12'd64))) && (HCNT < (ths_table + (2 + 1) * 12'd64)))
			begin
				if (mem_table[18] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[18] == 3'd1) // blue
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
				else if (mem_table[18] == 3'd2) // yellow
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
				else if (mem_table[18] == 3'd3) // orange
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
				else if (mem_table[18] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (2 * 11'd64))) && (VCNT < (tvs_table + (2 + 1) * 11'd64)) && (HCNT >= (ths_table + (3 * 12'd64))) && (HCNT < (ths_table + (3 + 1) * 12'd64)))
			begin
				if (mem_table[19] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[19] == 3'd1) // blue
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
				else if (mem_table[19] == 3'd2) // yellow
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
				else if (mem_table[19] == 3'd3) // orange
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
				else if (mem_table[19] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (2 * 11'd64))) && (VCNT < (tvs_table + (2 + 1) * 11'd64)) && (HCNT >= (ths_table + (4 * 12'd64))) && (HCNT < (ths_table + (4 + 1) * 12'd64)))
			begin
				if (mem_table[20] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[20] == 3'd1) // blue
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
				else if (mem_table[20] == 3'd2) // yellow
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
				else if (mem_table[20] == 3'd3) // orange
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
				else if (mem_table[20] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (2 * 11'd64))) && (VCNT < (tvs_table + (2 + 1) * 11'd64)) && (HCNT >= (ths_table + (5 * 12'd64))) && (HCNT < (ths_table + (5 + 1) * 12'd64)))
			begin
				if (mem_table[21] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[21] == 3'd1) // blue
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
				else if (mem_table[21] == 3'd2) // yellow
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
				else if (mem_table[21] == 3'd3) // orange
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
				else if (mem_table[21] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (2 * 11'd64))) && (VCNT < (tvs_table + (2 + 1) * 11'd64)) && (HCNT >= (ths_table + (6 * 12'd64))) && (HCNT < (ths_table + (6 + 1) * 12'd64)))
			begin
				if (mem_table[22] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[22] == 3'd1) // blue
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
				else if (mem_table[22] == 3'd2) // yellow
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
				else if (mem_table[22] == 3'd3) // orange
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
				else if (mem_table[22] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (2 * 11'd64))) && (VCNT < (tvs_table + (2 + 1) * 11'd64)) && (HCNT >= (ths_table + (7 * 12'd64))) && (HCNT < (ths_table + (7 + 1) * 12'd64)))
			begin
				if (mem_table[23] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[23] == 3'd1) // blue
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
				else if (mem_table[23] == 3'd2) // yellow
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
				else if (mem_table[23] == 3'd3) // orange
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
				else if (mem_table[23] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (3 * 11'd64))) && (VCNT < (tvs_table + (3 + 1) * 11'd64)) && (HCNT >= (ths_table + (0 * 12'd64))) && (HCNT < (ths_table + (0 + 1) * 12'd64)))
			begin
				if (mem_table[24] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[24] == 3'd1) // blue
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
				else if (mem_table[24] == 3'd2) // yellow
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
				else if (mem_table[24] == 3'd3) // orange
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
				else if (mem_table[24] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (3 * 11'd64))) && (VCNT < (tvs_table + (3 + 1) * 11'd64)) && (HCNT >= (ths_table + (1 * 12'd64))) && (HCNT < (ths_table + (1 + 1) * 12'd64)))
			begin
				if (mem_table[25] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[25] == 3'd1) // blue
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
				else if (mem_table[25] == 3'd2) // yellow
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
				else if (mem_table[25] == 3'd3) // orange
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
				else if (mem_table[25] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (3 * 11'd64))) && (VCNT < (tvs_table + (3 + 1) * 11'd64)) && (HCNT >= (ths_table + (2 * 12'd64))) && (HCNT < (ths_table + (2 + 1) * 12'd64)))
			begin
				if (mem_table[26] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[26] == 3'd1) // blue
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
				else if (mem_table[26] == 3'd2) // yellow
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
				else if (mem_table[26] == 3'd3) // orange
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
				else if (mem_table[26] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (3 * 11'd64))) && (VCNT < (tvs_table + (3 + 1) * 11'd64)) && (HCNT >= (ths_table + (3 * 12'd64))) && (HCNT < (ths_table + (3 + 1) * 12'd64)))
			begin
				if (mem_table[27] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[27] == 3'd1) // blue
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
				else if (mem_table[27] == 3'd2) // yellow
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
				else if (mem_table[27] == 3'd3) // orange
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
				else if (mem_table[27] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (3 * 11'd64))) && (VCNT < (tvs_table + (3 + 1) * 11'd64)) && (HCNT >= (ths_table + (4 * 12'd64))) && (HCNT < (ths_table + (4 + 1) * 12'd64)))
			begin
				if (mem_table[28] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[28] == 3'd1) // blue
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
				else if (mem_table[28] == 3'd2) // yellow
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
				else if (mem_table[28] == 3'd3) // orange
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
				else if (mem_table[28] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (3 * 11'd64))) && (VCNT < (tvs_table + (3 + 1) * 11'd64)) && (HCNT >= (ths_table + (5 * 12'd64))) && (HCNT < (ths_table + (5 + 1) * 12'd64)))
			begin
				if (mem_table[29] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[29] == 3'd1) // blue
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
				else if (mem_table[29] == 3'd2) // yellow
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
				else if (mem_table[29] == 3'd3) // orange
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
				else if (mem_table[29] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (3 * 11'd64))) && (VCNT < (tvs_table + (3 + 1) * 11'd64)) && (HCNT >= (ths_table + (6 * 12'd64))) && (HCNT < (ths_table + (6 + 1) * 12'd64)))
			begin
				if (mem_table[30] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[30] == 3'd1) // blue
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
				else if (mem_table[30] == 3'd2) // yellow
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
				else if (mem_table[30] == 3'd3) // orange
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
				else if (mem_table[30] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (3 * 11'd64))) && (VCNT < (tvs_table + (3 + 1) * 11'd64)) && (HCNT >= (ths_table + (7 * 12'd64))) && (HCNT < (ths_table + (7 + 1) * 12'd64)))
			begin
				if (mem_table[31] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[31] == 3'd1) // blue
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
				else if (mem_table[31] == 3'd2) // yellow
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
				else if (mem_table[31] == 3'd3) // orange
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
				else if (mem_table[31] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (4 * 11'd64))) && (VCNT < (tvs_table + (4 + 1) * 11'd64)) && (HCNT >= (ths_table + (0 * 12'd64))) && (HCNT < (ths_table + (0 + 1) * 12'd64)))
			begin
				if (mem_table[32] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[32] == 3'd1) // blue
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
				else if (mem_table[32] == 3'd2) // yellow
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
				else if (mem_table[32] == 3'd3) // orange
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
				else if (mem_table[32] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (4 * 11'd64))) && (VCNT < (tvs_table + (4 + 1) * 11'd64)) && (HCNT >= (ths_table + (1 * 12'd64))) && (HCNT < (ths_table + (1 + 1) * 12'd64)))
			begin
				if (mem_table[33] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[33] == 3'd1) // blue
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
				else if (mem_table[33] == 3'd2) // yellow
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
				else if (mem_table[33] == 3'd3) // orange
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
				else if (mem_table[33] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (4 * 11'd64))) && (VCNT < (tvs_table + (4 + 1) * 11'd64)) && (HCNT >= (ths_table + (2 * 12'd64))) && (HCNT < (ths_table + (2 + 1) * 12'd64)))
			begin
				if (mem_table[33] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[34] == 3'd1) // blue
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
				else if (mem_table[34] == 3'd2) // yellow
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
				else if (mem_table[34] == 3'd3) // orange
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
				else if (mem_table[34] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (4 * 11'd64))) && (VCNT < (tvs_table + (4 + 1) * 11'd64)) && (HCNT >= (ths_table + (3 * 12'd64))) && (HCNT < (ths_table + (3 + 1) * 12'd64)))
			begin
				if (mem_table[35] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[35] == 3'd1) // blue
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
				else if (mem_table[35] == 3'd2) // yellow
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
				else if (mem_table[35] == 3'd3) // orange
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
				else if (mem_table[35] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (4 * 11'd64))) && (VCNT < (tvs_table + (4 + 1) * 11'd64)) && (HCNT >= (ths_table + (4 * 12'd64))) && (HCNT < (ths_table + (4 + 1) * 12'd64)))
			begin
				if (mem_table[36] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[36] == 3'd1) // blue
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
				else if (mem_table[36] == 3'd2) // yellow
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
				else if (mem_table[36] == 3'd3) // orange
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
				else if (mem_table[36] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (4 * 11'd64))) && (VCNT < (tvs_table + (4 + 1) * 11'd64)) && (HCNT >= (ths_table + (5 * 12'd64))) && (HCNT < (ths_table + (5 + 1) * 12'd64)))
			begin
				if (mem_table[37] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[37] == 3'd1) // blue
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
				else if (mem_table[37] == 3'd2) // yellow
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
				else if (mem_table[37] == 3'd3) // orange
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
				else if (mem_table[37] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (4 * 11'd64))) && (VCNT < (tvs_table + (4 + 1) * 11'd64)) && (HCNT >= (ths_table + (6 * 12'd64))) && (HCNT < (ths_table + (6 + 1) * 12'd64)))
			begin
				if (mem_table[38] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[38] == 3'd1) // blue
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
				else if (mem_table[38] == 3'd2) // yellow
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
				else if (mem_table[38] == 3'd3) // orange
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
				else if (mem_table[38] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (4 * 11'd64))) && (VCNT < (tvs_table + (4 + 1) * 11'd64)) && (HCNT >= (ths_table + (7 * 12'd64))) && (HCNT < (ths_table + (7 + 1) * 12'd64)))
			begin
				if (mem_table[39] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[39] == 3'd1) // blue
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
				else if (mem_table[39] == 3'd2) // yellow
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
				else if (mem_table[39] == 3'd3) // orange
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
				else if (mem_table[39] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (5 * 11'd64))) && (VCNT < (tvs_table + (5 + 1) * 11'd64)) && (HCNT >= (ths_table + (0 * 12'd64))) && (HCNT < (ths_table + (0 + 1) * 12'd64)))
			begin
				if (mem_table[40] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[40] == 3'd1) // blue
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
				else if (mem_table[40] == 3'd2) // yellow
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
				else if (mem_table[40] == 3'd3) // orange
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
				else if (mem_table[40] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (5 * 11'd64))) && (VCNT < (tvs_table + (5 + 1) * 11'd64)) && (HCNT >= (ths_table + (1 * 12'd64))) && (HCNT < (ths_table + (1 + 1) * 12'd64)))
			begin
				if (mem_table[41] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[41] == 3'd1) // blue
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
				else if (mem_table[41] == 3'd2) // yellow
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
				else if (mem_table[41] == 3'd3) // orange
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
				else if (mem_table[41] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (5 * 11'd64))) && (VCNT < (tvs_table + (5 + 1) * 11'd64)) && (HCNT >= (ths_table + (2 * 12'd64))) && (HCNT < (ths_table + (2 + 1) * 12'd64)))
			begin
				if (mem_table[42] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[42] == 3'd1) // blue
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
				else if (mem_table[42] == 3'd2) // yellow
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
				else if (mem_table[42] == 3'd3) // orange
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
				else if (mem_table[42] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (5 * 11'd64))) && (VCNT < (tvs_table + (5 + 1) * 11'd64)) && (HCNT >= (ths_table + (3 * 12'd64))) && (HCNT < (ths_table + (3 + 1) * 12'd64)))
			begin
				if (mem_table[43] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[43] == 3'd1) // blue
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
				else if (mem_table[43] == 3'd2) // yellow
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
				else if (mem_table[43] == 3'd3) // orange
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
				else if (mem_table[43] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (5 * 11'd64))) && (VCNT < (tvs_table + (5 + 1) * 11'd64)) && (HCNT >= (ths_table + (4 * 12'd64))) && (HCNT < (ths_table + (4 + 1) * 12'd64)))
			begin
				if (mem_table[44] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[44] == 3'd1) // blue
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
				else if (mem_table[44] == 3'd2) // yellow
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
				else if (mem_table[44] == 3'd3) // orange
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
				else if (mem_table[44] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (5 * 11'd64)) && (VCNT < (tvs_table + (5 + 1) * 11'd64)) && (HCNT >= (ths_table + 5 * 12'd64))) && (HCNT < (ths_table + (5 + 1) * 12'd64)))
			begin
				if (mem_table[45] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[45] == 3'd1) // blue
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
				else if (mem_table[45] == 3'd2) // yellow
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
				else if (mem_table[45] == 3'd3) // orange
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
				else if (mem_table[45] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (5 * 11'd64))) && (VCNT < (tvs_table + (5 + 1) * 11'd64)) && (HCNT >= (ths_table + (6 * 12'd64))) && (HCNT < (ths_table + (6 + 1) * 12'd64)))
			begin
				if (mem_table[46] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[46] == 3'd1) // blue
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
				else if (mem_table[46] == 3'd2) // yellow
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
				else if (mem_table[46] == 3'd3) // orange
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
				else if (mem_table[46] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (5 * 11'd64))) && (VCNT < (tvs_table + (5 + 1) * 11'd64)) && (HCNT >= (ths_table + (7 * 12'd64))) && (HCNT < (ths_table + (7 + 1) * 12'd64)))
			begin
				if (mem_table[47] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[47] == 3'd1) // blue
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
				else if (mem_table[47] == 3'd2) // yellow
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
				else if (mem_table[47] == 3'd3) // orange
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
				else if (mem_table[47] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (6 * 11'd64))) && (VCNT < (tvs_table + (6 + 1) * 11'd64)) && (HCNT >= (ths_table + (0 * 12'd64))) && (HCNT < (ths_table + (0 + 1) * 12'd64)))
			begin
				if (mem_table[48] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[48] == 3'd1) // blue
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
				else if (mem_table[48] == 3'd2) // yellow
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
				else if (mem_table[48] == 3'd3) // orange
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
				else if (mem_table[48] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (6 * 11'd64))) && (VCNT < (tvs_table + (6 + 1) * 11'd64)) && (HCNT >= (ths_table + (1 * 12'd64))) && (HCNT < (ths_table + (1 + 1) * 12'd64)))
			begin
				if (mem_table[49] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[49] == 3'd1) // blue
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
				else if (mem_table[49] == 3'd2) // yellow
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
				else if (mem_table[49] == 3'd3) // orange
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
				else if (mem_table[49] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (6 * 11'd64))) && (VCNT < (tvs_table + (6 + 1) * 11'd64)) && (HCNT >= (ths_table + (2 * 12'd64))) && (HCNT < (ths_table + (2 + 1) * 12'd64)))
			begin
				if (mem_table[50] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[50] == 3'd1) // blue
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
				else if (mem_table[40] == 3'd2) // yellow
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
				else if (mem_table[50] == 3'd3) // orange
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
				else if (mem_table[50] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (6 * 11'd64))) && (VCNT < (tvs_table + (6 + 1) * 11'd64)) && (HCNT >= (ths_table + (3 * 12'd64))) && (HCNT < (ths_table + (3 + 1) * 12'd64)))
			begin
				if (mem_table[51] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[51] == 3'd1) // blue
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
				else if (mem_table[51] == 3'd2) // yellow
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
				else if (mem_table[51] == 3'd3) // orange
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
				else if (mem_table[51] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (6 * 11'd64))) && (VCNT < (tvs_table + (6 + 1) * 11'd64)) && (HCNT >= (ths_table + (4 * 12'd64))) && (HCNT < (ths_table + (4 + 1) * 12'd64)))
			begin
				if (mem_table[52] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[52] == 3'd1) // blue
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
				else if (mem_table[52] == 3'd2) // yellow
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
				else if (mem_table[52] == 3'd3) // orange
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
				else if (mem_table[52] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (6 * 11'd64))) && (VCNT < (tvs_table + (6 + 1) * 11'd64)) && (HCNT >= (ths_table + (5 * 12'd64))) && (HCNT < (ths_table + (5 + 1) * 12'd64)))
			begin
				if (mem_table[53] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[53] == 3'd1) // blue
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
				else if (mem_table[53] == 3'd2) // yellow
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
				else if (mem_table[53] == 3'd3) // orange
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
				else if (mem_table[53] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (6 * 11'd64))) && (VCNT < (tvs_table + (6 + 1) * 11'd64)) && (HCNT >= (ths_table + (6 * 12'd64))) && (HCNT < (ths_table + (6 + 1) * 12'd64)))
			begin
				if (mem_table[54] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[54] == 3'd1) // blue
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
				else if (mem_table[54] == 3'd2) // yellow
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
				else if (mem_table[54] == 3'd3) // orange
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
				else if (mem_table[54] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (6 * 11'd64))) && (VCNT < (tvs_table + (6 + 1) * 11'd64)) && (HCNT >= (ths_table + (7 * 12'd64))) && (HCNT < (ths_table + (7 + 1) * 12'd64)))
			begin
				if (mem_table[55] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[55] == 3'd1) // blue
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
				else if (mem_table[55] == 3'd2) // yellow
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
				else if (mem_table[55] == 3'd3) // orange
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
				else if (mem_table[55] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (7 * 11'd64))) && (VCNT < (tvs_table + (7 + 1) * 11'd64)) && (HCNT >= (ths_table + (0 * 12'd64))) && (HCNT < (ths_table + (0 + 1) * 12'd64)))
			begin
				if (mem_table[56] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[56] == 3'd1) // blue
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
				else if (mem_table[56] == 3'd2) // yellow
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
				else if (mem_table[56] == 3'd3) // orange
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
				else if (mem_table[56] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (7 * 11'd64))) && (VCNT < (tvs_table + (7 + 1) * 11'd64)) && (HCNT >= (ths_table + (1 * 12'd64))) && (HCNT < (ths_table + (1 + 1) * 12'd64)))
			begin
				if (mem_table[57] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[57] == 3'd1) // blue
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
				else if (mem_table[57] == 3'd2) // yellow
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
				else if (mem_table[57] == 3'd3) // orange
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
				else if (mem_table[57] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (7 * 11'd64))) && (VCNT < (tvs_table + (7 + 1) * 11'd64)) && (HCNT >= (ths_table + (2 * 12'd64))) && (HCNT < (ths_table + (2 + 1) * 12'd64)))
			begin
				if (mem_table[58] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[58] == 3'd1) // blue
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
				else if (mem_table[58] == 3'd2) // yellow
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
				else if (mem_table[58] == 3'd3) // orange
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
				else if (mem_table[58] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (7 * 11'd64))) && (VCNT < (tvs_table + (7 + 1) * 11'd64)) && (HCNT >= (ths_table + (3 * 12'd64))) && (HCNT < (ths_table + (3 + 1) * 12'd64)))
			begin
				if (mem_table[59] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[59] == 3'd1) // blue
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
				else if (mem_table[59] == 3'd2) // yellow
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
				else if (mem_table[59] == 3'd3) // orange
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
				else if (mem_table[59] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (7 * 11'd64))) && (VCNT < (tvs_table + (7 + 1) * 11'd64)) && (HCNT >= (ths_table + (4 * 12'd64))) && (HCNT < (ths_table + (4 + 1) * 12'd64)))
			begin
				if (mem_table[60] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[60] == 3'd1) // blue
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
				else if (mem_table[60] == 3'd2) // yellow
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
				else if (mem_table[60] == 3'd3) // orange
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
				else if (mem_table[60] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (7 * 11'd64))) && (VCNT < (tvs_table + (7 + 1) * 11'd64)) && (HCNT >= (ths_table + (5 * 12'd64))) && (HCNT < (ths_table + (5 + 1) * 12'd64)))
			begin
				if (mem_table[61] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[61] == 3'd1) // blue
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
				else if (mem_table[61] == 3'd2) // yellow
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
				else if (mem_table[61] == 3'd3) // orange
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
				else if (mem_table[61] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (7 * 11'd64))) && (VCNT < (tvs_table + (7 + 1) * 11'd64)) && (HCNT >= (ths_table + (6 * 12'd64))) && (HCNT < (ths_table + (6 + 1) * 12'd64)))
			begin
				if (mem_table[62] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[62] == 3'd1) // blue
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
				else if (mem_table[62] == 3'd2) // yellow
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
				else if (mem_table[62] == 3'd3) // orange
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
				else if (mem_table[62] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
			end
else if ((VCNT >= (tvs_table + (7 * 11'd64))) && (VCNT < (tvs_table + (7 + 1) * 11'd64)) && (HCNT >= (ths_table + (7 * 12'd64))) && (HCNT < (ths_table + (7 + 1) * 12'd64)))
			begin
				if (mem_table[63] == 3'd0) // black
				begin
					if (block_q == 2'b00)
                 begin R <= 8'd38; G <= 8'd38; B <= 8'd38; end
               else if (block_q == 2'b01)
                  begin R <= 8'd89; G <= 8'd89; B <= 8'd89; end
               else if (block_q == 2'b10)
                  begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
               else
                  begin R <= 8'd20; G <= 8'd20; B <= 8'd20; end 
				end
				else if (mem_table[63] == 3'd1) // blue
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
				else if (mem_table[63] == 3'd2) // yellow
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
				else if (mem_table[63] == 3'd3) // orange
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
				else if (mem_table[63] == 3'd4) // red
				begin
					if (block_q == 2'b00) 
						begin R <= 8'd195; G <= 8'd44; B <= 8'd49; end // 양옆 
					else if (block_q == 2'b01)
						begin R <= 8'd241; G <= 8'd144; B <= 8'd146; end // 가장 위 
					else if (block_q == 2'b10)
						begin R <= 8'd213; G <= 8'd67; B <= 8'd68; end // 정 중앙 
					else
						begin R <= 8'd235; G <= 8'd64; B <= 8'd52; end // 가장 아래 
				end
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

assign vd_table = VCNT - tvs_table;
assign hd_table = HCNT - ths_table;

reg [2:0] mem_table [0:63];
wire mem1, mem2, mem3;

always @(posedge iCLK) 
begin
    if (NewKB == 1'b1)
    begin
        if (KB_DAT == 8'h5A) //enter
        begin
				if(((mem_table [i] != 3'd0)&&(mem [i] != 3'd0))||((mem_table [i+6'd1] != 3'd0)&&(mem [i+6'd1] != 3'd0))||((mem_table [i+6'd2] != 3'd0)&&(mem [i+6'd2] != 3'd0))||((mem_table [i+6'd3] != 3'd0)&&(mem [i+6'd3] != 3'd0))||((mem_table [i+6'd8] != 3'd0)&&(mem [i+6'd8] != 3'd0))||((mem_table [i+6'd9] != 3'd0)&&(mem [i+6'd9] != 3'd0))||((mem_table [i+6'd10] != 3'd0)&&(mem [i+6'd10] != 3'd0))||((mem_table [i+6'd11] != 3'd0)&&(mem [i+6'd11] != 3'd0)))
            begin
					mem[i] <= mem[i];
					mem[i+6'd1] <= mem[i+6'd1];
					mem[i+6'd2] <= mem[i+6'd2];
					mem[i+6'd3] <= mem[i+6'd3];
					mem[i+6'd8] <= mem[i+6'd8];
					mem[i+6'd9] <= mem[i+6'd9];
					mem[i+6'd10] <= mem[i+6'd10];
					mem[i+6'd11] <= mem[i+6'd11];
				end
				else
				begin
					begin
						if (mem[i]==3'd0)
							mem_table[i] <= mem_table[i];
						else if (mem[i]!=3'd0)
							mem_table[i] <= mem[i];
					end
					begin
						if (mem[i+6'd1]==3'd0)
							mem_table[i+6'd1] <= mem_table[i+6'd1];
						else if (mem[i+6'd1]!=3'd0)
							mem_table[i+6'd1] <= mem[i+6'd1];
					end
					begin
						if (mem[i+6'd2]==3'd0)
							mem_table[i+6'd2] <= mem_table[i+6'd2];
						else if (mem[i+6'd2]!=3'd0)
							mem_table[i+6'd2] <= mem[i+6'd2];
					end
					begin
						if (mem[i+6'd3]==3'd0)
							mem_table[i+6'd3] <= mem_table[i+6'd3];
						else if (mem[i+6'd3]!=6'd0)
							mem_table[i+6'd3] <= mem[i+6'd3];
					end
					begin
						if (mem[i+6'd8]==3'd0)
							mem_table[i+6'd8] <= mem_table[i+6'd8];
						else if (mem[i+6'd8]!=3'd0)
							mem_table[i+6'd8] <= mem[i+6'd8];
					end
					begin
						if (mem[i+6'd9]==3'd0)
							mem_table[i+6'd9] <= mem_table[i+6'd9];
						else if (mem[i+6'd9]!=3'd0)
							mem_table[i+6'd9] <= mem[i+6'd9];	
					end
					begin
						if (mem[i+6'd10]==3'd0)
							mem_table[i+6'd10] <= mem_table[i+6'd10];
						else if (mem[i+6'd10]!=3'd0)
							mem_table[i+6'd10] <= mem[i+6'd10];
					end
					begin
						if (mem[i+6'd11]==3'd0)
							mem_table[i+6'd11] <= mem_table[i+6'd11];
						else if (mem[i+6'd11]!=3'd0)
							mem_table[i+6'd11] <= mem[i+6'd11];
					end
					{mem[i], mem[i+6'd1], mem[i+6'd2], mem[i+6'd3], mem[i+6'd8], mem[i+6'd9], mem[i+6'd10], mem[i+6'd11]} <= 24'd0;
				end
        end
		  else if (KB_DAT == 8'h2d) // r
			begin
				{mem_table[0], mem_table[1], mem_table[2], mem_table[3], mem_table[4], mem_table[5], mem_table[6], mem_table[7], mem_table[8], mem_table[9], mem_table[10], mem_table[11], mem_table[12], mem_table[13], mem_table[14], mem_table[15], mem_table[16], mem_table[17], mem_table[18], mem_table[19], mem_table[20], mem_table[21], mem_table[22], mem_table[23], mem_table[24], mem_table[25], mem_table[26], mem_table[27], mem_table[28], mem_table[29], mem_table[30], mem_table[31], mem_table[32], mem_table[33], mem_table[34], mem_table[35], mem_table[36], mem_table[37], mem_table[38], mem_table[39], mem_table[40], mem_table[41], mem_table[42], mem_table[43], mem_table[44], mem_table[45], mem_table[46], mem_table[47], mem_table[48], mem_table[49], mem_table[50], mem_table[51], mem_table[52], mem_table[53], mem_table[54], mem_table[55], mem_table[56], mem_table[57], mem_table[58], mem_table[59], mem_table[60], mem_table[61], mem_table[62], mem_table[63]} <= 192'd0;
				{mem[i], mem[i+6'd1], mem[i+6'd2], mem[i+6'd3], mem[i+6'd8], mem[i+6'd9], mem[i+6'd10], mem[i+6'd11]} <= 24'd0;
			end
        else // 방향키 
        begin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
				begin
					if (x1 == 1'b1) begin mem_table[0]<=3'd0; mem_table[1]<=3'd0; mem_table[2]<=3'd0; mem_table[3]<=3'd0; mem_table[4]<=3'd0; mem_table[5]<=3'd0; mem_table[6]<=3'd0; mem_table[7]<=3'd0; end
					if (x2 == 1'b1) begin mem_table[8]<=3'd0; mem_table[9]<=3'd0; mem_table[10]<=3'd0; mem_table[11]<=3'd0; mem_table[12]<=3'd0; mem_table[13]<=3'd0; mem_table[14]<=3'd0; mem_table[15]<=3'd0; end
					if (x3 == 1'b1) begin mem_table[16]<=3'd0; mem_table[17]<=3'd0; mem_table[18]<=3'd0; mem_table[19]<=3'd0; mem_table[20]<=3'd0; mem_table[21]<=3'd0; mem_table[22]<=3'd0; mem_table[23]<=3'd0; end
					if (x4 == 1'b1) begin mem_table[24]<=3'd0; mem_table[25]<=3'd0; mem_table[26]<=3'd0; mem_table[27]<=3'd0; mem_table[28]<=3'd0; mem_table[29]<=3'd0; mem_table[30]<=3'd0; mem_table[31]<=3'd0; end
					if (x5 == 1'b1) begin mem_table[32]<=3'd0; mem_table[33]<=3'd0; mem_table[34]<=3'd0; mem_table[35]<=3'd0; mem_table[36]<=3'd0; mem_table[37]<=3'd0; mem_table[38]<=3'd0; mem_table[39]<=3'd0; end
					if (x6 == 1'b1) begin mem_table[40]<=3'd0; mem_table[41]<=3'd0; mem_table[42]<=3'd0; mem_table[43]<=3'd0; mem_table[44]<=3'd0; mem_table[45]<=3'd0; mem_table[46]<=3'd0; mem_table[47]<=3'd0; end
					if (x7 == 1'b1) begin mem_table[48]<=3'd0; mem_table[49]<=3'd0; mem_table[50]<=3'd0; mem_table[51]<=3'd0; mem_table[52]<=3'd0; mem_table[53]<=3'd0; mem_table[54]<=3'd0; mem_table[55]<=3'd0; end
					if (x8 == 1'b1) begin mem_table[56]<=3'd0; mem_table[57]<=3'd0; mem_table[58]<=3'd0; mem_table[59]<=3'd0; mem_table[60]<=3'd0; mem_table[61]<=3'd0; mem_table[62]<=3'd0; mem_table[63]<=3'd0; end
					if (y1 == 1'b1) begin mem_table[0]<=3'd0; mem_table[8]<=3'd0; mem_table[16]<=3'd0; mem_table[24]<=3'd0; mem_table[32]<=3'd0; mem_table[40]<=3'd0; mem_table[48]<=3'd0; mem_table[56]<=3'd0; end
					if (y2 == 1'b1) begin mem_table[1]<=3'd0; mem_table[9]<=3'd0; mem_table[17]<=3'd0; mem_table[25]<=3'd0; mem_table[33]<=3'd0; mem_table[41]<=3'd0; mem_table[49]<=3'd0; mem_table[57]<=3'd0; end 
					if (y3 == 1'b1) begin mem_table[2]<=3'd0; mem_table[10]<=3'd0; mem_table[18]<=3'd0; mem_table[26]<=3'd0; mem_table[34]<=3'd0; mem_table[42]<=3'd0; mem_table[50]<=3'd0; mem_table[58]<=3'd0; end
					if (y4 == 1'b1) begin mem_table[3]<=3'd0; mem_table[11]<=3'd0; mem_table[19]<=3'd0; mem_table[27]<=3'd0; mem_table[35]<=3'd0; mem_table[43]<=3'd0; mem_table[51]<=3'd0; mem_table[59]<=3'd0; end
					if (y5 == 1'b1) begin mem_table[4]<=3'd0; mem_table[12]<=3'd0; mem_table[20]<=3'd0; mem_table[28]<=3'd0; mem_table[36]<=3'd0; mem_table[44]<=3'd0; mem_table[52]<=3'd0; mem_table[60]<=3'd0; end
					if (y6 == 1'b1) begin mem_table[5]<=3'd0; mem_table[13]<=3'd0; mem_table[21]<=3'd0; mem_table[29]<=3'd0; mem_table[37]<=3'd0; mem_table[45]<=3'd0; mem_table[53]<=3'd0; mem_table[61]<=3'd0; end
					if (y7 == 1'b1) begin mem_table[6]<=3'd0; mem_table[14]<=3'd0; mem_table[22]<=3'd0; mem_table[30]<=3'd0; mem_table[38]<=3'd0; mem_table[46]<=3'd0; mem_table[54]<=3'd0; mem_table[62]<=3'd0; end
					if (y8 == 1'b1) begin mem_table[7]<=3'd0; mem_table[15]<=3'd0; mem_table[23]<=3'd0; mem_table[31]<=3'd0; mem_table[39]<=3'd0; mem_table[47]<=3'd0; mem_table[55]<=3'd0; mem_table[63]<=3'd0; end
				end
				if (KB_DAT == 8'h23) // right
				begin
					i[5:3] <= i[5:3];
					if ((mem[i+6'd3] != 3'd0) || (mem[i+6'd11] != 3'd0))
					begin
						if ( i[2:0] == 6'd4 )
							i[2:0] <= i[2:0];
						else 
						begin
							i[2:0] <= i[2:0] + 3'd1; // MUX 좌표를 설정해줌 
							mem[i + 6'd4] <= mem[i+6'd3]; // 오른쪽으로 색깔 이동
							mem[i + 6'd3] <= mem[i+6'd2];
							mem[i + 6'd2] <= mem[i+6'd1];
							mem[i + 6'd1] <= mem[i];							
							mem[i + 6'd12] <= mem[i+6'd11];
							mem[i + 6'd11] <= mem[i+6'd10];
							mem[i + 6'd10] <= mem[i+6'd9];
							mem[i + 6'd9] <= mem[i+6'd8];
							mem[i] <= 3'd0; // 원래 있던 자리 검정
							mem[i + 6'd8] <= 3'd0;
						end
					end
					else if ((mem[i+6'd2] != 3'd0) || (mem[i+6'd10] != 3'd0))
					begin
						if ( i[2:0] == 6'd5 )
							i[2:0] <= i[2:0];
						else 
						begin
							i[2:0] <= i[2:0] + 3'd1; // MUX 좌표를 설정해줌 
							mem[i + 6'd3] <= mem[i+6'd2];// 오른쪽으로 색깔 이동
							mem[i + 6'd2] <= mem[i+6'd1];
							mem[i + 6'd1] <= mem[i];							
							mem[i + 6'd11] <= mem[i+6'd10];
							mem[i + 6'd10] <= mem[i+6'd9];
							mem[i + 6'd9] <= mem[i+6'd8];
							mem[i] <= 3'd0; // 원래 있던 자리 검정
							mem[i + 6'd8] <= 3'd0; 
						end
					end
					else if ((mem[i+6'd1] != 3'd0) || (mem[i+6'd9] != 3'd0))
					begin
						if ( i[2:0] == 6'd6 )
							i[2:0] <= i[2:0];
						else 
						begin
							i[2:0] <= i[2:0] + 3'd1; // MUX 좌표를 설정해줌 
							mem[i + 6'd2] <= mem[i+6'd1]; // 오른쪽으로 색깔 이동
							mem[i + 6'd1] <= mem[i];							
							mem[i + 6'd10] <= mem[i+6'd9];
							mem[i + 6'd9] <= mem[i+6'd8];
							mem[i] <= 3'd0; // 원래 있던 자리 검정
							mem[i + 6'd8] <= 3'd0;
						end
					end
					else
					begin
						if ( i[2:0] == 6'd7 )
							i[2:0] <= i[2:0];
						else 
						begin
							i[2:0] <= i[2:0] + 3'd1; // MUX 좌표를 설정해줌 
							mem[i + 6'd1] <= mem[i]; // 오른쪽으로 색깔 이동	
							mem[i + 6'd9] <= mem[i+6'd8];
							mem[i] <= 3'd0; // 원래 있던 자리 검정
							mem[i + 6'd8] <= 3'd0;
						end
					end	
				end
				else if (KB_DAT == 8'h1C) // left
				begin
					i[5:3] <= i[5:3];
					if (i[2:0] == 3'd0)
						i[2:0] <= i[2:0];
					else
					begin
						i[2:0] <= i[2:0] - 3'd1; // MUX 좌표를 설정해줌 
						mem[i + 6'd2] <= mem[i+6'd3]; // 왼쪽으로 색깔 이동
						mem[i + 6'd1] <= mem[i+6'd2];
						mem[i] <= mem[i+6'd1];	
						mem[i - 6'd1] <= mem[i];
						mem[i + 6'd10] <= mem[i+6'd11];
						mem[i + 6'd9] <= mem[i+6'd10];
						mem[i + 6'd8] <= mem[i+6'd9];
						mem[i + 6'd7] <= mem[i+6'd8];
						mem[i + 6'd3] <= 3'd0; // 원래 있던 자리 검정
						mem[i + 6'd11] <= 3'd0;
					end
				end
				else if (KB_DAT == 8'h1B) // down
				begin
					i[2:0] <= i[2:0];
					if ((mem[i+6'd8] != 3'd0) || (mem[i+6'd9] != 3'd0)|| (mem[i+6'd10] != 3'd0)|| (mem[i+6'd11] != 3'd0))
					begin
						if ( i[5:3] == 6'd6 )
							i[5:3] <= i[5:3];
						else 
						begin
							i[5:3] <= i[5:3] + 3'd1; // MUX 좌표를 설정해줌
							mem[i + 6'd11] <= mem[i + 6'd3]; // 아래로 색깔 이동
							mem[i + 6'd10] <= mem[i + 6'd2];
							mem[i + 6'd9] <= mem[i + 6'd1]; 
							mem[i + 6'd8] <= mem[i];	
							mem[i + 6'd19] <= mem[i + 6'd11];
							mem[i + 6'd18] <= mem[i + 6'd10];						
							mem[i + 6'd17] <= mem[i + 6'd9];
							mem[i + 6'd16] <= mem[i + 6'd8];
							mem[i] <= mem_table[i]; // 원래 있던 자리 검정
							mem[i + 6'd1] <= 3'd0;
							mem[i + 6'd2] <= 3'd0;
							mem[i + 6'd3] <= 3'd0; 
						end
					end	
					else
					begin
						if ( i[5:3] == 6'd7 )
							i[5:3] <= i[5:3];
						else 
						begin
							i[5:3] <= i[5:3] + 3'd1; // MUX 좌표를 설정해줌
							mem[i + 6'd11] <= mem[i+6'd3]; 
							mem[i + 6'd10] <= mem[i+6'd2];
							mem[i + 6'd9] <= mem[i+6'd1]; // 아래로 색깔 이동
							mem[i + 6'd8] <= mem[i];	
							mem[i] <= mem_table[i]; // 원래 있던 자리 검정
							mem[i + 6'd1] <= 3'd0; 
							mem[i + 6'd2] <= 3'd0; 
							mem[i + 6'd3] <= 3'd0;
						end
					end
				end
				else if (KB_DAT == 8'h1D) //up
				begin
					i[2:0] <= i[2:0];
					if (i[5:3] == 3'd0)
						i[5:3] <= i[5:3];
					else
					begin
						i[5:3] <= i[5:3] - 3'd1; // MUX 좌표를 설정해줌
						mem[i - 6'd5] <= mem[i+6'd3]; 
						mem[i - 6'd6] <= mem[i+6'd2];
						mem[i - 6'd7] <= mem[i+6'd1]; // 아래로 색깔 이동
						mem[i - 6'd8] <= mem[i];	
						mem[i + 6'd3] <= mem[i+6'd11];
						mem[i + 6'd2] <= mem[i+6'd10];						
						mem[i + 6'd1] <= mem[i+6'd9];
						mem[i] <= mem[i+6'd8];
						mem[i + 6'd11] <= 3'd0; // 원래 있던 자리 검정
						mem[i + 6'd10] <= 3'd0;
						mem[i + 6'd9] <= 3'd0;
						mem[i + 6'd8] <= 3'd0; 
					end	
				end
            else if ((mem1 == 1'b0)&&(KB_DAT == 8'h16)) //1
            begin
					case (M_S_1)
						3'd0: 
							begin
								mem [i] <= 3'd0;
								mem [i+6'd1] <= 3'd0;
								mem [i+6'd2] <= 3'd0; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd0;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						3'd1:
							begin
								mem [i] <= 3'd1;
								mem [i+6'd1] <= 3'd1;
								mem [i+6'd2] <= 3'd1; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd1;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						3'd2:
							begin
								mem [i] <= 3'd1;
								mem [i+6'd1] <= 3'd1;
								mem [i+6'd2] <= 3'd1; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd1;
								mem [i+6'd9] <= 3'd1;
								mem [i+6'd10] <= 3'd1;
								mem [i+6'd11] <= 3'd0;
							end
						3'd3:
							begin
								mem [i] <= 3'd1;
								mem [i+6'd1] <= 3'd1;
								mem [i+6'd2] <= 3'd1; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd0;
								mem [i+6'd10] <= 3'd1;
								mem [i+6'd11] <= 3'd0;
							end
						3'd4:
							begin
								mem [i] <= 3'd1;
								mem [i+6'd1] <= 3'd1;
								mem [i+6'd2] <= 3'd0; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd0;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						3'd5:
							begin
								mem [i] <= 3'd1;
								mem [i+6'd1] <= 3'd0;
								mem [i+6'd2] <= 3'd0; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd0;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						3'd6:
							begin
								mem [i] <= 3'd1;
								mem [i+6'd1] <= 3'd1;
								mem [i+6'd2] <= 3'd0; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd1;
								mem [i+6'd9] <= 3'd1;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						default:
							begin
								mem [i] <= 3'd1;
								mem [i+6'd1] <= 3'd0;
								mem [i+6'd2] <= 3'd0; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd1;
								mem [i+6'd9] <= 3'd1;
								mem [i+6'd10] <= 3'd1;
								mem [i+6'd11] <= 3'd0;
							end
					endcase
            end
            else if ((mem2 == 1'b0)&&(KB_DAT == 8'h1E)) //2
            begin
					case (M_S_2)
						default: 
							begin
								mem [i] <= 3'd2;
								mem [i+6'd1] <= 3'd0;
								mem [i+6'd2] <= 3'd0; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd2;
								mem [i+6'd9] <= 3'd2;
								mem [i+6'd10] <= 3'd2;
								mem [i+6'd11] <= 3'd0;
							end
						3'd1:
							begin
								mem [i] <= 3'd2;
								mem [i+6'd1] <= 3'd2;
								mem [i+6'd2] <= 3'd2; 
								mem [i+6'd3] <= 3'd2;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd0;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						3'd2:
							begin
								mem [i] <= 3'd2;
								mem [i+6'd1] <= 3'd2;
								mem [i+6'd2] <= 3'd2; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd2;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						3'd3:
							begin
								mem [i] <= 3'd2;
								mem [i+6'd1] <= 3'd2;
								mem [i+6'd2] <= 3'd2; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd2;
								mem [i+6'd9] <= 3'd2;
								mem [i+6'd10] <= 3'd2;
								mem [i+6'd11] <= 3'd0;
							end
						3'd4:
							begin
								mem [i] <= 3'd2;
								mem [i+6'd1] <= 3'd2;
								mem [i+6'd2] <= 3'd2; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd0;
								mem [i+6'd10] <= 3'd2;
								mem [i+6'd11] <= 3'd0;
							end
						3'd5:
							begin
								mem [i] <= 3'd2;
								mem [i+6'd1] <= 3'd2;
								mem [i+6'd2] <= 3'd0; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd0;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						3'd6:
							begin
								mem [i] <= 3'd2;
								mem [i+6'd1] <= 3'd0;
								mem [i+6'd2] <= 3'd0;
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd0;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						3'd7:
							begin
								mem [i] <= 3'd2;
								mem [i+6'd1] <= 3'd2;
								mem [i+6'd2] <= 3'd0;
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd2;
								mem [i+6'd9] <= 3'd2;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
					endcase
            end
            else if ((mem3 == 1'b0)&&(KB_DAT == 8'h26)) //3
            begin
               case (M_S_3)
						3'd0: 
							begin
								mem [i] <= 3'd0;
								mem [i+6'd1] <= 3'd0;
								mem [i+6'd2] <= 3'd0; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd0;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						3'd1:
							begin
								mem [i] <= 3'd3;
								mem [i+6'd1] <= 3'd3;
								mem [i+6'd2] <= 3'd3; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd3;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						3'd2:
							begin
								mem [i] <= 3'd3;
								mem [i+6'd1] <= 3'd3;
								mem [i+6'd2] <= 3'd3; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd3;
								mem [i+6'd9] <= 3'd3;
								mem [i+6'd10] <= 3'd3;
								mem [i+6'd11] <= 3'd0;
							end
						3'd3:
							begin
								mem [i] <= 3'd3;
								mem [i+6'd1] <= 3'd3;
								mem [i+6'd2] <= 3'd3; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd0;
								mem [i+6'd10] <= 3'd3;
								mem [i+6'd11] <= 3'd0;
							end
						3'd4:
							begin
								mem [i] <= 3'd3;
								mem [i+6'd1] <= 3'd3;
								mem [i+6'd2] <= 3'd0; 
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd0;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						3'd5:
							begin
								mem [i] <= 3'd3;
								mem [i+6'd1] <= 3'd0;
								mem [i+6'd2] <= 3'd0;
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd0;
								mem [i+6'd9] <= 3'd0;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						3'd6:
							begin
								mem [i] <= 3'd3;
								mem [i+6'd1] <= 3'd3;
								mem [i+6'd2] <= 3'd0;
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd3;
								mem [i+6'd9] <= 3'd3;
								mem [i+6'd10] <= 3'd0;
								mem [i+6'd11] <= 3'd0;
							end
						default:
							begin
								mem [i] <= 3'd3;
								mem [i+6'd1] <= 3'd0;
								mem [i+6'd2] <= 3'd0;
								mem [i+6'd3] <= 3'd0;
								mem [i+6'd8] <= 3'd3;
								mem [i+6'd9] <= 3'd3;
								mem [i+6'd10] <= 3'd3;
								mem [i+6'd11] <= 3'd0;
							end
					endcase   
            end
        end
    end
		if (cntM1 == 4'd5) //game over condition
		begin
			if (cntS1 == 4'd7) begin mem_table[0]<=3'd4; mem_table[1]<=3'd4; mem_table[2]<=3'd4; mem_table[3]<=3'd4; mem_table[4]<=3'd4; mem_table[5]<=3'd4; mem_table[6]<=3'd4; mem_table[7]<=3'd4; end
			if (cntS1 == 4'd6) begin mem_table[8]<=3'd4; mem_table[9]<=3'd4; mem_table[10]<=3'd4; mem_table[11]<=3'd4; mem_table[12]<=3'd4; mem_table[13]<=3'd4; mem_table[14]<=3'd4; mem_table[15]<=3'd4; end
			if (cntS1 == 4'd5) begin mem_table[16]<=3'd4; mem_table[17]<=3'd4; mem_table[18]<=3'd4; mem_table[19]<=3'd4; mem_table[20]<=3'd4; mem_table[21]<=3'd4; mem_table[22]<=3'd4; mem_table[23]<=3'd4; end
			if (cntS1 == 4'd4) begin mem_table[24]<=3'd4; mem_table[25]<=3'd4; mem_table[26]<=3'd4; mem_table[27]<=3'd4; mem_table[28]<=3'd4; mem_table[29]<=3'd4; mem_table[30]<=3'd4; mem_table[31]<=3'd4; end
			if (cntS1 == 4'd3) begin mem_table[32]<=3'd4; mem_table[33]<=3'd4; mem_table[34]<=3'd4; mem_table[35]<=3'd4; mem_table[36]<=3'd4; mem_table[37]<=3'd4; mem_table[38]<=3'd4; mem_table[39]<=3'd4; end
			if (cntS1 == 4'd2) begin mem_table[40]<=3'd4; mem_table[41]<=3'd4; mem_table[42]<=3'd4; mem_table[43]<=3'd4; mem_table[44]<=3'd4; mem_table[45]<=3'd4; mem_table[46]<=3'd4; mem_table[47]<=3'd4; end
			if (cntS1 == 4'd1) begin mem_table[48]<=3'd4; mem_table[49]<=3'd4; mem_table[50]<=3'd4; mem_table[51]<=3'd4; mem_table[52]<=3'd4; mem_table[53]<=3'd4; mem_table[54]<=3'd4; mem_table[55]<=3'd4; end
			if (cntS1 == 4'd0) begin mem_table[56]<=3'd4; mem_table[57]<=3'd4; mem_table[58]<=3'd4; mem_table[59]<=3'd4; mem_table[60]<=3'd4; mem_table[61]<=3'd4; mem_table[62]<=3'd4; mem_table[63]<=3'd4; end
		end
end

reg x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8;
reg [2:0] x,y;
reg [13:0] score;
output [2:0] x,y;

always @(posedge iCLK)
begin
	begin
		if ((mem_table[0]!=3'd0)&&(mem_table[1]!=3'd0)&&(mem_table[2]!=3'd0)&&(mem_table[3]!=3'd0)&&(mem_table[4]!=3'd0)&&(mem_table[5]!=3'd0)&&(mem_table[6]!=3'd0)&&(mem_table[7]!=3'd0))
		begin
			x1 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			x1 <= 1'b0;
	end
	begin
		if ((mem_table[8]!=3'd0)&&(mem_table[9]!=3'd0)&&(mem_table[10]!=3'd0)&&(mem_table[11]!=3'd0)&&(mem_table[12]!=3'd0)&&(mem_table[13]!=3'd0)&&(mem_table[14]!=3'd0)&&(mem_table[15]!=3'd0))
		begin	
			x2 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			x2 <= 1'b0;
	end
	begin
		if ((mem_table[16]!=3'd0)&&(mem_table[17]!=3'd0)&&(mem_table[18]!=3'd0)&&(mem_table[19]!=3'd0)&&(mem_table[20]!=3'd0)&&(mem_table[21]!=3'd0)&&(mem_table[22]!=3'd0)&&(mem_table[23]!=3'd0))
		begin	
			x3 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			x3 <= 1'b0;
	end
	begin
		if ((mem_table[24]!=3'd0)&&(mem_table[25]!=3'd0)&&(mem_table[26]!=3'd0)&&(mem_table[27]!=3'd0)&&(mem_table[28]!=3'd0)&&(mem_table[29]!=3'd0)&&(mem_table[30]!=3'd0)&&(mem_table[31]!=3'd0))
		begin	
			x4 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			x4 <= 1'b0;
	end
	begin
		if ((mem_table[32]!=3'd0)&&(mem_table[33]!=3'd0)&&(mem_table[34]!=3'd0)&&(mem_table[35]!=3'd0)&&(mem_table[36]!=3'd0)&&(mem_table[37]!=3'd0)&&(mem_table[38]!=3'd0)&&(mem_table[39]!=3'd0))
		begin	
			x5 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			x5 <= 1'b0;
	end
	begin
		if ((mem_table[40]!=3'd0)&&(mem_table[41]!=3'd0)&&(mem_table[42]!=3'd0)&&(mem_table[43]!=3'd0)&&(mem_table[44]!=3'd0)&&(mem_table[45]!=3'd0)&&(mem_table[46]!=3'd0)&&(mem_table[47]!=3'd0))
		begin	
			x6 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			x6 <= 1'b0;
	end
	begin
		if ((mem_table[48]!=3'd0)&&(mem_table[49]!=3'd0)&&(mem_table[50]!=3'd0)&&(mem_table[51]!=3'd0)&&(mem_table[52]!=3'd0)&&(mem_table[53]!=3'd0)&&(mem_table[54]!=3'd0)&&(mem_table[55]!=3'd0))
		begin	
			x7 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			x7 <= 1'b0;
	end
	begin
		if ((mem_table[56]!=3'd0)&&(mem_table[57]!=3'd0)&&(mem_table[58]!=3'd0)&&(mem_table[59]!=3'd0)&&(mem_table[60]!=3'd0)&&(mem_table[61]!=3'd0)&&(mem_table[62]!=3'd0)&&(mem_table[63]!=3'd0))
		begin	
			x8 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			x8 <= 1'b0;
	end
	begin
		if ((mem_table[0]!=3'd0)&&(mem_table[8]!=3'd0)&&(mem_table[16]!=3'd0)&&(mem_table[24]!=3'd0)&&(mem_table[32]!=3'd0)&&(mem_table[40]!=3'd0)&&(mem_table[48]!=3'd0)&&(mem_table[56]!=3'd0))
		begin	
			y1 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			y1 <= 1'b0;
	end
	begin
		if ((mem_table[1]!=3'd0)&&(mem_table[9]!=3'd0)&&(mem_table[17]!=3'd0)&&(mem_table[25]!=3'd0)&&(mem_table[33]!=3'd0)&&(mem_table[41]!=3'd0)&&(mem_table[49]!=3'd0)&&(mem_table[57]!=3'd0))
		begin	
			y2 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			y2 <= 1'b0;
	end
	begin
		if ((mem_table[2]!=3'd0)&&(mem_table[10]!=3'd0)&&(mem_table[18]!=3'd0)&&(mem_table[26]!=3'd0)&&(mem_table[34]!=3'd0)&&(mem_table[42]!=3'd0)&&(mem_table[50]!=3'd0)&&(mem_table[58]!=3'd0))
		begin	
			y3 <= 1'b1;
		//	score <= score + 14'd8;
		end
		else 
			y3 <= 1'b0;
	end
	begin
		if ((mem_table[3]!=3'd0)&&(mem_table[11]!=3'd0)&&(mem_table[19]!=3'd0)&&(mem_table[27]!=3'd0)&&(mem_table[35]!=3'd0)&&(mem_table[43]!=3'd0)&&(mem_table[51]!=3'd0)&&(mem_table[59]!=3'd0))
		begin	
			y4 <= 1'b1;
			//9score <= score + 14'd8;
		end
		else 
			y4 <= 1'b0;
	end
	begin
		if ((mem_table[4]!=3'd0)&&(mem_table[12]!=3'd0)&&(mem_table[20]!=3'd0)&&(mem_table[28]!=3'd0)&&(mem_table[36]!=3'd0)&&(mem_table[44]!=3'd0)&&(mem_table[52]!=3'd0)&&(mem_table[60]!=3'd0))
		begin	
			y5 <= 1'b1;
		//	score <= score + 14'd8;
		end
		else 
			y5 <= 1'b0;
	end
	begin
		if ((mem_table[5]!=3'd0)&&(mem_table[13]!=3'd0)&&(mem_table[21]!=3'd0)&&(mem_table[29]!=3'd0)&&(mem_table[37]!=3'd0)&&(mem_table[45]!=3'd0)&&(mem_table[53]!=3'd0)&&(mem_table[61]!=3'd0))
		begin	
			y6 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			y6 <= 1'b0;
	end
	begin
		if ((mem_table[6]!=3'd0)&&(mem_table[14]!=3'd0)&&(mem_table[22]!=3'd0)&&(mem_table[30]!=3'd0)&&(mem_table[38]!=3'd0)&&(mem_table[46]!=3'd0)&&(mem_table[54]!=3'd0)&&(mem_table[62]!=3'd0))
		begin	
			y7 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			y7 <= 1'b0;
	end
	begin
		if ((mem_table[7]!=3'd0)&&(mem_table[15]!=3'd0)&&(mem_table[23]!=3'd0)&&(mem_table[31]!=3'd0)&&(mem_table[39]!=3'd0)&&(mem_table[47]!=3'd0)&&(mem_table[55]!=3'd0)&&(mem_table[63]!=3'd0))
		begin	
			y8 <= 1'b1;
			//score <= score + 14'd8;
		end
		else 
			y8 <= 1'b0;
	end
		x <= x1+x2+x3+x4+x5+x6+x7+x8;
		y <= y1+y2+y3+y4+y5+y6+y7+y8;
end

output led;
input ps2Clk, ps2Dat;

wire NewKB, ps2Clk, ps2Dat; 
wire [7:0] KB_DAT;
wire led;

wire [7:0] R0, G0, B0;
wire led2;
wire [2:0] M_S_1, M_S_2, M_S_3;

RxKB k1 (.PS_CLK(ps2Clk), .PS_DAT(ps2Dat), .CLK(iCLK), .RESET(reset), .NewKB(NewKB), .KB_DAT(KB_DAT));

block_single b1 (.address(block_addr), .clock(iCLK), .q(block_q));

block_set b2 (.iCLK(iCLK), .reset(reset), .HCNT(HCNT), .VCNT(VCNT), .R(R0), .G(G0), .B(B0), .ps2Clk(ps2Clk), .ps2Dat(ps2Dat), .led(led2), .M_S_1(M_S_1), .M_S_2(M_S_2), .M_S_3(M_S_3), .mem1(mem1), .mem2(mem2), .mem3(mem3));

endmodule
