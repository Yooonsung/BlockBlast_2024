
module HVCNT(reset, iCLK, HCNT, VCNT);

input iCLK, reset;
output [11:0] HCNT;
output [10:0] VCNT;

wire iCLK, reset; // iCLK : inner variable
reg [11:0] HCNT;
reg [10:0] VCNT;

parameter sync_h = 12'd44;
parameter bp_h = 12'd148;
parameter active_h = 12'd1920;
parameter total_h = 12'd2200;
parameter fp_h = 12'd88;
parameter sync_v = 12'd5;
parameter bp_v = 12'd36;
parameter active_v = 12'd1080;
parameter total_v = 12'd1125;
parameter fp_v = 12'd4;

always @(posedge iCLK or negedge reset)
begin
   if (reset == 1'd0)
      HCNT <= 12'd0;
   else
   begin
   if (HCNT == (total_h -12'd1))
      HCNT <= 12'd0;
   else
      HCNT <= HCNT + 12'd1;
   end
end

always @ (posedge iCLK or negedge reset)
begin
   if (reset == 1'd0)
      VCNT <= 11'd0;
   else
   begin
   if (HCNT == (total_h - 12'd1))
      begin
             if (VCNT == (total_v-11'd1))
         VCNT <= 11'd0;
      else
         VCNT <= VCNT + 11'd1;
         end
      end
end

endmodule
