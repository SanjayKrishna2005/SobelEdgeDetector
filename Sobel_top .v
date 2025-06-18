module sobel_top #(
    parameter IMG_WIDTH = 256
)(
    input clk,
    input rst,
    input [7:0] pixel_in,
    input data_valid,
    output [7:0] edge_out,
    output edge_valid
);

    wire [7:0] Z1, Z2, Z3, Z4, Z5, Z6, Z7, Z8, Z9;
    wire valid_data, black_data;

    pixel_window_generator #(
        .IMG_WIDTH(IMG_WIDTH)
    ) window_gen (
        .clk(clk),
        .rst(rst),
        .pixel_in(pixel_in),
        .data_valid(data_valid),
        .Z1(Z1), .Z2(Z2), .Z3(Z3),
        .Z4(Z4), .Z5(Z5), .Z6(Z6),
        .Z7(Z7), .Z8(Z8), .Z9(Z9),
        .valid_data(valid_data),
        .black_data(black_data)
    );

    sobel_core sobel_core_inst (
        .valid_data(valid_data),
        .black_data(black_data),
        .Z1(Z1), .Z2(Z2), .Z3(Z3),
        .Z4(Z4), .Z5(Z5), .Z6(Z6),
        .Z7(Z7), .Z8(Z8), .Z9(Z9),
        .pixel_data_out(edge_out)
    );

    // edge_valid = valid_data (except border)
    assign edge_valid = valid_data;

endmodule