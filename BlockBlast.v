module BlockBlast (
    input CLK, reset, ps2Clk, ps2Dat,
    output blank_n, sync_n, CLKO,
    output [7:0] R, G, B,
    output hsync, vsync, led
);

    // 내부 신호 정의
    wire [7:0] R1, G1, B1, R2, G2, B2, R3, G3, B3;
    wire [2:0] x, y;
	 wire [3:0] cntM1, cntS1;
    reg [7:0] R_reg, G_reg, B_reg; // 내부 레지스터 정의
    wire iCLK;
    wire [11:0] HCNT; // 가로 카운트
    wire [10:0] VCNT; // 세로 카운트
    reg led_reg; // 내부 레지스터 정의
    wire led1, led2;

    // 선언되지 않았던 신호들 정의
    wire M_S_1, M_S_2, M_S_3;
    wire mem1, mem2, mem3;

    // 클럭 생성기 인스턴스
    ClkGen u1 (
        .inclk0(CLK), 
        .c0(iCLK)
    );

    // 신호 생성기 인스턴스
    SigGen u2 (
        .iCLK(iCLK),
        .reset(reset),
        .HCNT(HCNT),
        .VCNT(VCNT),
        .blank_n(blank_n),
        .sync_n(sync_n),
        .hsync(hsync),
        .vsync(vsync)
    );

    // 카운터 모듈 인스턴스
    HVCNT u3 (
        .iCLK(iCLK),
        .reset(reset),
        .HCNT(HCNT),
        .VCNT(VCNT)
    );

    // 블록 설정 모듈 인스턴스
    block_choice u4 (
        .iCLK(iCLK),
        .reset(reset),
        .HCNT(HCNT),
        .VCNT(VCNT),
        .R(R1),
        .G(G1),
        .B(B1),
        .ps2Clk(ps2Clk),
        .ps2Dat(ps2Dat),
        .led(led1),
        .x(x),
		  .y(y),
		  .cntM1(cntM1),
		  .cntS1(cntS1)
    );

    // 다른 블록 설정 모듈 인스턴스
    block_set u5 (
        .iCLK(iCLK),
        .reset(reset),
        .HCNT(HCNT),
        .VCNT(VCNT),
        .R(R2),
        .G(G2),
        .B(B2),
        .ps2Clk(ps2Clk),
        .ps2Dat(ps2Dat),
        .led(led2), 
        .M_S_1(M_S_1), 
        .M_S_2(M_S_2), 
        .M_S_3(M_S_3),
        .mem1(mem1), 
        .mem2(mem2), 
        .mem3(mem3)
    );

    // 점수 및 시간 모듈 인스턴스
    scoretime u6 (
        .iCLK(iCLK),
        .reset(reset),
        .HCNT(HCNT),
        .VCNT(VCNT),
        .R(R3),
        .G(G3),
        .B(B3),
		  .x(x),
		  .y(y),
		  .cntM1(cntM1),
		  .cntS1(cntS1)
    );
	 

    // RGB 및 LED 출력 선택
    always @(posedge iCLK or negedge reset)
    begin
        if (!reset)
        begin
            R_reg <= 8'd0;
            G_reg <= 8'd0;
            B_reg <= 8'd0;
            led_reg <= 1'b0;
        end
        else if (HCNT < 12'd1050)
        begin
            R_reg <= R1;
            G_reg <= G1;
            B_reg <= B1;
            led_reg <= led1;
        end
        else if ((HCNT < 12'd1400) && (HCNT >= 12'd1050))
        begin
            R_reg <= R2;
            G_reg <= G2;
            B_reg <= B2;
            led_reg <= led2;
        end
        else
        begin
            R_reg <= R3;
            G_reg <= G3;
            B_reg <= B3;
        end
    end

    // 출력 클럭 연결
    assign CLKO = iCLK;

    // 출력 신호 할당
    assign R = R_reg;
    assign G = G_reg;
    assign B = B_reg;
    assign led = led_reg;

endmodule
