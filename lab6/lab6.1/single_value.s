.data
.align 2
# Test case
test0_value: .word 0x0003

.text
.globl single_value
single_value:
    sub $sp, $sp, 12             
    sw $s0, 0($sp)               
    sw $s1, 4($sp)               
    sw $ra, 8($sp)              

    move $s0, $a0                

if:
    beq $s0, $0, error_case       

    sub $t1, $s0, 1              
    and $t1, $t1, $s0             
    bne $t1, $0, error_case       

    li $t2, 0                    

while:
    beq $s0, 1, end_while        
    add $t2, $t2, 1              
    sra $s0, $s0, 1              
    j while                      

end_while:
    move $v0, $t2                
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $ra, 8($sp)
    add $sp, $sp, 12           
    jr $ra                       

error_case:
    li $v0, -1                   
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $ra, 8($sp)
    add $sp, $sp, 12              # Restore stack pointer
    jr $ra                        # Return to caller
