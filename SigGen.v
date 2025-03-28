module SigGen(iCLK, reset, HCNT, VCNT, blank_n, sync_n, hsync, vsync);

input iCLK, reset , HCNT, VCNT;
output blank_n, sync_n, hsync, vsync;

wire iCLK; // iCLK : inner variable
wire [11:0] HCNT;
wire [10:0] VCNT;

reg  hblank, vblank, hsync, vsync, blank_n, sync_n;

parameter sync_h = 12'd44;
parameter bp_h = 12'd148;
parameter active_h = 12'd1920;
parameter total_h = 12'd2200;
parameter fp_h = 12'd88;
parameter sync_v = 11'd5;
parameter bp_v = 11'd36;
parameter active_v = 11'd1080;
parameter total_v = 11'd1125;
parameter fp_v = 11'd4;

always @(posedge iCLK or negedge reset)
begin
   if (reset == 1'd0)
      hblank <= 1'b0;
   else if (HCNT < (active_h-12'd1)||(HCNT == total_h-12'd1))
      hblank <= 1'b1;
   else
      hblank <= 1'b0;
end

always @(posedge iCLK or negedge reset)
begin
   if (reset == 1'd0)
      vblank <= 1'b0;
   else
      begin
      if (VCNT < active_v-11'd1)
         vblank <= 1'b1;
      else if (VCNT==active_v-11'd1 && HCNT < total_h-12'd1)
         vblank <= 1'b1;
      else if (VCNT== total_v-11'd1 && HCNT == total_h-12'd1)
         vblank <= 1'b1;
      else
         vblank <= 1'b0;
      end
end


always @(posedge iCLK or negedge reset)
begin
   if (reset == 1'b0)
      hsync <= 1'b1;
   else
      begin
      if (HCNT == (active_h + bp_h -12'd1))
         hsync <= 1'b0;
      else if (HCNT == (active_h + bp_h + sync_h - 12'd1))
         hsync <= 1'b1;
      else
         hsync <= hsync;
      end
end

always @(posedge iCLK or negedge reset)
begin
   if (reset == 1'b0)
      vsync <= 1'b1;
   else
      begin
      if (VCNT == (active_v + bp_v - 11'd1)&& HCNT == total_h-12'd1)
         vsync <= 1'b0;
      else if (VCNT == (active_v + bp_v + sync_v - 11'd1)&& HCNT == total_h-12'd1)
         vsync <= 1'b1;
      else
         vsync <= vsync;
      end
end


always @(hblank or vblank or hsync or vsync)
begin
   blank_n <= (hblank & vblank);
   sync_n <= (hsync & vsync);
end

endmodule
