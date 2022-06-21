# SEDEN DENIZ TASKIN (sedendeniz)
# GIRAY COSKUN (giraycoskun)

.data

prompt0: .asciiz  "\nProgram is Running\n"
prompt1: .asciiz  "\n Plain (Input) Text \n"
prompt2: .asciiz  "\n Cipher (Encrypted) Text \n"
prompt3: .asciiz  "\n Plain (Decrypted) Text \n"
prompt4: .asciiz  " - "
prompt5: .asciiz  "\n"

initial_vectors: 	.word 0x3412, 0x7856, 0xBC9A, 0xF0DE
keys: 			.word 0x2301, 0x6745, 0xAB89, 0xEFCD, 0xDCFE, 0x98BA, 0x5476, 0x1032
state_vectors: 		.word 0xb8e7, 0x2d36, 0xb912, 0x0186, 0x87c3, 0x9fda, 0xa855, 0x7f84
plain_text: 		.word 0, 0, 0, 0, 0, 0, 0, 0
cipher_text:		.word 0, 0, 0, 0, 0, 0, 0, 0
decrypted_text:		.word 0, 0, 0, 0, 0, 0, 0, 0
temp: 			.word 0, 0, 0, 0, 0, 0, 0, 0

# 4352 13090 21828 30566 39304 48042 56780 65518

.text

main:
	la $a0, prompt0
	li $v0, 4
	syscall
	
	##INPUT##
	add $s0, $zero, $zero
	la $s1, plain_text
inputLoop:
	
	li $v0, 5
      	syscall		
      	move $t0, $v0
	
	add $t2, $s0, $s0
	add $t2, $t2, $t2
	add $t2, $t2, $s1
	
	sw $t0, 0($t2)
	
	addi $s0, $s0, 1
	bne $s0, 8, inputLoop
	
	#########
	
	##PRINT PLAINTEXT##
	la $a0, prompt1
	la $a1, plain_text
	jal print
	
	#########
	
	##ENCRYPTION##
	
	add $s0, $zero, $zero
encLoop:
	add $t2, $s0, $s0
	add $t2, $t2, $t2
	la $t0, plain_text
	add $t2, $t2, $t0
	lw $a0, 0($t2)
	la $a1, keys
	la $a2, state_vectors
	la $a3, temp
	jal encryption
	move $s1, $v0
	
	add $t2, $s0, $s0
	add $t2, $t2, $t2
	la $t0, cipher_text
	add $t2, $t2, $t0
	sw $s1, 0($t2)
	
	addi $s0, $s0, 1
	bne $s0, 8, encLoop
	
	#########
	
	##PRINT CIPHER TEXT##
	la $a0, prompt2
	la $a1, cipher_text
	jal print
	
	#########
	
	
	##INITIALIZATION##
	la $a0, initial_vectors
	la $a1, keys
	la $a2, state_vectors
	la $a3, temp
	
	jal initialization
	#########
	
	##DECRYPTION##
	add $s0, $zero, $zero
decLoop:

	add $t2, $s0, $s0
	add $t2, $t2, $t2
	la $t0, cipher_text
	add $t2, $t2, $t0
	lw $a0, 0($t2)
	la $a1, keys
	la $a2, state_vectors
	la $a3, temp
	jal decryption
	move $s1, $v0
	
	add $t2, $s0, $s0
	add $t2, $t2, $t2
	la $t0, decrypted_text
	add $t2, $t2, $t0
	sw $s1, 0($t2)
	
	addi $s0, $s0, 1
	bne $s0, 8, decLoop
	#########
	
	##PRINT DECRYPTED TEXT##
	la $a0, prompt3
	la $a1, decrypted_text
	jal print
	
	#########
	
	
	li $v0, 10
	syscall
 
 print:
 	#a0 -> prompt title
 	#a1 -> array to print
 	
 	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	move $s1, $a0
 	move $s2, $a1
 	
 	add $s0, $zero, $zero
 	move $a0, $s1
 	li $v0, 4
      	syscall	
      	
 printLoop:
 	
	add $t2, $s0, $s0
	add $t2, $t2, $t2
	add $t2, $t2, $s2
	
	lw $t0, 0($t2)
	
	move $a0, $t0
	li $v0, 34
	syscall
	
	la $a0, prompt4
	li $v0, 4
	syscall
	
	move $a0, $t0
	li $v0, 1
	syscall
	
	la $a0, prompt5
	li $v0, 4
	syscall
	
	
	addi $s0, $s0, 1
	bne $s0, 8, printLoop
 	
 	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16	
	jr $ra