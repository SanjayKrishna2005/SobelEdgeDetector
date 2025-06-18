module pixel_window_generator #(
    parameter IMG_WIDTH = 256
)(
    input wire clk,
    input wire rst,
    input wire [7:0] pixel_in,
    input wire data_valid,
    output reg [7:0] Z1, Z2, Z3,
                    Z4, Z5, Z6,
                    Z7, Z8, Z9,

    output reg valid_data,
    output reg black_data
);
 
    // 2 line buffers
    reg [7:0] line1 [0:IMG_WIDTH-1];
    reg [7:0] line2 [0:IMG_WIDTH-1];

    // 3×3 window buffer
    reg [7:0] window [0:8];

    integer col, row;

    initial begin
        col = 0;
        row = 0;
        valid_data = 0;
        black_data = 0;
    end

    always @(posedge clk) begin
        if (rst) begin
            col <= 0;
            row <= 0;
            valid_data <= 0;
            black_data <= 0;
        end else if (data_valid) begin
            // Update line buffers
            line2[col] <= line1[col];
            line1[col] <= pixel_in;

            // Slide window (identical logic to your sobel)
            window[0] <= window[1];
            window[1] <= window[2];
            window[2] <= line2[col];

            window[3] <= window[4];
            window[4] <= window[5];
            window[5] <= line1[col];

            window[6] <= window[7];
            window[7] <= window[8];
            window[8] <= pixel_in;

            // Assign window outputs
            Z1 <= window[0]; Z2 <= window[1]; Z3 <= window[2];
            Z4 <= window[3]; Z5 <= window[4]; Z6 <= window[5];
            Z7 <= window[6]; Z8 <= window[7]; Z9 <= window[8];
            // Valid pixel position for convolution
            valid_data <= (row >= 2 && col >= 2);
            black_data <= (row == 0 || row == IMG_WIDTH-1 || col == 0 || col == IMG_WIDTH-1);

            // Update col/row
            if (col == IMG_WIDTH - 1) begin
                col <= 0;
                row <= row + 1;
            end else begin
                col <= col + 1;
            end
        end else begin
            valid_data <= 0;
            black_data <= 0;
        end
    end
endmodule
