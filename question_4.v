// 4. Given Seq1 = 1011 and Seq2 = 0011, access the first 2 leftmost bits from Seq1 and the last 2 bits 
// from Seq2. Perform an AND operation on these segments, then concatenate the result with Seq3 = 
// 1010. Finally, extend the most significant bit (MSB) to achieve a final output width of 8 bits. 
// Note: Use the format [MSB: LSB] for the vector. 

module moduleName (
    input [3:0] seq1,seq2,seq3,
    output [7:0] out
);
    assign [1:0] left_seq1 = seq1[3:2]; 
    assign [1:0] right_seq2 = seq2[1:0];
    assign [1:0] and_result = left_seq1 & right_seq2;  

    assign [5:0] concatenate_result = {and_result, seq3}; //6
    assign out = {{2*{concatenate_result[5]}}, concatenate_result}; 
endmodule