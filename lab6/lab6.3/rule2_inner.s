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
.word 0x4 cage3
.word 0x2 cage4
.word 0xe cage2
.word 0xe cage2
puzzle: .word 3 grid
i_value: .word 2   # i
j_value: .word 0   # j
to_remove: .word 2 # bitmask 4'b0010

.text
.globl rule2_inner
rule2_inner:
    lw $t0, 0($a0) #t0 = p->size
    li $t1, 0 #k = 0
    #lw $t7, to_remove
    #nor $t7, $a3, $zero      # t7 = ~to_remove (bitwise negation)
    not $t7, $a3
    lw $t3, 4($a0) #p->grid
for:
    bge $t1, $t0, end_for #k >= size
    
    beq $t1, $a2, end_first_if #if(k == j) branch
    mul $t2, $t0, $a1           #size * i
    add $t2, $t2, $t1           #(size * i) + k
    mul $t2, $t2, 8             #8*((size * i) + k)
    add $t2, $t3, $t2           #address of p->grid[(size * i) + k[]
    lw $t4, 0($t2)
    and $t6, $t7, $t4           #& operation
    sw $t6, 0($t2)
end_first_if:
    beq $t1, $a1, end_second_if #if(k == i) branch
    mul $t2, $t0, $t1           #size * k
    add $t2, $t2, $a2           #(size * k) + j
    mul $t2, $t2, 8             #8 * ((size * k) + j)
    add $t2, $t3, $t2           #address of p->grid[(size * i) + k[]
    lw $t4, 0($t2)
    and $t6, $t7, $t4           #& operation
    sw $t6, 0($t2)
end_second_if:  
    add $t1, $t1, 1
    j for
end_for:
    jr $ra