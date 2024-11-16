.data
.align 2
# Test case 0 (a 2x2 board)
cells0:   # cage pointers set to zero because this code won't use them
  .word 0x00000002 0x00000000  0x00000004 0x00000000 
  .word 0x00000004 0x00000000  0x00000002 0x00000000
  
puzzle:  # move this label before puzzle1 if you want to test that puzzle
puzzle0:
  .word 0x00000002 cells0
# Test case 1 (a 4x4 board)
cells1:   # cage pointers set to zero because this code won't use them
  .word 0x00000002 0x00000000  0x00000004 0x00000000  0x00000010 0x00000000  0x00000008 0x00000000
  .word 0x00000004 0x00000000  0x00000010 0x00000000  0x00000008 0x00000000  0x00000002 0x00000000 
  .word 0x00000010 0x00000000  0x00000008 0x00000000  0x00000002 0x00000000  0x00000004 0x00000000 
  .word 0x00000012 0x00000000  0x00000004 0x00000000  0x00000010 0x00000000  0x00000008 0x00000000

puzzle1:
  .word 0x00000004 cells1


.text
.globl is_done
is_done:
    sub $sp, $sp, 16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    
    move $s0, $a0 #s0 = p
    lw $t0, 0($s0) #t0 = p->size
    mul $t1, $t0, $t0 #size_squared = p->size * p->size
    li $s1, 0 #i = 0
    move $s2, $t1
for:
    bge $s1, $s2, end_for
    lw $t2, 4($s0) #t3 = p->grid
    mul $t3, $s1, 8 #8 * i
    add $t4, $t2, $t3 #address of p->grid[i]
    
    lw $a0, 0($t4) #load p->grid[i].domain
    jal single_value
    li $t5, -1
    bne $v0, $t5, next_call
    li $v0, 0 #false
    j end
   
next_call:
    addiu $s1, $s1, 1
    j for
    
end_for:
    li $v0, 1 #true
    j end
end: 
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    add $sp, $sp, 16
    jr $ra
    
    
    