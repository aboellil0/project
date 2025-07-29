

module insruction_memory_tb ();
    reg [31:0] PC;
    wire [31:0] Instr;

    // Instantiate the instruction memory module
    insruction_memory uut (
        .PC(PC),
        .Instr(Instr)
    );

    initial begin
        
        PC = 32'd18; 

        #10;

        // Check the output
        if (Instr == 32'h00000083) begin
            $display("Test passed: Instr = %h", Instr);
        end else begin
            $display("Test failed: Instr = %h", Instr);
        end

        $finish;
    end
endmodule