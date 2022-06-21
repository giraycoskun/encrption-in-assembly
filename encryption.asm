# PROJECT PHASE 3
# Encryption Algorithm
# Output -> cipher text
# SEDEN DENIZ TASKIN (sedendeniz)
# GIRAY COSKUN (giraycoskun)
.data

S0: .word 0xF, 0x4, 0x5, 0x8, 0x9, 0x7, 0x2, 0x1, 0xA, 0x3, 0x0, 0xE, 0x6, 0xC, 0xD, 0xB
S1: .word 0x4, 0xA, 0x1, 0x6, 0x8, 0xF, 0x7, 0xC, 0x3, 0x0, 0xE, 0xD, 0x5, 0x9, 0xB, 0x2
S2: .word 0x2, 0xF, 0xC, 0x1, 0x5, 0x6, 0xA, 0xD, 0xE, 0x8, 0x3, 0x4, 0x0, 0xB, 0x9, 0x7
S3: .word 0x7, 0xC, 0xE, 0x9, 0x2, 0x1, 0x5, 0xF, 0xB, 0x6, 0xD, 0x0, 0x4, 0x8, 0xA, 0x3


S: .word 0xF, 0x4, 0x5, 0x8, 0x9, 0x7, 0x2, 0x1, 0xA, 0x3, 0x0, 0xE, 0x6, 0xC, 0xD, 0xB,
	  0x4, 0xA, 0x1, 0x6, 0x8, 0xF, 0x7, 0xC, 0x3, 0x0, 0xE, 0xD, 0x5, 0x9, 0xB, 0x2,
	  0x2, 0xF, 0xC, 0x1, 0x5, 0x6, 0xA, 0xD, 0xE, 0x8, 0x3, 0x4, 0x0, 0xB, 0x9, 0x7,
	  0x7, 0xC, 0xE, 0x9, 0x2, 0x1, 0x5, 0xF, 0xB, 0x6, 0xD, 0x0, 0x4, 0x8, 0xA, 0x3

temp: .word 0, 0, 0, 0, 0, 0, 0, 0

.text

.globl encryption
.globl w_function

