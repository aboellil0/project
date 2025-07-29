`timescale 10ps/1ps

module full_adder_tb (
);
    reg a, b, Cin;
    reg sum, Cout;
    full_adder uut (
        .a(a),
        .b(b),
        .Cin(Cin),
        .sum(sum),
        .Cout(Cout)
    );
    initial begin
        $display("Time: %0t | a: %b | b: %b | Cin: %b | Sum: %b | Cout: %b", 
                 $time, a, b, Cin, sum, Cout);
    end 
    initial begin
        // Test case 1
        a = 0; b = 0; Cin = 0;
        #10;
        
        // Test case 2
        a = 0; b = 0; Cin = 1;
        #11;

        // Test case 3
        a = 0; b = 1; Cin = 0;
        #12;

        // Test case 4
        a = 0; b = 1; Cin = 1;
        #13;

        // Test case 5
        a = 1; b = 0; Cin = 0;
        #14;

        // Test case 6
        a = 1; b = 0; Cin = 1;
        #15;

        // Test case 7
        a = 1; b = 1; Cin = 0;
        #16;

        // Test case 8
        a = 1; b = 1; Cin = 1;
        #17;

        $finish;
    end
endmodule