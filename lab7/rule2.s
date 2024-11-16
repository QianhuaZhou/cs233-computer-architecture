.data
.align 2
# Test case 0
# Change this test case to more fully test your code
positions0: .word  0 3
cage0: .word  2 1 2 positions0
positions1: .word  1 2
cage1: .word  1 4 2 positions1
positions2: .word  4 7 8
cage2: .word  1 6 3 positions2
positions3: .word  5
cage3: .word  0 2 1 positions3
positions4: .word  6
cage4: .word  0 1 1 positions4
grid:
.word 0xe cage0  0xe cage1  0xe cage1
.word 0xe cage0  0xe cage2  0x4 cage3
.word 0x2 cage4  0xe cage2  0xe cage2
puzzle: .word 3 grid

.text
.globl rule2
rule2:
    sub $sp, $sp, 24
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    sw $s3, 16($sp)
    sw $s4, 20($sp)
    
    move $s0, $a0 #*p
    lw $s1, 0($s0) #$size
    li $s2, 0 #i
   
for_out:
    bge $s2, $s1, end
     li $s3, 0 #j
for_inner:
    bge $s3, $s1, end_out
    
    mul $t0, $s1, $s2
    add $t0, $t0, $s3
    mul $t0, $t0, 8 #8*(size*i+j)--not 4!!
    
    lw $t1, 4($s0) #*grid
    add $t2, $t1, $t0 #address of p->grid[(size * i) + j]
    lw $s4, 0($t2) #p->grid[(size * i) + j].domain
    move $a0, $s4
    jal single_value
    #pos = $v0
if:
    li $t3, -1
    beq $v0, $t3, end_inner
    move $a0, $s0
    move $a1, $s2
    move $a2, $s3
    move $a3, $s4
    jal rule2_inner
end_inner:
    add $s3, $s3, 1
    j for_inner
end_out:
    add $s2, $s2, 1
    j for_out
end:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $s4, 20($sp)
    add $sp, $sp, 24
    jr $ra
    