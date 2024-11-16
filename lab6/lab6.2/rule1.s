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
.word 0xe cage0
.word 0xe cage1
.word 0xe cage1
.word 0xe cage0
.word 0xe cage2
.word 0xe cage3
.word 0xe cage4
.word 0xe cage2
.word 0xe cage2
puzzle: .word 3 grid

.text
.globl rule1
rule1:
    lw $t0, 0($a0) #p->size
    mul $t1, $t0, $t0 #size_squared = p->size * p->size;
    li $t2, 0 #i = 0
for:
    bge $t2, $t1, end_for
    #cage_t: 16, cell_t: 8
    lw $t3, 4($a0) #t3 = address of p->grid
    mul $t4, $t2, 8 #8*i
    add $t5, $t3, $t4 # t5 = address of cell = &p->grid[i](current cell_t)
    
    lw $t6, 4($t5)# t6 = cell->cage(address of cage_t)

    lb $t7, 0($t6) #cell->cage->operation
    bne $t7, $0, next_iteration
    
    #add $t6, $t4, 4#address of cell->cage->target
    lw $t8, 4($t6)#cell->cage->target
    li $t9, 1
    sll $t9, $t9, $t8
    sw $t9, 0($t5)
next_iteration:
    add $t2, $t2, 1
    j for
end_for:
    jr $ra
    
    
    