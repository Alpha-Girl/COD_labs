
# BubbleSort.asm  
.data   
          
.text  
.globl main  
main:  
        li $v0,5             # 系统调用得到n
        syscall              # get n  
        move $t7,$v0         # $t7 = n  
        move $s0,$zero       # i = 0  
        move $s2,$zero     
        li   $s3,0x10010000  # 数组v[]的地址
		                     # for(i=0;i<n;i++) scanf("%d",&v[i])
for1:                        # get v[0 ... n-1]  
        slt  $s1,$s0,$t7     # if(i < n) $s1 = 1 else $s1 = 0  
        beq  $s1,$zero,sort    
        addi $s0,$s0,1       # i++  
        li   $v0,5             
        syscall              # get v[i]  
        sw   $v0,0($s3)      # Memory[0+$s3] = v[i]  
        addi $s3,$s3,4       # $s3 = $s3 + 4  
        j    for1  
sort:     
        li   $v0,30          # 系统调用获得排序开始时的时间
        syscall              # get start time $a1,$a0  
        move $t6,$a0         # $t6 <- $a0  
        move $t5,$a1         # $t5 <- $a1  
        li   $a0,0x10010000   
        move $a1,$t7         #  $a1 = n  
        move $s2,$a0         #  $a0 = v  
        move $s3,$a1         #  $s3 = n  
        move $s0,$s3         #  $s0 = i = n  
        addi $s0,$s0,-1      #  i = n - 1  
		                     #  for(i=n-1;i>0;i--)
forlist1:  
        slt  $t0,$zero,$s0   # if(0 < i) $t0 = 1 else $t0 = 0  
        beq  $t0,$zero,exit0   
        li   $s1,0           # $s1 = j = 0  
        move $t2,$a0         # $t2 = v  
							 # for(j=0;j<i;j++) 
forlist2:  
        slt  $t0,$s1,$s0     # if(j < i) $t0 = 1 else $t0 = 0   
        beq  $t0,$zero,exit1  
        lw   $t3,0($t2)      # $t3 = v[j]  
        lw   $t4,4($t2)      # $t4 = v[j+1]  
        slt  $t0,$t4,$t3     # if(v[j+1] < v[j]) $t0 = 1 else $t0 = 0  
        beq  $t0,$zero,exit2  
        sw   $t3,4($t2)      # swap  
        sw   $t4,0($t2)  
                             
exit2:  
        addi $s1,$s1,1       # j++  
        addi $t2,$t2,4       # v += 4  
        j    forlist2  
exit1:  
        addi $s0,$s0,-1      # i--  
        j    forlist1  
                             # 系统调用获得排序结束时的时间
exit0:    
        move $s0,$t7         # i=n  
        li   $v0,30          # get end time $a1,$a0  
        syscall    
        move $t9,$a0         # $t9 <- $a0      
        move $t8,$a1         # $t8 <- $a1  
        li   $a0,0x10010000  
        move $t2,$a0         # $t2 = v          
for2:     
        slt  $t0,$zero,$s0   # if(0 < i) $t0 = 1 else $t0 = 0  
        beq  $t0,$zero,end   # if(0 = i) jump to end  
        li   $v0,1           # print v[n-i]  
        lw   $a0,0($t2)  
        syscall  
        li   $v0,11             
        li   $a0,0x00000020  # print ' '  
        syscall  
        addi $t2,$t2,4       # v += 4  
        addi $s0,$s0,-1      # i--  
        j    for2  
end:    sub  $a0,$t9,$t6     # end time - start time  
        li   $v0,1           # print (end time - start time)
        syscall  
        li   $a0,0x0000006d  # print 'm'  
        li   $v0,11  
        syscall  
        li   $a0,0x00000073  # print 's'  
        li   $v0,11  
        syscall  