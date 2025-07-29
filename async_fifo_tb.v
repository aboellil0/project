// `timescale 1ns / 1ps

// module sunc_FIFO_tb ();
    
    
//     localparam w=32;
//     localparam d=8;
//     reg clk;
//     reg rst;
//     reg WR_EN;
//     reg [w-1:0] data_in;
//     reg RD_EN;
//     wire [w-1:0] data_out;
//     wire full;
//     wire empty;
    

//     // Instantiate the FIFO module
//     sunc_FIFO #(d, w) uut (
//         .clk(clk),
//         .rst(rst),
//         .WR_EN(WR_EN),
//         .data_in(data_in),
//         .RD_EN(RD_EN),
//         .data_out(data_out),
//         .full(full),
//         .empty(empty)
//     );

//     initial begin
//         clk = 0;
//         forever #5 clk = ~clk;
//     end

//     initial begin
//         $monitor("Time: %0t | WR_EN: %b | RD_EN: %b | Data In: %h  Full: %b | Empty: %b",
//                  $time, WR_EN, RD_EN, data_in , full, empty);
                 
//     end

//     initial begin
//         rst = 1;
//         WR_EN = 0;
//         RD_EN = 0;
//         data_in = 32'b00000000000000000000000000000000000000;

//         #10 rst = 0;
        
//         WR_EN = 1;
//         data_in = 32'b10101010101010101010101010101010; 
//         #10;
//         data_in = 32'b10101010101010101010101010101010; 
//         #10;
//         data_in = 32'b10101010101010101010101010101010; 
//         #10;
//         data_in = 32'b10101010101010101010101010101010; 
//         #10;
//         data_in = 32'b10101010101010101010101010101010; 
//         #10;
//         data_in = 32'b10101010101010101010101010101010; 
//         #10;
//         data_in = 32'b10101010101010101010101010101010; 
//         #10;
//         data_in = 32'b10101010101010101010101010101010; 
//         #10;
//         data_in = 32'b10101010101010101010101010101010; 
//         #10;
//         data_in = 32'b10101010101010101010101010101010; 
//         #10;

//         WR_EN = 0; // Stop writing
//         RD_EN = 1; // Start reading
//         $display("Data Out: %h", data_out);
//         #10;
//         $display("Data Out: %h", data_out);
//         #10;
//         $display("Data Out: %h", data_out);
//         #10;
//         $display("Data Out: %h", data_out);
//         #10;
//         $display("Data Out: %h", data_out);
//         #10;
//         $display("Data Out: %h", data_out);
//         #10;
//         $display("Data Out: %h", data_out);
//         #10;
//         $display("Data Out: %h", data_out);
//         #10;
//         $display("Data Out: %h", data_out);


//         #10;
//         $finish;
//     end

// endmodule



module asynch_fifo_tb ();
    
    localparam WIDTH = 32;
    localparam DEPTH = 8;
    reg w_clk, r_clk;
    reg w_rst, r_rst;
    reg WR_EN;
    reg [WIDTH-1:0] data_in;
    reg RD_EN;
    wire [WIDTH-1:0] data_out;
    wire full;
    wire empty;

    // Instantiate the FIFO module
    asynch_fifo #(DEPTH, WIDTH) uut (
        .w_clk(w_clk),
        .r_clk(r_clk),
        .w_rst(w_rst),
        .r_rst(r_rst),
        .WR_EN(WR_EN),
        .data_in(data_in),
        .RD_EN(RD_EN),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    initial begin
        w_clk = 0; r_clk = 0;
        forever #5 w_clk = ~w_clk; #5 r_clk = ~r_clk; // Clock toggling
    end

    initial begin
        $monitor("Time: %0t | WR_EN: %b | RD_EN: %b | Data In: %h | Data Out: %h | Full: %b | Empty: %b",
                 $time, WR_EN, RD_EN, data_in, data_out, full, empty);
                 
        w_rst = 1; r_rst = 1; // Reset both clocks
        WR_EN = 0; RD_EN = 0; 
        data_in = 32'b0;

        #10 w_rst = 0; r_rst = 0; // Release reset
        
        // Write data into FIFO
        WR_EN = 1;
        repeat (10) begin
            data_in = $random; // Random data input
            #10; // Wait for a clock cycle
        end
        
        WR_EN = 0; // Stop writing
        RD_EN = 1; // Start reading
        
        repeat (10) begin
            #10; // Wait for a clock cycle to read data
            $display("Data Out: %h", data_out);
        end
        
        RD_EN = 0; // Stop reading
        #10;
        
        $finish; // End simulation
    end
endmodule