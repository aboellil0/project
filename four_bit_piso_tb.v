

module four_bit_piso_tb;

    reg [3:0] in;
    reg clk, load;
    wire out;

    // Instantiate the four_bit_piso module
    four_bit_piso uut (
        .in(in),
        .clk(clk),
        .load(load),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test procedure
    initial begin
        // Initialize inputs
        in = 4'b0000;
        load = 0;

        // Load data into PISO
        #10 in = 4'b1010; load = 1; // Load data on load signal
        #10 load = 0; // Clear load signal

        // Shift data out
        repeat (4) begin
            #10; // Wait for clock edge
            $display("Output: %b", out); // Display output
        end

        // Finish simulation
        $finish;
    end