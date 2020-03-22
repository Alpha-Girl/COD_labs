module tb();
reg [2:0] a,b;
reg [1:0] fun;
wire s;
wire [2:0] y;   
alu     alu(
.a      (a),
.b      (b),
.fun    (fun),
.s      (s),
.y      (y)
);
initial
begin
    repeat(20)
    begin
        a = $random % 8;
        b = $random % 8;
        fun = $random % 4;
        #20;
    end
    $stop;
end
endmodule