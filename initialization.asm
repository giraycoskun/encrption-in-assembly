.text

.globl initialization

initialization:
	
	addi $sp, $sp, -24
	sw $ra, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0 # initial vectors 
	move $s1, $a1 # keys
	move $s2, $a2 # states
	move $s4, $a3 # temp array for w func


	add $t0, $zero, $zero  #t0 = i
	
initializationLoop:
	beq $t0, 8, initializationEndLoop
	
	
	move $t1, $t0
	addi $t2, $zero, 4
	divu $t1, $t2
	mfhi $t1      # t1 = i mod4
	
	add $t1, $t1, $t1
	add $t1, $t1, $t1
	add $t1, $t1, $s0
	lw $t2, 0($t1)
	
	add $t1, $t0, $t0
	add $t1, $t1, $t1
	add $t1, $t1, $s2
	sw $t2, 0($t1)
	
	addi $t0, $t0, 1   
	
	j initializationLoop
	
initializationEndLoop:

	add $s3, $zero, $zero
	
calculationLoop:
	
	# t0
	lw $t0, 0($s2)
	add $t0, $t0, $s3
	and $t0, $t0, 65535 #0000 0000 0000 0000 1111 1111 111 11111
	
	sw $t0, 0($s4)
	lw $t1, 0($s1)
	sw $t1, 4($s4)
	lw $t2, 4($s1)
	sw $t2, 8($s4)
	lw $t3, 8($s1)
	sw $t3, 12($s4)
	lw $t4, 12($s1)
	sw $t4, 16($s4)
	move $a0, $s4
	jal w_function
	move $s5, $v0  # s5 = t0
	
	# t1
	lw $t0, 4($s2)
	add $t0, $t0, $s5
	and $t0, $t0, 65535
	
	sw $t0, 0($s4)
	
	lw $t1, 16($s1)
	sw $t1, 4($s4)
	
	lw $t2, 20($s1)
	sw $t2, 8($s4)
	
	lw $t3, 24($s1)
	sw $t3, 12($s4)
	
	lw $t4, 28($s1)
	sw $t4, 16($s4)
	
	move $a0, $s4
	jal w_function
	move $s6, $v0  # s6 = t1
	
	# t2
	lw $t0, 8($s2)
	add $t0, $t0, $s6
	and $t0, $t0, 65535
	
	sw $t0, 0($s4)
	
	lw $t1, 0($s1)
	sw $t1, 4($s4)
	
	lw $t2, 8($s1)
	sw $t2, 8($s4)
	
	lw $t3, 16($s1)
	sw $t3, 12($s4)
	
	lw $t4, 24($s1)
	sw $t4, 16($s4)
	
	move $a0, $s4
	jal w_function
	move $s7, $v0  # s7 = t2
	
	# t3
	lw $t0, 12($s2)
	add $t0, $t0, $s7
	and $t0, $t0, 65535
	
	sw $t0, 0($s4)
	
	lw $t1, 4($s1)
	sw $t1, 4($s4)
	
	lw $t2, 12($s1)
	sw $t2, 8($s4)
	
	lw $t3, 20($s1)
	sw $t3, 12($s4)
	
	lw $t4, 28($s1)
	sw $t4, 16($s4)
	
	move $a0, $s4
	jal w_function
	move $t9, $v0  # s4 = t3
	
	# R0(i+1)
	lw $t0, 0($s2)
	add $t0, $t0, $t9
	and $t0, $t0, 65535
	
	sll $t1, $t0, 16
	or $t1, $t0, $t1
	rol $t1, $t1, 3
	srl $t1, $t1, 16
	sw $t1, 0($s2)
	
	# R1(i+1)
	lw $t0, 4($s2)
	add $t0, $t0, $s5
	and $t0, $t0, 65535
	
	sll $t1, $t0, 16
	or $t1, $t0, $t1
	ror $t1, $t1, 5
	srl $t1, $t1, 16
	sw $t1, 4($s2)
	
	# R2(i+1)
	lw $t0, 8($s2)
	add $t0, $t0, $s6
	and $t0, $t0, 65535
	
	sll $t1, $t0, 16
	or $t1, $t0, $t1
	rol $t1, $t1, 8
	srl $t1, $t1, 16
	sw $t1, 8($s2)
	
	# R3(i+1)
	lw $t0, 12($s2)
	add $t0, $t0, $s7
	and $t0, $t0, 65535
	
	sll $t1, $t0, 16
	or $t1, $t0, $t1
	rol $t1, $t1, 6
	srl $t1, $t1, 16
	sw $t1, 12($s2)
	
	# R4(i+1)
	lw $t0, 16($s2)
	lw $t1, 12($s2)
	xor $t0, $t0, $t1
	sw $t0, 16($s2)
	
	# R5(i+1)
	lw $t0, 20($s2)
	lw $t1, 4($s2)
	xor $t0, $t0, $t1
	sw $t0, 20($s2)
	
	# R6(i+1)
	lw $t0, 24($s2)
	lw $t1, 8($s2)
	xor $t0, $t0, $t1
	sw $t0, 24($s2)
	
	# R7(i+1)
	lw $t0, 28($s2)
	lw $t1, 0($s2)
	xor $t0, $t0, $t1
	sw $t0, 28($s2)
	
	addi $s3, $s3, 1
	bne $s3, 4, calculationLoop

	move $v0, $s2

	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $ra, 20($sp)
	addi $sp, $sp, 24

	jr $ra
	

############