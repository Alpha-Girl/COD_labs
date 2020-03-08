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
        li   $v0,30
        syscall
        move $t6,$a0
        move $t5,$a1
        li   $a0,0x10010000
        move $a1,$t7     #  $a1=n
        move $s2,$a0     #  $a0=v
        move $s3,$a1     #  $s3=n
        move $s0,$s3   #  $s0=i=n
        addi $s0,$s0,-1   #   i=n-1
forlist1:
        slt  $t0,$zero,$s0    # if(0 < i) $t0=1 else $t0=0
        beq  $t0,$zero,exit0 
        li   $s1,1     # $s1=j=0
        move $t2,$a0       # $t2=v
forlist2:
        slt  $t0,$s0,$s1      # if(j < i) $t0=1 else $t0=0
        bne  $t0,$zero,exit1
        lw   $t3,0($t2)
        lw   $t4,4($t2)
        slt  $t0,$t4,$t3      # if(a[j+1]<a[j]) $t0=1 else $t0=0
        beq  $t0,$zero,exit2
        sw   $t3,4($t2)
        sw   $t4,0($t2)
        
exit2:
        addi $s1,$s1,1       #  j++
        addi $t2,$t2,4       #  v+=4
        j    forlist2
exit1:
        addi $s0,$s0,-1
        j    forlist1

exit0:  
        move $s0,$t7        # i=n
        li   $v0,30
        syscall 
        move $t9,$a0
        move $t8,$a1
        li   $a0,0x10010000
        addi $s0,$s0,-1
        move $t2,$a0        # $t2 =v        
for2:   
        slt  $t0,$s0,$zero    # if(0 < i) $t0=1 else $t0=0
        bne  $t0,$zero,last   # if(0=i) jump to end
        li   $v0,1
        lw   $a0,0($t2)
        syscall
        addi $t2,$t2,4
        addi $s0,$s0,-1
        j    for2
last:    

    
