.data
	a: .asciiz "A"
	bb: .asciiz "B"
	c: .asciiz "C"
	movedisk: .asciiz "move disk "
	from: .asciiz " from "
	to: .asciiz "to "
	newline: .asciiz "\n"
	


.text
main:
	li $v0, 5
	syscall
	move $a0, $v0
	
	lb $a1, a
	lb $a2, bb
	lb $a3, c
	
	li $t0, 0
	jal hanoi
	
	li $v0, 10
	syscall
hanoi:
	addi $sp, $sp, -20
	sw $ra, 0($sp)	#base
	sw $s0, 4($sp)	#from
	sw $s1, 8($sp)	#via
	sw $s2, 12($sp)	#to
	sw $s3, 16($sp)	
	
	move $s0, $a0	# s0= a0= n
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	
	beq $s0, $t0, end
	
recur:
	addi $s0, $s0, -1
	addi $a0, $s0, -1
	move $a1, $s1
	move $a2, $s3
	move $a3, $s2
	
	jal hanoi
	
	### printf
	li $v0, 4
	la $a0, movedisk
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 4
	la $a0, from
	syscall
	li $v0, 11
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, to
	syscall
	li $v0, 11
	move $a0, $s2
	syscall
		
	li $v0, 4
	la $a0, newline
	syscall
	
	beq $s0, $t0, end
	addi $a0, $s0, -1
	move $a1, $s3
	move $a2, $s2
	move $a3, $s1
	
	jal hanoi

end:
	lw $ra, 0($sp)	#base
	lw $s0, 4($sp)	#from
	lw $s1, 8($sp)	#via
	lw $s2, 12($sp)	#to
	lw $s3, 16($sp)	
	addi $sp, $sp, 20
	jr $ra
