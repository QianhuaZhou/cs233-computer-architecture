# feel free to add or change any of the test cases to compile

.text
main:
   addi  $6, $0, 100        # $6  =   100 (0x64)
   addi  $7, $6, 155        # $7  =   255 (0xff)
   add   $8, $6, $6         # $8  =   200 (0xc8)
