	
module scoretime (iCLK, reset, HCNT, VCNT, R ,G, B, x, y, cntM1, cntS1);

input iCLK, reset;
input [11:0] HCNT;
input [10:0] VCNT;
input [2:0] x, y;
output [7:0] R, G, B;

reg [7:0] R, G, B;
reg sel_score, sel_dotdot;
reg [3:0] sel_number1, sel_number2, sel_number3, sel_number4, sel_time1, sel_time2, sel_time3, sel_time4;
wire iCLK, reset;
wire [11:0] HCNT;
wire [10:0] VCNT;
wire [11:0] hd_score, hd_number1, hd_number2, hd_number3, hd_number4, hd_time1, hd_time2, hd_time3, hd_time4, hd_dotdot;
wire [10:0] vd_score, vd_number1, vd_number2, vd_number3, vd_number4, vd_time1, vd_time2, vd_time3, vd_time4, vd_dotdot;
wire [13:0] score_addr;
wire [10:0] number_addr1, number_addr2, number_addr3, number_addr4, time_addr1, time_addr2, time_addr3, time_addr4, dotdot_addr;
wire [1:0] number0_q1, number1_q1, number2_q1, number3_q1, number4_q1, number5_q1, number6_q1, number7_q1, number8_q1, number9_q1, number0_q2, number1_q2, number2_q2, number3_q2, number4_q2, number5_q2, number6_q2, number7_q2, number8_q2, number9_q2, number0_q3, number1_q3, number2_q3, number3_q3, number4_q3, number5_q3, number6_q3, number7_q3, number8_q3, number9_q3, number0_q4, number1_q4, number2_q4, number3_q4, number4_q4, number5_q4, number6_q4, number7_q4, number8_q4, number9_q4, time0_q1, time1_q1, time2_q1, time3_q1, time4_q1, time5_q1, time6_q1, time7_q1, time8_q1, time9_q1, time0_q2, time1_q2, time2_q2, time3_q2, time4_q2, time5_q2, time6_q2, time7_q2, time8_q2, time9_q2, time0_q3, time1_q3, time2_q3, time3_q3, time4_q3, time5_q3, time6_q3, time7_q3, time8_q3, time9_q3, time0_q4, time1_q4, time2_q4, time3_q4, time4_q4, time5_q4, time6_q4, time7_q4, time8_q4, time9_q4, score_q, dotdot_q ;
reg [2:0] q1,q2,q3,q4,t1,t2,t3,t4;

//parameter tvs_score = 11'd256;
//parameter ths_score = 12'd1408;
parameter tvs_number1 = 11'd256;
parameter ths_number1 = 12'd1408;
parameter tvs_number2 = 11'd256;
parameter ths_number2 = 12'd1440;
parameter tvs_number3 = 11'd256;
parameter ths_number3 = 12'd1472;
parameter tvs_number4 = 11'd256;
parameter ths_number4 = 12'd1504;
parameter tvs_time1 = 11'd704;
parameter ths_time1 = 12'd1408;
parameter tvs_time2 = 11'd704;
parameter ths_time2 = 12'd1440;
parameter tvs_dotdot = 11'd704;
parameter ths_dotdot = 12'd1472;
parameter tvs_time3 = 11'd704;
parameter ths_time3 = 12'd1504;
parameter tvs_time4 = 11'd704;
parameter ths_time4 = 12'd1536;

//assign vd_score = VCNT - tvs_score;
//assign hd_score = HCNT - ths_score;
assign vd_number1 = VCNT - tvs_number1;
assign hd_number1 = HCNT - ths_number1;
assign vd_number2 = VCNT - tvs_number2;
assign hd_number2 = HCNT - ths_number2;
assign vd_number3 = VCNT - tvs_number3;
assign hd_number3 = HCNT - ths_number3;
assign vd_number4 = VCNT - tvs_number4;
assign hd_number4 = HCNT - ths_number4;
assign vd_time1 = VCNT - tvs_time1;
assign hd_time1 = HCNT - ths_time1;
assign vd_time2 = VCNT - tvs_time2;
assign hd_time2 = HCNT - ths_time2;
assign vd_dotdot = VCNT - tvs_dotdot;
assign hd_dotdot = HCNT - ths_dotdot;
assign vd_time3 = VCNT - tvs_time3;
assign hd_time3 = HCNT - ths_time3;
assign vd_time4 = VCNT - tvs_time4;
assign hd_time4 = HCNT - ths_time4;

