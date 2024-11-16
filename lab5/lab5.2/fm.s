# .data
# array:   .word   5   -10   20   0   7   -15  
# # Define an array with a mix of positive and negative integers.
# 
# .text
# main:
#     la    $2, array      # Load the base address of the array
# 
#     lw    $3, 0($2)      # Load 5 into $3
#     lw    $4, 4($2)      # Load -10 into $4
#     lw    $5, 8($2)      # Load 20 into $5
#     lw    $6, 12($2)     # Load 0 into $6
#     lw    $7, 16($2)     # Load 7 into $7
#     lw    $8, 20($2)     # Load -15 into $8
# 
#     # Test Case 1: 5 < -10? (false)
#     slt   $9, $3, $4     # $9 should be 0 (because 5 is not less than -10)
# 
#     # Test Case 2: -10 < 20? (true)
#     slt   $10, $4, $5    # $10 should be 1 (because -10 is less than 20)
# 
#     # Test Case 3: 0 < 7? (true)
#     slt   $11, $6, $7    # $11 should be 1 (because 0 is less than 7)
# 
#     # Test Case 4: 7 < -15? (false)
#     slt   $12, $7, $8    # $12 should be 0 (because 7 is not less than -15)
# 
#     # End program
# end:
#     nop  # No operation, just to end the program


#.data
#array:  .word  2147483647 -2147483648  
## Max positive and min negative 32-bit signed values
#
#.text
#main:
#    la    $2, values               # Load the base address of the array into $2
#
#    lw    $3, 0($2)                # Load 2147483647 (max signed int) into $3
#    lw    $4, 4($2)                # Load -2147483648 (min signed int) into $4
#
#    # Test Case 1: 2147483647 < -2147483648? (false)
#    slt   $5, $3, $4               # $5 should be 0 because 2147483647 is not less than -2147483648
#
#    # Test Case 2: -2147483648 < 2147483647? (true)
#    slt   $6, $4, $3               # $6 should be 1 because -2147483648 is less than 2147483647
#
#    # Test Case 3: -2147483648 < -2147483648? (false)
#    slt   $7, $4, $4               # $7 should be 0 because -2147483648 is not less than itself
#
#    # Test Case 4: 2147483647 < 2147483647? (false)
#    slt   $8, $3, $3               # $8 should be 0 because 2147483647 is not less than itself
#
#    # End program
#end:
#    nop
#