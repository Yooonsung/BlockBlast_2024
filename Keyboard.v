
`timescale 1us/1ns
module Keyboard(key, ASCII1, ASCII2, ps2Clk, ps2Dat);
input		key;
input	[7:0]	ASCII1, ASCII2;
output		ps2Clk, ps2Dat;

wire		key;
wire	[7:0]	ASCII1, ASCII2;

reg	[7:0]	psCnt; // Internal Counter
reg		iClk; // Internal Clock
reg		iKey, i2Key;
reg		ps2Dat;

initial
begin
	iClk <= 1'b0;
	psCnt <= 7'h7f;
	ps2Dat <= 1'b1;
end

always #50 iClk <= ~iClk;

always @(posedge iClk)
begin
	iKey <= key;
	i2Key <= iKey;
end

wire		riseKey;

assign	riseKey = iKey & ~i2Key;


always @(posedge iClk)
begin
	if (riseKey)
		psCnt <= 7'd0;
	else
	begin
		if (ASCII2 !== 8'hF0)
			if (psCnt == 8'd63 && key == 1'b1)
				psCnt <= 8'd0;
			else if (psCnt > 8'd140)
				psCnt <= 8'hff;
			else
				psCnt <= psCnt + 8'd1;
		else
			if (psCnt == 8'd31)
				if (key == 1'b1)
					psCnt <= 8'd0;
				else 
					psCnt <= 8'd64;
			else if (psCnt > 8'd110)
				psCnt <= 8'hff;
			else
				psCnt <= psCnt + 8'd1;

	end
end

assign ps2Clk = (psCnt[4:0] > 5'd0 && psCnt[4:0] < 5'd12) ? iClk : 1'b1;

always @(posedge iClk)
begin
	case (psCnt)
	8'd0: ps2Dat <= 1'b0;
	8'd1: ps2Dat <= ASCII1[0];
	8'd2: ps2Dat <= ASCII1[1];
	8'd3: ps2Dat <= ASCII1[2];
	8'd4: ps2Dat <= ASCII1[3];
	8'd5: ps2Dat <= ASCII1[4];
	8'd6: ps2Dat <= ASCII1[5];
	8'd7: ps2Dat <= ASCII1[6];
	8'd8: ps2Dat <= ASCII1[7];
	8'd9: ps2Dat <= 1'b1;
	8'd10: ps2Dat <= 1'b1;	
	8'd32: ps2Dat <= 1'b0;
	8'd33: ps2Dat <= ASCII2[0];
	8'd34: ps2Dat <= ASCII2[1];
	8'd35: ps2Dat <= ASCII2[2];
	8'd36: ps2Dat <= ASCII2[3];
	8'd37: ps2Dat <= ASCII2[4];
	8'd38: ps2Dat <= ASCII2[5];
	8'd39: ps2Dat <= ASCII2[6];
	8'd40: ps2Dat <= ASCII2[7];
	8'd41: ps2Dat <= 1'b1;
	8'd42: ps2Dat <= 1'b1;	
	8'd64: ps2Dat <= 1'b0;
	8'd65: ps2Dat <= 1'b0;
	8'd66: ps2Dat <= 1'b0;
	8'd67: ps2Dat <= 1'b0;
	8'd68: ps2Dat <= 1'b0;
	8'd69: ps2Dat <= 1'b1;
	8'd70: ps2Dat <= 1'b1;
	8'd71: ps2Dat <= 1'b1;
	8'd72: ps2Dat <= 1'b1;
	8'd73: ps2Dat <= 1'b1;
	8'd74: ps2Dat <= 1'b1;
	8'd96: ps2Dat <= 1'b0;
	8'd97: ps2Dat <= ASCII1[0];
	8'd98: ps2Dat <= ASCII1[1];
	8'd99: ps2Dat <= ASCII1[2];
	8'd100: ps2Dat <= ASCII1[3];
	8'd101: ps2Dat <= ASCII1[4];
	8'd102: ps2Dat <= ASCII1[5];
	8'd103: ps2Dat <= ASCII1[6];
	8'd104: ps2Dat <= ASCII1[7];
	8'd105: ps2Dat <= 1'b1;
	8'd106: ps2Dat <= 1'b1;	
	8'd128: ps2Dat <= 1'b0;
	8'd129: ps2Dat <= ASCII2[0];
	8'd130: ps2Dat <= ASCII2[1];
	8'd131: ps2Dat <= ASCII2[2];
	8'd132: ps2Dat <= ASCII2[3];
	8'd133: ps2Dat <= ASCII2[4];
	8'd134: ps2Dat <= ASCII2[5];
	8'd135: ps2Dat <= ASCII2[6];
	8'd136: ps2Dat <= ASCII2[7];
	8'd137: ps2Dat <= 1'b1;
	8'd138: ps2Dat <= 1'b1;	
	default: ps2Dat <= 1'b1;
	endcase
end

endmodule
