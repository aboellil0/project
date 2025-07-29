module full_adder (
    input a,b,
    input Cin,
    output sum, Cout
);
    wire temp1,temp2,temp3;
    half_adder ha1(.a(a),.b(b),.sum(temp1),.cout(temp2));
    half_adder ha2(.a(temp2),.b(Cin), .sum(temp3), .cout(Cout));
    assign Cout = temp2 | temp3;
endmodule