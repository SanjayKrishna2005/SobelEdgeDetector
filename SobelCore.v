module sobel_core (
    input wire [7:0] pixel_in,
    input wire valid_data, black_data,
    input wire [7:0] Z1, Z2, Z3, Z4, Z5, Z6, Z7, Z8, Z9,
    output reg [7:0] pixel_data_out
); 
    
    wire [15:0] P1,P2,P3,P4,P5,P6,P7,P8,P9;
    integer gx,gy,g;
     
    //PARTIAL PRODUCTS (DISCARDED THE MULTIPLIERS HAVING 0 AS A MULTIPLICAND TO REDUCE THE AREA)
    AppMul_8bit Mul1(P1,8'd1,Z1);
    AppMul_8bit Mul2(P2,8'd2,Z2);
    AppMul_8bit Mul3(P3,8'd1,Z3);
    AppMul_8bit Mul4(P4,8'd2,Z4);
    AppMul_8bit Mul5(P6,8'd2,Z6);
    AppMul_8bit Mul6(P7,8'd1,Z7);
    AppMul_8bit Mul7(P8,8'd2,Z8);
    AppMul_8bit Mul8(P9,8'd1,Z9);

    always@(*) begin
        if(valid_data) begin
            // CONVOLUTION OF X-AXIS
            gx = -P1+ P3 - P4 + P6 - P7 + P9;
            //CONVOLUTION OF Y-AXIS
            gy =  P1 + P2 + P3 - P7 - P8 - P9;
            // ADDING THE ABSOLUTE OF GX AND GY
            g = (gx < 0 ? -gx : gx) + (gy < 0 ? -gy : gy);
            //THRESHOLD COMPARATOR WHICH ASSIGNS THE PIXEL INTENSITY FOR EDGE DETECTION
            if (g > 255) g = 255;
            pixel_data_out <= g[7:0];
        end
    end
endmodule

