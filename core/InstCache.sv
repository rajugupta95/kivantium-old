`default_nettype none

module InstCache(
  input wire clk,
  input wire [31:0] addr,
  output logic [31:0] inst0
);
  (* ram_style = "block" *)
  logic [31:0] memory[1023:0];
  int i;
  initial begin
    for(i=0; i<1024; i++) begin
      memory[i] = 32'b0;
    end
/*
addi $x1, $zero, 1
sw   $x1, 1($x1)
lw   $x2, 1($x1)
addi $x3, $x2, 1
beq  $x0, $x3, end
addi $x3, $x3, 1
end:
jal  $x0 end
*/
    memory[0] = 32'b00000000000100000000000010010011;
    memory[1] = 32'b00000000000100001010000010100011;
    memory[2] = 32'b00000000000100001010000100000011;
    memory[3] = 32'b00000000000100010000000110010011;
    memory[4] = 32'b00000000001100000000010001100011;
    memory[5] = 32'b00000000000100011000000110010011;
    memory[6] = 32'b00000000000000000000000001101111;
  end
  
  always @(posedge clk) begin
    inst0 <= memory[addr[11:2]];
  end
endmodule

`default_nettype wire