encryption:

	#s0, s1, s2, s3, s4, s5, s6, s7
	addi $sp, $sp, -36
	sw $ra, 32($sp)
	sw $s7, 28($sp)
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s0, $a0 # plain text word
	move $s1, $a1 # keys
	move $s2, $a2 # states
	move $s3, $a3 # temp array for w func
	
	#t0
	lw $t0, 0($s2) #t0 = R0
	add $t0, $t0, $s0
	and $t0, $t0, 65535 #0000 0000 0000 0000 1111 1111 111 11111 -> mod 2^16
	sw $t0, 0($s3)
	
	lw $t0, 0($s2) #t0 = R0
	lw $t1, 0($s1) #t1 = K0
	xor $t0, $t0, $t1
	sw $t0, 4($s3)
	
	lw $t0, 4($s2) #t0 = R1
	lw $t1, 4($s1) #t1 = K1
	xor $t0, $t0, $t1
	sw $t0, 8($s3)
	
	lw $t0, 8($s2) #t0 = R2
	lw $t1, 8($s1) #t1 = K2
	xor $t0, $t0, $t1
	sw $t0, 12($s3)
	
	lw $t0, 12($s2) #t0 = R3
	lw $t1, 12($s1) #t1 = K3
	xor $t0, $t0, $t1
	sw $t0, 16($s3)
	
	move $a0, $s3
	jal w_function
	move $s4, $v0 #s4 = t0
	
	#t1
	lw $t0, 4($s2) #t0 = R1
	add $t0, $t0, $s4
	and $t0, $t0, 65535 #0000 0000 0000 0000 1111 1111 111 11111 -> mod 2^16
	sw $t0, 0($s3)
	
	lw $t0, 16($s2) #t0 = R4
	lw $t1, 16($s1) #t1 = K4
	xor $t0, $t0, $t1
	sw $t0, 4($s3)
	
	lw $t0, 20($s2) #t0 = R5
	lw $t1, 20($s1) #t1 = K5
	xor $t0, $t0, $t1
	sw $t0, 8($s3)
	
	lw $t0, 24($s2) #t0 = R6
	lw $t1, 24($s1) #t1 = K6
	xor $t0, $t0, $t1
	sw $t0, 12($s3)
	
	lw $t0, 28($s2) #t0 = R7
	lw $t1, 28($s1) #t1 = K7
	xor $t0, $t0, $t1
	sw $t0, 16($s3)
	
	move $a0, $s3
	jal w_function
	move $s5, $v0 #s5 = t1
	
	#t2
	lw $t0, 8($s2) #t0 = R2
	add $t0, $t0, $s5
	and $t0, $t0, 65535 #0000 0000 0000 0000 1111 1111 111 11111 -> mod 2^16
	sw $t0, 0($s3)
	
	lw $t0, 16($s2) #t0 = R4
	lw $t1, 0($s1) #t1 = K0
	xor $t0, $t0, $t1
	sw $t0, 4($s3)
	
	lw $t0, 20($s2) #t0 = R5
	lw $t1, 4($s1) #t1 = K1
	xor $t0, $t0, $t1
	sw $t0, 8($s3)
	
	lw $t0, 24($s2) #t0 = R6
	lw $t1, 8($s1) #t1 = K2
	xor $t0, $t0, $t1
	sw $t0, 12($s3)
	
	lw $t0, 28($s2) #t0 = R7
	lw $t1, 12($s1) #t1 = K3
	xor $t0, $t0, $t1
	sw $t0, 16($s3)
	
	move $a0, $s3
	jal w_function
	move $s6, $v0 #s6 = t2
	
	#C
	lw $t0, 12($s2) #t0 = R3
	add $t0, $t0, $s6
	and $t0, $t0, 65535 #0000 0000 0000 0000 1111 1111 111 11111 -> mod 2^16
	sw $t0, 0($s3)
	
	lw $t0, 0($s2) #t0 = R0
	lw $t1, 16($s1) #t1 = K4
	xor $t0, $t0, $t1
	sw $t0, 4($s3)
	
	lw $t0, 4($s2) #t0 = R1
	lw $t1, 20($s1) #t1 = K5
	xor $t0, $t0, $t1
	sw $t0, 8($s3)
	
	lw $t0, 8($s2) #t0 = R2
	lw $t1, 24($s1) #t1 = K6
	xor $t0, $t0, $t1
	sw $t0, 12($s3)
	
	lw $t0, 12($s2) #t0 = R3
	lw $t1, 28($s1) #t1 = K7
	xor $t0, $t0, $t1
	sw $t0, 16($s3)
	
	move $a0, $s3
	jal w_function
	move $t0, $v0 #t0 = C
	
	lw $t1, 0($s2)
	add $t0, $t0, $t1
	and $t0, $t0, 65535
	move $v0, $t0 #v0 = C
	
	la $s7, temp
	
	#T0
	lw $t0, 0($s2)
	add $t0, $t0, $s6
	and $t0, $t0, 65535 #t0 = T0
	sw $t0, 0($s7)
	
	#T1
	lw $t1, 4($s2)
	add $t1, $t1, $s4
	and $t1, $t1, 65535 #t1 = T1
	sw $t1, 4($s7)
	
	#T2
	lw $t2, 8($s2)
	add $t2, $t2, $s5
	and $t2, $t2, 65535 #t2 = T2
	sw $t2, 8($s7)
	
	#T3
	lw $t3, 12($s2)
	lw $t8, 0($s2)
	add $t3, $t3, $t8
	add $t3, $t3, $s6
	add $t3, $t3, $s4
	and $t3, $t3, 65535 #t3 = T3
	sw $t3, 12($s7)
	
	#T4
	lw $t4, 16($s2)
	xor $t4, $t4, $t3 #t4 = T4
	sw $t4, 16($s7)
	
	#T5
	lw $t5, 4($s2)
	add $t5, $t5, $s4
	and $t5, $t5, 65535
	lw $t8, 20($s2)
	xor $t5, $t5, $t8 #t5 = T5
	sw $t5, 20($s7)
	
	#T6
	lw $t6, 8($s2)
	add $t6, $t6, $s5
	and $t6, $t6, 65535
	lw $t8, 24($s2)
	xor $t6, $t6, $t8 #t6 = T6
	sw $t6, 24($s7)
	
	#T7
	lw $t7, 0($s2)
	add $t7, $t7, $s6
	and $t7, $t7, 65535
	lw $t8, 28($s2)
	xor $t7, $t7, $t8 #t7 = T7
	sw $t7, 28($s7)
	
	add $t0, $zero, $zero #t8 = i
	
encryption_endloop:
	
	add $t1, $t0, $t0
	add $t1, $t1, $t1
	add $t2, $t1, $s7
	add $t3, $t1, $s2
	lw  $t4, 0($t2)
	sw  $t4, 0($t3)
	
	addi $t0, $t0, 1
	bne $t0, 8, encryption_endloop
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, 32($sp)
	addi $sp, $sp, 36	
	jr $ra
	
	

############

		
w_function:

	#s0, s1, s2, s3, s4
	addi $sp, $sp, -24
	sw $ra, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	lw $s0, 0($a0)
	lw $s1, 4($a0)
	lw $s2, 8($a0)
	lw $s3, 12($a0)
	lw $s4, 16($a0)
	
	xor $t0, $s0, $s1
	move $a0, $t0
	jal f_function
	move $t0, $v0
	
	xor $t0, $t0, $s2
	move $a0, $t0
	jal f_function
	move $t0, $v0
	
	xor $t0, $t0, $s3
	move $a0, $t0
	jal f_function
	move $t0, $v0
	
	xor $t0, $t0, $s4
	move $a0, $t0
	jal f_function
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $ra, 20($sp)
	addi $sp, $sp, 24
	jr $ra

	
	
f_function:

	#s0
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# a0 is also input to nonlinear function
	jal smalltable_nonlinear_function #largetable_nonlinear_function
	move $a0, $v0
	jal linear_function
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4	
	jr $ra
	
	
	
linear_function:

	#s0, s1, s2
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)

	move $s0, $a0
	sll $t0, $s0, 16
	or $t1, $s0, $t0
	
	rol $s1, $t1, 6
	ror $s2, $t1, 6
	
	srl $s1, $s1, 16
	srl $s2, $s2, 16
	
	xor $t1, $s0, $s1
	xor $t1, $t1, $s2
	
	move $v0, $t1
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16	
	jr $ra


largetable_nonlinear_function:

	#s0, s1, s2, s3
	addi $sp, $sp, -20
	sw $ra, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	
	move $t0, $a0
	addi $t1, $zero, 15 #0000000000001111
	addi $t2, $zero, 240 #0000000011110000
	addi $t3, $zero, 3840 #0000111100000000
	addi $t4, $zero, 61440 #1111000000000000
	
	and $s3, $t0, $t1 
	and $s2, $t0, $t2
	srl $s2, $s2, 4
	and $s1, $t0, $t3
	srl $s1, $s1, 8
	and $s0, $t0, $t4
	srl $s0, $s0, 12
	
	la $t5, S
	
	add $t1, $zero, $t5
	add $s0, $s0, $s0
	add $s0, $s0, $s0
	add $t1, $t1, $s0
	lw  $s0, 0($t1)
	
	add $t2, $zero, $t5
	addi $s1, $s1, 16
	add $s1, $s1, $s1
	add $s1, $s1, $s1
	add $t2, $t2, $s1
	lw  $s1, 0($t2)
	
	add $t3, $zero, $t5
	addi $s2, $s2, 32
	add $s2, $s2, $s2
	add $s2, $s2, $s2
	add $t3, $t3, $s2
	lw  $s2, 0($t3)
	
	add $t4, $zero, $t5
	addi $s3, $s3, 48
	add $s3, $s3, $s3
	add $s3, $s3, $s3
	add $t4, $t4, $s3
	lw  $s3, 0($t4)
	
	sll $s0, $s0, 12
	sll $s1, $s1, 8
	sll $s2, $s2, 4
	
	or $s0, $s0, $s1
	or $s0, $s0, $s2
	or $s0, $s0, $s3

	move $v0, $s0
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	jr $ra
	
smalltable_nonlinear_function:

	#s0, s1, s2, s3
	addi $sp, $sp, -20
	sw $ra, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)

	move $t0, $a0
	addi $t1, $zero, 15 # 0000000000001111
	addi $t2, $zero, 240 # 0000000011110000
	addi $t3, $zero, 3840 # 0000111100000000
	addi $t4, $zero, 61440 # 1111000000000000
	and $s3, $t0, $t1 
	and $s2, $t0, $t2
	srl $s2, $s2, 4
	and $s1, $t0, $t3
	srl $s1, $s1, 8
	and $s0, $t0, $t4
	srl $s0, $s0, 12
	
	la $t5, S0
	
	add $t1, $zero, $t5
	add $s0, $s0, $s0
	add $s0, $s0, $s0
	add $t1, $t1, $s0
	lw  $s0, 0($t1)
	
	la $t5, S1
	
	add $t2, $zero, $t5
	add $s1, $s1, $s1
	add $s1, $s1, $s1
	add $t2, $t2, $s1
	lw  $s1, 0($t2)
	
	la $t5, S2
	
	add $t3, $zero, $t5
	add $s2, $s2, $s2
	add $s2, $s2, $s2
	add $t3, $t3, $s2
	lw  $s2, 0($t3)
	
	la $t5, S3
	
	add $t4, $zero, $t5
	add $s3, $s3, $s3
	add $s3, $s3, $s3
	add $t4, $t4, $s3
	lw  $s3, 0($t4)
	
	sll $s0, $s0, 12
	sll $s1, $s1, 8
	sll $s2, $s2, 4
	
	or $s0, $s0, $s1
	or $s0, $s0, $s2
	or $s0, $s0, $s3

	move $v0, $s0
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	jr $ra
	