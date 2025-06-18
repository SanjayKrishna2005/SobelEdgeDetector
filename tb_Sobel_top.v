`timescale 1ns/1ps
module sobel_tb_modular;

    reg clk = 0;
    reg reset = 1;
    reg data_valid = 0;
    reg [7:0] pixel_in;
    wire [7:0] edge_out;
    wire edge_valid;

    integer infile, outfile;
    reg [7:0] gray;
    integer pixel_count = 0;

    parameter IMG_WIDTH = 256;
    parameter TOTAL_PIXELS = IMG_WIDTH * IMG_WIDTH;

    // DUT
    sobel_top #(.IMG_WIDTH(IMG_WIDTH)) uut (
        .clk(clk),
        .rst(reset),
        .pixel_in(pixel_in),
        .data_valid(data_valid),
        .edge_out(edge_out),
        .edge_valid(edge_valid)
    );

    // Clock generation
    always #5 clk = ~clk;
    always @(posedge clk) begin
    if (data_valid) begin
        $display("Pixel #%0d = %0d (0x%0h)", pixel_count, pixel_in, pixel_in);
        end
    end
    initial begin
        $display("[SIM] Starting Modular Sobel TB");

        infile = $fopen("pixel_data_Tiger.csv", "r");
        if (infile == 0) begin
            $display("ERROR: Cannot open image_data.bin");
            $finish;
        end

        outfile = $fopen("sobel_output_mod_Tiger.csv", "w");
        if (outfile == 0) begin
            $display("ERROR: Cannot open sobel_output.csv");
            $finish;
        end
        $fwrite(outfile, "Edge\n");

        // Reset
        #20 reset = 0;

        // Stream pixels
         while (pixel_count < TOTAL_PIXELS && !$feof(infile)) begin
            $fscanf(infile, "%d\n", gray);
            $display("gray = %0d", gray);   // New line here
            pixel_in = gray;    
    
            data_valid = 1;
            @(posedge clk);
            data_valid = 0;
        
            if (edge_valid)
                $fwrite(outfile, "%0d\n", edge_out);
            else
                $fwrite(outfile, "0\n");
        
            $display("Pixel #%0d = %0d", pixel_count, pixel_in);
            pixel_count = pixel_count + 1;
            @(posedge clk);
        end 
    
    
            $fclose(infile);
            $fclose(outfile);
            $display("✅ DONE: %0d pixels processed", pixel_count);
            $finish;
        end
endmodule