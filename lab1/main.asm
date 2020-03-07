main:
    li $v0,5
    syscall          # get n
    move $t0,$v0     # $t0 = n
    move $s0,$zero   # i = 0
    move $s2,$zero   
    move $s3,0x10010000
for1:
    slt  $s1,$s0,$t0     # if(i < n) $s1=1 else $s1=0
    beq  $s1,$zero,exit1
    addi $s0,$s0,1       # i++
    li   $v0,5           
    syscall              # get a[i]
    sw   $v0,0($s3)    # Memory[0+$s3]=a[i]
    addi $s3,$s3,4
    j    for1
exit1:
