.data
    name:      .asciiz "Ahmed Esam AbuHussien"
    section:   .asciiz "01-Network"

    prompt:    .asciiz "Enter an integer: "
    even_msg:  .asciiz " is Even\n"
    odd_msg:   .asciiz " is Odd\n"
    newline:   .asciiz "\n"

.text
	# Name
    ##################################
    # A
    la $t0, name
    lb $a0, 0($t0)
    li $v0, 11
    syscall
    
    # Space
    la $a0, 32
    li $v0, 11
    syscall
    
    # E
    la $t0, name
    lb $a0, 6($t0)
    li $v0, 11
    syscall
    
    # Space
    la $a0, 32
    li $v0, 11
    syscall
    
    # A
    la $t0, name
    lb $a0, 11($t0)
    li $v0, 11
    syscall
    
    ##################################
    
    # ── newline ──
    li $v0, 4
    la $a0, newline
    syscall

    # ── input ──
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    # print number
    li $v0, 1
    move $a0, $t0
    syscall

    # even / odd
    andi $t1, $t0, 1
    beq $t1, $zero, even

    odd:
       li $v0, 4
       la $a0, odd_msg
       syscall
       j exit

    even:
       li $v0, 4
       la $a0, even_msg
       syscall

    exit:
       li $v0, 10
       syscall