//assign score_addr = {vd_score[5:0], hd_score[7:0]};
assign number_addr1 = {vd_number1[5:0], hd_number1[4:0]};
assign number_addr2 = {vd_number2[5:0], hd_number2[4:0]};
assign number_addr3 = {vd_number3[5:0], hd_number3[4:0]};
assign number_addr4 = {vd_number4[5:0], hd_number4[4:0]};
assign time_addr1 = {vd_time1[5:0], hd_time1[4:0]};
assign time_addr2 = {vd_time2[5:0], hd_time2[4:0]};
assign time_addr3 = {vd_time3[5:0], hd_time3[4:0]};
assign time_addr4 = {vd_time4[5:0], hd_time4[4:0]};
assign dotdot_addr = {vd_dotdot[5:0], hd_dotdot[4:0]};

output [3:0] cntM1, cntS1;
reg [3:0] cntS1, cntS10, cntM1, cntM10;
reg [27:0] clkCnt;

always @(posedge iCLK) //time counter
begin
	if (clkCnt == 28'd148499999)
		clkCnt <= 28'd0;
	else
		clkCnt <= clkCnt + 28'd1;
end

always @(posedge iCLK or negedge reset) //time counter
begin
	if (reset==1'b0)
	begin
		cntS1 <= 4'd0;
	end
	else
	begin
		if (clkCnt == 26'd0)
		begin
			if(cntS1==4'd9)
				cntS1 <= 4'd0;
			else
				cntS1 <= cntS1 + 4'd1;
		end
	end
end

always @(posedge iCLK or negedge reset)
begin
	if (reset == 1'b0)
		cntS10 <= 4'd0;
	else
	begin
		if (cntS1 == 4'd9 && clkCnt == 26'd0)
		begin 
			if (cntS10 == 4'd5)
				cntS10 <= 4'd0;
			else
				cntS10 <= cntS10 + 4'd1;
		end
		else
				cntS10 <= cntS10;
	end
end

always @(posedge iCLK or negedge reset)
begin 
	if (reset==1'b0)
			cntM1 <= 4'd0;
	else 
	begin
		if(cntS1 == 4'd9 && cntS10 == 4'd5 && clkCnt == 26'd0)
		begin 
			if (cntM1 == 4'd9)
				cntM1 <= 4'd0;
			else
				cntM1 <= cntM1 + 4'd1;
		end 
		else
				cntM1 <= cntM1;
	end
end

always @(posedge iCLK or negedge reset) //mswatch
begin
	if (reset == 1'b0)
		cntM10 <= 4'd0;
	else
	begin
		if (cntS1 == 4'd9 && cntS10 == 4'd5 && cntM1 == 4'd9 && clkCnt == 26'd0)
		begin
			if (cntM10 == 4'd5)
				cntM10 <= 4'd0;
			else
				cntM10 <= cntM10 + 4'd1;
		end
		else
				cntM10 <= cntM10;
	end
end

wire [2:0] x, y;
reg [13:0] score;

/*
reg mem_score;

always @(posedge iCLK or negedge reset)
begin
	if ((x==~x)||(y!=3'd0))
		mem_score <= 1'b1;
	else
		mem_score <= 1'b0;
end
*/
reg [25:0] scoreCnt;

always @(posedge iCLK or negedge reset) //score
begin
	if (reset == 1'b0)
		score <= 14'd0;
	else
	begin
		begin
			if (scoreCnt == 26'd29999999)
				scoreCnt <= 26'd0;
			else 
				scoreCnt <= scoreCnt + 26'd1;
		end
		begin
			if (scoreCnt == 26'd0)
				score <= (score + 8*x + 8*y);
		end
	end
end


reg [3:0] score1, score2, score3, score4;

always @(posedge iCLK)
begin
	score1 <= score/1000;
	score2 <= (score%1000)/100;
	score3 <= (score%100)/10;
	score4 <= score%10; 
end

always @(posedge iCLK or negedge reset) //sel
begin
	if (reset == 1'b0)
	begin
		sel_score <= 1'b0;
		sel_dotdot <= 1'b0;
	end
	else
	begin
	/*
		if ((VCNT >= tvs_score) && (VCNT < (tvs_score + 11'd64)) && (HCNT >= ths_score) && (HCNT < (ths_score + 12'd256))) // score(text)
			sel_score <= 1'b1;
	*/
		if ((VCNT >= tvs_dotdot) && (VCNT < (tvs_dotdot + 11'd64)) && (HCNT >= ths_dotdot) && (HCNT < (ths_dotdot + 12'd32))) // score(text)
			sel_dotdot <= 1'b1;
		else
		begin
			if ((VCNT >= tvs_number1) && (VCNT < (tvs_number1 + 11'd64)) && (HCNT >= ths_number1) && (HCNT < (ths_number1 + 12'd32))) // score(number)
			begin
				case (score1)
					4'd0 : sel_number1<=4'd0;
					4'd1 : sel_number1<=4'd1;
					4'd2 : sel_number1<=4'd2;
					4'd3 : sel_number1<=4'd3;
					4'd4 : sel_number1<=4'd4;
					4'd5 : sel_number1<=4'd5;
					4'd6 : sel_number1<=4'd6;
					4'd7 : sel_number1<=4'd7;
					4'd8 : sel_number1<=4'd8;
					4'd9 : sel_number1<=4'd9;
					default : sel_number1<= 4'd10;
				endcase
			end
			else if ((VCNT >= tvs_number2) && (VCNT < (tvs_number2 + 11'd64)) && (HCNT >= ths_number2) && (HCNT < (ths_number2 + 12'd32)))
			begin
				case (score2)
					4'd0 : sel_number2<= 4'd0;
					4'd1 : sel_number2<=4'd1;
					4'd2 : sel_number2<=4'd2;
					4'd3 : sel_number2<=4'd3;
					4'd4 : sel_number2<=4'd4;
					4'd5 : sel_number2<=4'd5;
					4'd6 : sel_number2<=4'd6;
					4'd7 : sel_number2<=4'd7;
					4'd8 : sel_number2<=4'd8;
					4'd9 : sel_number2<=4'd9;
					default : sel_number2<= 4'd10;
				endcase
			end
			else if ((VCNT >= tvs_number3) && (VCNT < (tvs_number3 + 11'd64)) && (HCNT >= ths_number3) && (HCNT < (ths_number3 + 12'd32)))
			begin
				case (score3)
					4'd0 : sel_number3<= 4'd0;
					4'd1 : sel_number3<=4'd1;
					4'd2 : sel_number3<=4'd2;
					4'd3 : sel_number3<=4'd3;
					4'd4 : sel_number3<=4'd4;
					4'd5 : sel_number3<=4'd5;
					4'd6 : sel_number3<=4'd6;
					4'd7 : sel_number3<=4'd7;
					4'd8 : sel_number3<=4'd8;
					4'd9 : sel_number3<=4'd9;
					default : sel_number3<= 4'd10;
				endcase
			end
			else if ((VCNT >= tvs_number4) && (VCNT < (tvs_number4 + 11'd64)) && (HCNT >= ths_number4) && (HCNT < (ths_number4 + 12'd32)))
			begin
				case (score4)
					4'd0 : sel_number4<= 4'd0;
					4'd1 : sel_number4<=4'd1;
					4'd2 : sel_number4<=4'd2;
					4'd3 : sel_number4<=4'd3;
					4'd4 : sel_number4<=4'd4;
					4'd5 : sel_number4<=4'd5;
					4'd6 : sel_number4<=4'd6;
					4'd7 : sel_number4<=4'd7;
					4'd8 : sel_number4<=4'd8;
					4'd9 : sel_number4<=4'd9;
					default : sel_number4<= 4'd10;
				endcase
			end
			else if ((VCNT >= tvs_time1) && (VCNT < (tvs_time1 + 11'd64)) && (HCNT >= ths_time1) && (HCNT < (tvs_time1 + 12'd32))) // time(number)
			begin
				case (cntM10)
					4'd0 : sel_time1<= 4'd0;
					4'd1 : sel_time1<=4'd1;
					4'd2 : sel_time1<=4'd2;
					4'd3 : sel_time1<=4'd3;
					4'd4 : sel_time1<=4'd4;
					4'd5 : sel_time1<=4'd5;
					default : sel_time1<= 4'd10;
				endcase
			end
			else if ((VCNT >= tvs_time2) && (VCNT < (tvs_time2 + 11'd64)) && (HCNT >= ths_time2) && (HCNT < (ths_time2 + 12'd32)))
			begin
				case (cntM1)
					4'd0 : sel_time2<= 4'd0;
					4'd1 : sel_time2<=4'd1;
					4'd2 : sel_time2<=4'd2;
					4'd3 : sel_time2<=4'd3;
					4'd4 : sel_time2<=4'd4;
					4'd5 : sel_time2<=4'd5;
					4'd6 : sel_time2<=4'd6;
					4'd7 : sel_time2<=4'd7;
					4'd8 : sel_time2<=4'd8;
					4'd9 : sel_time2<=4'd9;
					default : sel_time2<= 4'd10;
				endcase
			end
			else if ((VCNT >= tvs_time3) && (VCNT < (tvs_time3 + 11'd64)) && (HCNT >= ths_time3) && (HCNT < (ths_time3 + 12'd32)))
			begin
				case (cntS10)
					4'd0 : sel_time3<= 4'd0;
					4'd1 : sel_time3<=4'd1;
					4'd2 : sel_time3<=4'd2;
					4'd3 : sel_time3<=4'd3;
					4'd4 : sel_time3<=4'd4;
					4'd5 : sel_time3<=4'd5;
					default : sel_time3<= 4'd10;
				endcase
			end
			else if ((VCNT >= tvs_time4) && (VCNT < (tvs_time4 + 11'd64)) && (HCNT >= ths_time4) && (HCNT < (ths_time4 + 12'd32)))
			begin
				case (cntS1)
					4'd0 : sel_time4<= 4'd0;
					4'd1 : sel_time4<=4'd1;
					4'd2 : sel_time4<=4'd2;
					4'd3 : sel_time4<=4'd3;
					4'd4 : sel_time4<=4'd4;
					4'd5 : sel_time4<=4'd5;
					4'd6 : sel_time4<=4'd6;
					4'd7 : sel_time4<=4'd7;
					4'd8 : sel_time4<=4'd8;
					4'd9 : sel_time4<=4'd9;
					default : sel_time4<= 4'd10;
				endcase
			end
		end
	end
end

always@(posedge iCLK or negedge reset)
begin
if (reset ==1'b0)
	begin R <= 8'd0; G <= 8'd0; B <= 8'd0; end
else
begin
		begin
		/*
			if ((VCNT >= tvs_score) && (VCNT < (tvs_score + 11'd64)) && (HCNT >= ths_score) && (HCNT < (ths_score + 12'd256))) // score(text)
			begin
				case (sel_score)
					1'b0 : begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
					1'b1 :
						begin
							if (score_q == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (score_q == 2'b01)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else if (score_q == 2'b10)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end 
							else
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end 
							end
				endcase
			end
			*/
			if ((VCNT >= tvs_number1) && (VCNT < (tvs_number1 + 11'd64)) && (HCNT >= ths_number1) && (HCNT < (ths_number1 + 12'd32))) // score(number)
			begin
					case (sel_number1)
						4'd0 : 
							begin
								if (number0_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number0_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number0_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd1 : 
							begin
								if (number1_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number1_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number1_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd2 : 
							begin
								if (number2_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number2_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number2_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd3 : 
							begin
								if (number3_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number3_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number3_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd4 : 
							begin
								if (number4_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number4_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number4_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd5 : 
							begin
								if (number5_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number5_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number5_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd6 : 
							begin
								if (number6_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number6_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number6_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd7 : 
							begin
								if (number7_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number7_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number7_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd8 : 
							begin
								if (number8_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number8_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number8_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd9 : 
							begin
								if (number9_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number9_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number9_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						default : begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
					endcase
				end 
			else if ((VCNT >= tvs_number2) && (VCNT < (tvs_number2 + 11'd64)) && (HCNT >= ths_number2) && (HCNT < (ths_number2 + 12'd32)))
			begin
					case (sel_number2)
						4'd0 : 
							begin
								if (number0_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number0_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number0_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd1 : 
							begin
								if (number1_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number1_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number1_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd2 : 
							begin
								if (number2_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number2_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number2_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd3 : 
							begin
								if (number3_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number3_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number3_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd4 : 
							begin
								if (number4_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number4_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number4_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd5 : 
							begin
								if (number5_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number5_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number5_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd6 : 
							begin
								if (number6_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number6_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number6_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd7 : 
							begin
								if (number7_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number7_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number7_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd8 : 
							begin
								if (number8_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number8_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number8_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd9 : 
							begin
								if (number9_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number9_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (number9_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						default : begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
					endcase
				end
			else if ((VCNT >= tvs_number3) && (VCNT < (tvs_number3 + 11'd64)) && (HCNT >= ths_number3) && (HCNT < (ths_number3 + 12'd32)))
			begin
				case (sel_number3)
					4'd0 : 
						begin
							if (number0_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number0_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number0_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd1 : 
						begin
							if (number1_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number1_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number1_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd2 : 
						begin
							if (number2_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number2_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number2_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd3 : 
						begin
							if (number3_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number3_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number3_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd4 : 
						begin
							if (number4_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number4_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number4_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd5 : 
						begin
							if (number5_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number5_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number5_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd6 : 
						begin
							if (number6_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number6_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number6_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd7 : 
						begin
							if (number7_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number7_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number7_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd8 : 
						begin
							if (number8_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number8_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number8_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd9 : 
						begin
							if (number9_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number9_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number9_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					default : begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
				endcase
			end		
			else if ((VCNT >= tvs_number4) && (VCNT < (tvs_number4 + 11'd64)) && (HCNT >= ths_number4) && (HCNT < (ths_number4 + 12'd32)))
			begin
				case (sel_number4)
					4'd0 : 
						begin
							if (number0_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number0_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number0_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd1 : 
						begin
							if (number1_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number1_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number1_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd2 : 
						begin
							if (number2_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number2_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number2_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd3 : 
						begin
							if (number3_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number3_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number3_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd4 : 
						begin
							if (number4_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number4_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number4_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd5 : 
						begin
							if (number5_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number5_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number5_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd6 : 
						begin
							if (number6_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number6_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number6_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd7 : 
						begin
							if (number7_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number7_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number7_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd8 : 
						begin
							if (number8_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number8_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number8_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd9 : 
						begin
							if (number9_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number9_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (number9_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					default : begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
				endcase
			end
			else if ((VCNT >= tvs_time1) && (VCNT < (tvs_time1 + 11'd64)) && (HCNT >= ths_time1) && (HCNT < (ths_time1 + 12'd32))) // score(time)
			begin
					case (sel_time1)
						4'd0 : 
							begin
								if (time0_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time0_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time0_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd1 : 
							begin
								if (time1_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time1_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time1_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd2 : 
							begin
								if (time2_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time2_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time2_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd3 : 
							begin
								if (time3_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time3_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time3_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd4 : 
							begin
								if (time4_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time4_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time4_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd5 : 
							begin
								if (time5_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time5_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time5_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						default : begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
					endcase
				end 
			else if ((VCNT >= tvs_time2) && (VCNT < (tvs_time2 + 11'd64)) && (HCNT >= ths_time2) && (HCNT < (ths_time2 + 12'd32)))
			begin
					case (sel_time2)
						4'd0 : 
							begin
								if (time0_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time0_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time0_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end 
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd1 : 
							begin
								if (time1_q1 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time1_q1 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time1_q1 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end 
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd2 : 
							begin
								if (time2_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time2_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time2_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd3 : 
							begin
								if (time3_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time3_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time3_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd4 : 
							begin
								if (time4_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time4_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time4_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd5 : 
							begin
								if (time5_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time5_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time5_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd6 : 
							begin
								if (time6_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time6_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time6_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd7 : 
							begin
								if (time7_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time7_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time7_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd8 : 
							begin
								if (time8_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time8_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time8_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						4'd9 : 
							begin
								if (time9_q2 == 2'b00)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time9_q2 == 2'b01)
									begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
								else if (time9_q2 == 2'b10)
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
								else 
									begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							end
						default : begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
					endcase
				end
			else if ((VCNT >= tvs_dotdot) && (VCNT < (tvs_dotdot + 11'd64)) && (HCNT >= ths_dotdot) && (HCNT < (tvs_dotdot + 12'd32))) // time(time)
			begin
				case(sel_dotdot)
					1'b0 : begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
					1'b1 :
						begin
							if (dotdot_q == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (dotdot_q == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (dotdot_q == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
				endcase
			end
			else if ((VCNT >= tvs_time3) && (VCNT < (tvs_time3 + 11'd64)) && (HCNT >= ths_time3) && (HCNT < (ths_time3 + 12'd32)))
			begin
				case (sel_time3)
					4'd0 : 
						begin
							if (time0_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time0_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time0_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd1 : 
						begin
							if (time1_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time1_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time1_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd2 : 
						begin
							if (time2_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time2_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time2_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd3 : 
						begin
							if (time3_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time3_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time3_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd4 : 
						begin
							if (time4_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time4_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time4_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd5 : 
						begin
							if (time5_q3 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time5_q3 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time5_q3 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					default : begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
				endcase
			end		
			else if ((VCNT >= tvs_time4) && (VCNT < (tvs_time4 + 11'd64)) && (HCNT >= ths_time4) && (HCNT < (ths_time4 + 12'd32)))
			begin
				case (sel_time4)
					4'd0 : 
						begin
							if (time0_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time0_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time0_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd1 : 
						begin
							if (time1_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time1_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time1_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd2 : 
						begin
							if (time2_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time2_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time2_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd3 : 
						begin
							if (time3_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time3_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time3_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd4 : 
						begin
							if (time4_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time4_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time4_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd5 : 
						begin
							if (time5_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time5_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time5_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd6 : 
						begin
							if (time6_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time6_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time6_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd7 : 
						begin
							if (time7_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time7_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time7_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd8 : 
						begin
							if (time8_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time8_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time8_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					4'd9 : 
						begin
							if (time9_q4 == 2'b00)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time9_q4 == 2'b01)
								begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
							else if (time9_q4 == 2'b10)
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
							else 
								begin R <= 8'd64; G <= 8'd64; B <= 8'd64; end
						end
					default : begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
				endcase
				end
			else
				begin R <= 8'd255; G <= 8'd255; B <= 8'd255; end
		end
	end
end


score s1 (.address(score_addr), .clock(iCLK), .q(score_q));

number0 n10 (.address(number_addr1), .clock(iCLK), .q(number0_q1));
number1 n11 (.address(number_addr1), .clock(iCLK), .q(number1_q1));
number2 n12 (.address(number_addr1), .clock(iCLK), .q(number2_q1));
number3 n13 (.address(number_addr1), .clock(iCLK), .q(number3_q1));
number4 n14 (.address(number_addr1), .clock(iCLK), .q(number4_q1));
number5 n15 (.address(number_addr1), .clock(iCLK), .q(number5_q1));
number6 n16 (.address(number_addr1), .clock(iCLK), .q(number6_q1));
number7 n17 (.address(number_addr1), .clock(iCLK), .q(number7_q1));
number8 n18 (.address(number_addr1), .clock(iCLK), .q(number8_q1));
number9 n19 (.address(number_addr1), .clock(iCLK), .q(number9_q1));
number0 n20 (.address(number_addr2), .clock(iCLK), .q(number0_q2));
number1 n21 (.address(number_addr2), .clock(iCLK), .q(number1_q2));
number2 n22 (.address(number_addr2), .clock(iCLK), .q(number2_q2));
number3 n23 (.address(number_addr2), .clock(iCLK), .q(number3_q2));
number4 n24 (.address(number_addr2), .clock(iCLK), .q(number4_q2));
number5 n25 (.address(number_addr2), .clock(iCLK), .q(number5_q2));
number6 n26 (.address(number_addr2), .clock(iCLK), .q(number6_q2));
number7 n27 (.address(number_addr2), .clock(iCLK), .q(number7_q2));
number8 n28 (.address(number_addr2), .clock(iCLK), .q(number8_q2));
number9 n29 (.address(number_addr2), .clock(iCLK), .q(number9_q2));
number0 n30 (.address(number_addr3), .clock(iCLK), .q(number0_q3));
number1 n31 (.address(number_addr3), .clock(iCLK), .q(number1_q3));
number2 n32 (.address(number_addr3), .clock(iCLK), .q(number2_q3));
number3 n33 (.address(number_addr3), .clock(iCLK), .q(number3_q3));
number4 n34 (.address(number_addr3), .clock(iCLK), .q(number4_q3));
number5 n35 (.address(number_addr3), .clock(iCLK), .q(number5_q3));
number6 n36 (.address(number_addr3), .clock(iCLK), .q(number6_q3));
number7 n37 (.address(number_addr3), .clock(iCLK), .q(number7_q3));
number8 n38 (.address(number_addr3), .clock(iCLK), .q(number8_q3));
number9 n39 (.address(number_addr3), .clock(iCLK), .q(number9_q3));
number0 n40 (.address(number_addr4), .clock(iCLK), .q(number0_q4));
number1 n41 (.address(number_addr4), .clock(iCLK), .q(number1_q4));
number2 n42 (.address(number_addr4), .clock(iCLK), .q(number2_q4));
number3 n43 (.address(number_addr4), .clock(iCLK), .q(number3_q4));
number4 n44 (.address(number_addr4), .clock(iCLK), .q(number4_q4));
number5 n45 (.address(number_addr4), .clock(iCLK), .q(number5_q4));
number6 n46 (.address(number_addr4), .clock(iCLK), .q(number6_q4));
number7 n47 (.address(number_addr4), .clock(iCLK), .q(number7_q4));
number8 n48 (.address(number_addr4), .clock(iCLK), .q(number8_q4));
number9 n49 (.address(number_addr4), .clock(iCLK), .q(number9_q4));

dotdot d1 (.address(dotdot_addr), .clock(iCLK), .q(dotdot_q));

number0 m10 (.address(time_addr1), .clock(iCLK), .q(time0_q1));
number1 m11 (.address(time_addr1), .clock(iCLK), .q(time1_q1));
number2 m12 (.address(time_addr1), .clock(iCLK), .q(time2_q1));
number3 m13 (.address(time_addr1), .clock(iCLK), .q(time3_q1));
number4 m14 (.address(time_addr1), .clock(iCLK), .q(time4_q1));
number5 m15 (.address(time_addr1), .clock(iCLK), .q(time5_q1));
number0 m20 (.address(time_addr2), .clock(iCLK), .q(time0_q2));
number1 m21 (.address(time_addr2), .clock(iCLK), .q(time1_q2));
number2 m22 (.address(time_addr2), .clock(iCLK), .q(time2_q2));
number3 m23 (.address(time_addr2), .clock(iCLK), .q(time3_q2));
number4 m24 (.address(time_addr2), .clock(iCLK), .q(time4_q2));
number5 m25 (.address(time_addr2), .clock(iCLK), .q(time5_q2));
number6 m26 (.address(time_addr2), .clock(iCLK), .q(time6_q2));
number7 m27 (.address(time_addr2), .clock(iCLK), .q(time7_q2));
number8 m28 (.address(time_addr2), .clock(iCLK), .q(time8_q2));
number9 m29 (.address(time_addr2), .clock(iCLK), .q(time9_q2));
number0 s30 (.address(time_addr3), .clock(iCLK), .q(time0_q3));
number1 s31 (.address(time_addr3), .clock(iCLK), .q(time1_q3));
number2 s32 (.address(time_addr3), .clock(iCLK), .q(time2_q3));
number3 s33 (.address(time_addr3), .clock(iCLK), .q(time3_q3));
number4 s34 (.address(time_addr3), .clock(iCLK), .q(time4_q3));
number5 s35 (.address(time_addr3), .clock(iCLK), .q(time5_q3));
number0 s40 (.address(time_addr4), .clock(iCLK), .q(time0_q4));
number1 S41 (.address(time_addr4), .clock(iCLK), .q(time1_q4));
number2 s42 (.address(time_addr4), .clock(iCLK), .q(time2_q4));
number3 s43 (.address(time_addr4), .clock(iCLK), .q(time3_q4));
number4 s44 (.address(time_addr4), .clock(iCLK), .q(time4_q4));
number5 s45 (.address(time_addr4), .clock(iCLK), .q(time5_q4));
number6 s46 (.address(time_addr4), .clock(iCLK), .q(time6_q4));
number7 s47 (.address(time_addr4), .clock(iCLK), .q(time7_q4));
number8 s48 (.address(time_addr4), .clock(iCLK), .q(time8_q4));
number9 s49 (.address(time_addr4), .clock(iCLK), .q(time9_q4));




endmodule
