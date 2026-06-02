# =================================================================
# Project: Smart Parking System
# Features: View Map, Park Car, Leave Space, View Stats
# =================================================================

.data
    parking_lots: .word 0, 0, 0, 0, 0  
    size:         .word 5

    welcome:      .asciiz "\n--- SMART PARKING SYSTEM ---"
    menu:         .asciiz "\n1. View Parking Map\n2. Park a Car\n3. Leave Parking\n4. View Stats\n5. Exit\nChoose an option: "
    prompt_slot:  .asciiz "\nEnter slot number (1-5): "
    
    msg_free:     .asciiz "[Free] "
    msg_busy:     .asciiz "[Occupied] "
    msg_success:  .asciiz "Operation successful!\n"
    msg_taken:    .asciiz "Error: Slot already occupied!\n"
    msg_empty:    .asciiz "Error: Slot is already empty!\n"
    msg_invalid:  .asciiz "Invalid slot number!\n"
    msg_opt_err:  .asciiz "Invalid option! Try again.\n"
    goodbye:      .asciiz "\nSystem shutdown. Goodbye!\n"
    
    stat_free:    .asciiz "\nTotal Free Slots: "
    stat_busy:    .asciiz "\nTotal Occupied Slots: "

.text
.globl main

main:
menu_loop:
    li $v0, 4
    la $a0, welcome
    syscall

    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $t1, 1
    beq $t0, $t1, view_map
    li $t1, 2
    beq $t0, $t1, park_car
    li $t1, 3
    beq $t0, $t1, leave_parking
    li $t1, 4
    beq $t0, $t1, view_stats
    li $t1, 5
    beq $t0, $t1, exit_program

    li $v0, 4
    la $a0, msg_opt_err
    syscall
    j menu_loop

    # -------------------------------------------------------------
    # 1. VIEW MAP
    # -------------------------------------------------------------
view_map:
    li $v0, 11
    li $a0, 10
    syscall

    li $t0, 0
    lw $t1, size
    la $t2, parking_lots

map_loop:
    beq $t0, $t1, map_done
    lw $t3, 0($t2)
    
    beq $t3, $zero, print_free
    li $v0, 4
    la $a0, msg_busy
    syscall
    j next_slot

print_free:
    li $v0, 4
    la $a0, msg_free
    syscall

next_slot:
    addi $t2, $t2, 4
    addi $t0, $t0, 1
    j map_loop

map_done:
    li $v0, 11
    li $a0, 10
    syscall
    j menu_loop

    # -------------------------------------------------------------
    # 2. PARK CAR
    # -------------------------------------------------------------
park_car:
    li $v0, 4
    la $a0, prompt_slot
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    blt $t0, 1, invalid_slot
    gt_five_p:
    li $t1, 5
    bgt $t0, $t1, invalid_slot

    addi $t0, $t0, -1
    sll $t0, $t0, 2
    la $t1, parking_lots
    add $t1, $t1, $t0

    lw $t2, 0($t1)
    bne $t2, $zero, slot_taken

    li $t3, 1
    sw $t3, 0($t1)

    li $v0, 4
    la $a0, msg_success
    syscall
    j menu_loop

slot_taken:
    li $v0, 4
    la $a0, msg_taken
    syscall
    j menu_loop

    # -------------------------------------------------------------
    # 3. LEAVE PARKING
    # -------------------------------------------------------------
leave_parking:
    li $v0, 4
    la $a0, prompt_slot
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    blt $t0, 1, invalid_slot
    gt_five_l:
    li $t1, 5
    bgt $t0, $t1, invalid_slot

    addi $t0, $t0, -1
    sll $t0, $t0, 2
    la $t1, parking_lots
    add $t1, $t1, $t0

    lw $t2, 0($t1)
    beq $t2, $zero, slot_empty

    sw $zero, 0($t1)

    li $v0, 4
    la $a0, msg_success
    syscall
    j menu_loop

slot_empty:
    li $v0, 4
    la $a0, msg_empty
    syscall
    j menu_loop

invalid_slot:
    li $v0, 4
    la $a0, msg_invalid
    syscall
    j menu_loop

    # -------------------------------------------------------------
    # 4. VIEW STATS
    # -------------------------------------------------------------
view_stats:
    li $t0, 0
    lw $t1, size
    la $t2, parking_lots
    li $t4, 0
    li $t5, 0

stats_loop:
    beq $t0, $t1, stats_done
    lw $t3, 0($t2)
    
    beq $t3, $zero, count_free
    addi $t5, $t5, 1
    j next_stat

count_free:
    addi $t4, $t4, 1

next_stat:
    addi $t2, $t2, 4
    addi $t0, $t0, 1
    j stats_loop

stats_done:
    li $v0, 4
    la $a0, stat_free
    syscall
    move $a0, $t4
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, stat_busy
    syscall
    move $a0, $t5
    li $v0, 1
    syscall

    li $v0, 11
    li $a0, 10
    syscall
    j menu_loop

    # -------------------------------------------------------------
    # 5. EXIT
    # -------------------------------------------------------------
exit_program:
    li $v0, 4
    la $a0, goodbye
    syscall

    li $v0, 10
    syscall
