
module RxKB(PS_CLK, PS_DAT, CLK, RESET, NewKB, KB_DAT);
input 		PS_CLK, PS_DAT, CLK, RESET;
output 		NewKB;
output 	[7:0] 	KB_DAT;

reg	[3:0]	psCnt;
reg	[7:0]	kbShift, KB_DAT;
reg		NewKB1, NewKB1D1, NewKB1D2;
wire		NewKB2, NewKB;
reg		validDat;

// PS_CLK & PS_DAT Sampling at CLK
reg		sPSCLK, sPSCLKD1, sPSDAT;

always @(posedge CLK)
begin
	sPSCLK <= PS_CLK;
	sPSCLKD1 <= sPSCLK;
	sPSDAT <= PS_DAT;
end

wire negPSCLK;

assign negPSCLK = ~sPSCLK & sPSCLKD1;


always @(posedge CLK or negedge RESET)
begin
	if (RESET == 1'b0)
		psCnt <= 4'd0;
	else if (negPSCLK == 1'b1)
	begin
		if (psCnt >= 4'd10)
			psCnt <= 4'd0;
		else
			psCnt <= psCnt + 4'd1;
	end
end

always @(posedge CLK or negedge RESET)
begin
	if (RESET == 1'b0)
		kbShift <= 8'd0;
	else if (negPSCLK == 1'b1)
		kbShift <= {sPSDAT, kbShift[7:1]};
end

always @(posedge CLK)
begin
	if (negPSCLK == 1'b1 && psCnt == 4'd9)
		KB_DAT <= kbShift;
end

always @(posedge CLK)
begin
	if (negPSCLK == 1'b1)
	begin
		if (psCnt == 4'd9)
			NewKB1 <= 1'b1;
		else
			NewKB1 <= 1'b0;
	end
end

always @(posedge CLK)
begin
	NewKB1D1 <= NewKB1;
	NewKB1D2 <= NewKB1D1;
end

assign NewKB2 = NewKB1D1 & ~NewKB1D2;

always @(posedge CLK or negedge RESET)
begin
	if (RESET == 1'b0)
		validDat <= 1'b1;
	else if (NewKB2 == 1'b1)
		if (KB_DAT == 8'hf0)
			validDat <= 1'b0;
		else if (KB_DAT == 8'hE0)
			validDat <= validDat;
		else
			validDat <= 1'b1;
end

assign NewKB = NewKB2 & validDat;
endmodule
