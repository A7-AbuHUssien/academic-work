# =================================================================
# Program: Mini Banking System
# Features: PIN Verification, Deposit, Withdraw, Transfer, Balance Check
# =================================================================

.data
    # Account Data
    correct_pin: .word 1234
    balance:     .word 1000       # Starting balance: $1000

    # Strings / Menus
    prompt_pin:  .asciiz "\nEnter your 4-digit PIN: "
    wrong_pin:   .asciiz "Incorrect PIN! Access Denied.\n"
    welcome:     .asciiz "\n--- WELCOME TO MIPS BANK ---"
    menu:        .asciiz "\n1. Check Balance\n2. Deposit\n3. Withdraw\n4. Transfer\n5. Exit\nChoose an option: "
    
    # Feature Prompts
    bal_msg:     .asciiz "\nYour current balance is: $"
    dep_msg:     .asciiz "\nEnter amount to deposit: $"
    with_msg:    .asciiz "\nEnter amount to withdraw: $"
    trans_acc:   .asciiz "\nEnter target account number: "
    trans_amt:   .asciiz "Enter amount to transfer: $"
    
    # Success / Error Messages
    success:     .asciiz "Transaction successful!\n"
    insufficient:.asciiz "Error: Insufficient funds!\n"
    invalid_opt: .asciiz "Invalid option! Try again.\n"
    goodbye:     .asciiz "\nThank you for using MIPS Bank. Goodbye!\n"

.text
.globl main

main:
    # -------------------------------------------------------------
    # PIN VERIFICATION
    # -------------------------------------------------------------
    li $v0, 4
    la $a0, prompt_pin
    syscall

    li $v0, 5           # Read integer (user PIN input)
    syscall
    move $t0, $v0       # $t0 = entered PIN

    lw $t1, correct_pin # $t1 = 1234
    beq $t0, $t1, menu_loop # If PIN is correct, go to main menu

    # Wrong PIN handling
    li $v0, 4
    la $a0, wrong_pin
    syscall
    j main              # Loop back to ask for PIN again

    # -------------------------------------------------------------
    # MAIN MENU LOOP
    # -------------------------------------------------------------
menu_loop:
    li $v0, 4
    la $a0, welcome
    syscall

    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5           # Read menu choice
    syscall
    move $t0, $v0       # $t0 = choice

    # Switch-case structure for Menu
    li $t1, 1
    beq $t0, $t1, check_balance
    li $t1, 2
    beq $t0, $t1, deposit
    li $t1, 3
    beq $t0, $t1, withdraw
    li $t1, 4
    beq $t0, $t1, transfer
    li $t1, 5
    beq $t0, $t1, exit_program

    # Default case (Invalid Input)
    li $v0, 4
    la $a0, invalid_opt
    syscall
    j menu_loop

    # -------------------------------------------------------------
    # 1. CHECK BALANCE
    # -------------------------------------------------------------
check_balance:
    li $v0, 4
    la $a0, bal_msg
    syscall

    lw $a0, balance     # Load current balance to print
    li $v0, 1           # Print integer
    syscall
    
    li $v0, 11          # Print newline character
    li $a0, 10
    syscall
    j menu_loop

    # -------------------------------------------------------------
    # 2. DEPOSIT
    # -------------------------------------------------------------
deposit:
    li $v0, 4
    la $a0, dep_msg
    syscall

    li $v0, 5           # Read deposit amount
    syscall
    move $t0, $v0       # $t0 = deposit amount

    lw $t1, balance     # Load current balance
    add $t1, $t1, $t0   # New balance = balance + deposit
    sw $t1, balance     # Save back to memory

    li $v0, 4
    la $a0, success
    syscall
    j menu_loop

    # -------------------------------------------------------------
    # 3. WITHDRAW
    # -------------------------------------------------------------
withdraw:
    li $v0, 4
    la $a0, with_msg
    syscall

    li $v0, 5           # Read withdrawal amount
    syscall
    move $t0, $v0       # $t0 = withdrawal amount

    lw $t1, balance     # Load current balance
    blt $t1, $t0, low_funds # If balance < withdrawal, error

    sub $t1, $t1, $t0   # New balance = balance - withdrawal
    sw $t1, balance     # Save back to memory

    li $v0, 4
    la $a0, success
    syscall
    j menu_loop

low_funds:
    li $v0, 4
    la $a0, insufficient
    syscall
    j menu_loop

    # -------------------------------------------------------------
    # 4. TRANSFER
    # -------------------------------------------------------------
transfer:
    li $v0, 4
    la $a0, trans_acc
    syscall

    li $v0, 5           # Read destination account number (Dummy validation)
    syscall

    li $v0, 4
    la $a0, trans_amt
    syscall

    li $v0, 5           # Read transfer amount
    syscall
    move $t0, $v0       # $t0 = transfer amount

    lw $t1, balance     # Load current balance
    blt $t1, $t0, low_funds # If balance < transfer, error

    sub $t1, $t1, $t0   # New balance = balance - transfer
    sw $t1, balance     # Save back to memory

    li $v0, 4
    la $a0, success
    syscall
    j menu_loop

    # -------------------------------------------------------------
    # 5. EXIT
    # -------------------------------------------------------------
exit_program:
    li $v0, 4
    la $a0, goodbye
    syscall

    li $v0, 10          # System call for exit
    syscall
