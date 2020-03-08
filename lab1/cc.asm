#sort
.data
    array: .word  3,10,8,2,5,2,3
    str_old:    .asciiz "old array:\n"
    str_new:    .asciiz "new array:\n"
    blank:      .asciiz " "
    enter:      .asciiz "\n"
.text
.globl main
main:
     la $a0,str_old  
    li $v0,4
    syscall                    #print str_old string
    jal print_array            #print old arrry
    
    la $a0,array               #array name
    li $a1,7                   #array length
    jal sort
    
    la $a0,str_new   
    li $v0,4
    syscall                    #print  str_new string
    jal print_array            #print new arrry
    
    li $v0,10
    syscall                    # exit

print_array:
    li $a1, 7       
    la $a2, array   
loop1:  blez $a1, over1       
    lw   $a0, 0($a2)       
    li   $v0, 1          
    syscall

    la $a0, blank              
    li $v0, 4
    syscall

    addi $a2, $a2, 4        
    addi $a1, $a1, -1     
    j loop1
over1:
    la $a0, enter           
    li $v0, 4
    syscall
    jr $ra

#$a0: arrry
#$a1: k
swap:
    sll $t1,$a1,2             #reg $t1 = k * 4
    add $t1,$a0,$t1           #reg $t1 = v + k * 4
    
    lw $t0,0($t1)             #reg $t0(tmp) = v[k]
    lw $t2,4($t1)             #reg $t2 = v[k + 1]
    
    sw $t2,0($t1)             #v[k] = v[k + 1]
    sw $t0,4($t1)             #v[k+ 1] = tmp(v[k])    
    jr $ra
#$a0: v
#$a1: n
#$s0: i
#$s1: j
sort:
    addi $sp,$sp,-20        #make room on stack for 5 registers
    sw $ra,16($sp)                
    sw $s3,12($sp)
    sw $s2,8($sp)
    sw $s1,4($sp)
    sw $s0,0($sp)
    
    move $s2,$a0            #save v
    move $s3,$a1            #save n
    
    move $s0,$zero          #i = 0
for1tst:
    slt $t0,$s0,$s3     #if(i < n),reg $t0 = 1
    beq $t0,$zero,exit1
    
    addi $s1,$s0,-1
for2tst:
    slti $t0,$s1,0            #if(j < 0),reg $t0 = 1
    bnez $t0,exit2            #go to exit2 if(j < 0)
    sll $t1,$s1,2             #$t1 = j * 4
    add $t2,$s2,$t1           #$t2 = v + j * 4
    lw  $t3,0($t2)            #$t3 = v[j]
    lw  $t4,4($t2)            #$t4 = v[j + 1]
    slt $t0,$t4,$t3           #if(v[j + 1] < v[j]),reg $t0 = 1
    beq $t0,$zero,exit2       #go to exit2 if(v[j + 1] >= v[j])
    
    move $a0,$s2              #first parameter is v
    move $a1,$s1              #second parameter is j
    jal swap
    
    addi $s1,$s1,-1           #j--
    j for2tst                 #continue inner loop
exit2:
    addi $s0,$s0,1
    j for1tst
exit1:
    lw $s0,0($sp)
    lw $s1,4($sp)
    lw $s2,8($sp)
    lw $s3,12($sp)
    lw $ra,16($sp)
    addi $sp,$sp,20
    jr $ra