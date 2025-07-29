module asynch_fifo #(parameter DEPTH = 64, WIDTH = 32) (
    input w_clk,r_clk,
    input r_rst,w_rst,
    input WR_EN,
    input [WIDTH-1:0] data_in,
    input RD_EN,
    output reg [WIDTH-1:0] data_out,
    output full,
    output empty
);
    localparam ptr_width = $clog2(DEPTH);
    reg [WIDTH-1:0] memory_array [0:DEPTH-1];
    reg [ptr_width:0] write_ptr;
    reg [ptr_width:0] read_ptr;
    
    wire [ptr_width:0] w_ptr_gray, r_ptr_gray;
    reg [ptr_width:0] w_ptr_ff_1, r_ptr_ff_1,w_ptr_ff_2, r_ptr_ff_2;
    reg [ptr_width:0] w_ptr_out, r_ptr_out;


    assign empty = (w_ptr_out == read_ptr);
    assign full = (write_ptr[ptr_width-1:0] == r_ptr_out[ptr_width-1:0]) && (write_ptr[ptr_width] != r_ptr_out[ptr_width]);


    binary_to_graycode #(ptr_width+1) w_ptr_bin_to_gray (
                .binary_in(write_ptr),
                .gray_out(w_ptr_gray)
            );

    gray_to_binary #(ptr_width+1) r_ptr_gray_to_bin (
                .gray_in(r_ptr_ff_2),
                .binary_out(r_ptr_out)
            );

    always @(posedge r_clk or posedge r_rst) begin
        if (r_rst) begin
            w_ptr_ff_1 <=0;
            w_ptr_ff_2 <=0;
        end else begin
            w_ptr_ff_1 <= w_ptr_gray;
            w_ptr_ff_2 <= w_ptr_ff_1;
        end
    end

    binary_to_graycode #(ptr_width+1) r_ptr_bin_to_gray (
                .binary_in(read_ptr),
                .gray_out(r_ptr_gray)
            );

    gray_to_binary #(ptr_width+1) w_ptr_gray_to_bin (
                .gray_in(w_ptr_ff_2),
                .binary_out(w_ptr_out)
            );
    always @(posedge w_clk or posedge w_rst) begin
        if (w_rst) begin
            r_ptr_ff_1 <=0;
            r_ptr_ff_2 <=0;
        end else begin
            r_ptr_ff_1 <= r_ptr_gray;
            r_ptr_ff_2 <= r_ptr_ff_1;
        end
    end

    always @(posedge w_clk or posedge w_rst) begin
        if (w_rst) begin
            w_ptr_out <= 0;
            r_ptr_out <= 0;
            write_ptr <= 0;
            read_ptr <= 0;
        end else if (WR_EN && !full) begin
            memory_array[w_ptr_out] <= data_in;
            w_ptr_out <= w_ptr_out + 1;
        end 
    end

    always @(posedge r_clk or posedge r_rst) begin
        if (r_rst) begin
            write_ptr <= 0;
            r_ptr_out <= 0;
            write_ptr <= 0;
            read_ptr <= 0;
        end else if (RD_EN && !empty) begin
            data_out <= memory_array[r_ptr_out];
            r_ptr_out <= r_ptr_out + 1;
        end
    end

endmodule