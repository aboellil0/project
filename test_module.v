module test_module;
    reg a, b;
    wire sum, carry;
    
    // Simple half adder
    assign sum = a ^ b;
    assign carry = a & b;
    
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, test_module);
        
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        
        $display("Simulation finished");
        $finish;
    end
endmodule