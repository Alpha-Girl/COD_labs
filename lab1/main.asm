main:
    li $v0,5
    syscall          # get n
    move $t7,$v0     # $t7 = n
    move $s0,$zero   # i = 0
    move $s2,$zero   
    li $s3,0x10010000
for1:
    slt  $s1,$s0,$t7     # if(i < n) $s1=1 else $s1=0
    beq  $s1,$zero,sort
    addi $s0,$s0,1       # i++
    li   $v0,5           
    syscall              # get a[i]
    sw   $v0,0($s3)    # Memory[0+$s3]=a[i]
    addi $s3,$s3,4
    j    for1
sort:   
        li   $a0,0x10010000
        move $a1,$t7     #  $a1=n
        move $s2,$a0     #  $a0=v
        move $s3,$a1     #  $s3=n
        move $s0,$s3   #  $s0=i=n
        addi  $s0,-1   #   i=n-1
forlist1:
        slt  $t0,$zero,$s0    # if(0 < i) $t0=1 else $t0=0
        beq  $t0,$zero,exit1 
        addi $s1,$s3,0     # $s1=j=i
        move $t2,$a0       # $t2=v
forlist2:
        slt  $t0,$s0,$s1      # if(j < n) $t0=1 else $t0=0
        bne  $t0,$zero,exit2
        move $t2,
        lw   $t3,0($t2)
        lw   $t4,4($t2)
        slt  $t0,$t4,$t3
        beq  $t0,$zero,exit2
        move $a0,$s2
        move $a1,$s1
        jal  swap
        addi $s1,$s1,-1
        j    forlist2
exit2:
        addi $s0,$s0,1
        j    forlist1
exit1:
        lw   $s0,0($sp)
        lw   $s1,4($sp)
        lw   $s2,8($sp)
        lw   $s3,12($sp)
        lw   $ra,16($sp)
        addi $sp,$sp,20
        jr   $ra
swap:
        sll  $t1,$a1,2    # $a0
        add  $t1,$a0,$s1

        lw   $t0,0($t1)
        lw   $t2,4($t1)

        sw   $t2,0($t1)
        sw   $t0,4($t1)

        jr   $ra

    
