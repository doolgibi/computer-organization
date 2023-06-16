.data
	A: .space 400
	B: .space 400
	C: .space 400
	
	newline: .asciiz "\n"
	space: .asciiz " "
	
.macro getindex(%ans, %n, %i, %j)
	mul %ans, %i, %n
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.text
	li $v0, 5		# s0 = m1
	syscall
	move $s0, $v0
	
	li $v0, 5		# s1 = n1
	syscall
	move $s1, $v0
	
	li $v0, 5		# s2 = m2
	syscall
	move $s2, $v0
	
	li $v0, 5		# s3 = n2
	syscall
	move $s3, $v0
	
	li $t0, 0
	
A_i:
	beq $t0, $s0, A_i_end
	li $t1, 0
A_j:
	beq $t1, $s1, A_j_end
	
	getindex($t2, $s1, $t0, $t1)
	li $v0, 5
	syscall
	move $t3, $v0
	
	sw $t3, A($t2)
	add $t1, $t1, 1
	j A_j
A_j_end:
	add $t0, $t0, 1
	j A_i
A_i_end:
	li $t0, 0
B_i:
	beq $t0, $s2, B_i_end
	li $t1, 0
B_j:
	beq $t1, $s3, B_j_end
	
	getindex($t2, $s3, $t0, $t1)
	li $v0, 5
	syscall
	move $t3, $v0
	
	sw $t3, B($t2)
	add $t1, $t1, 1
	j B_j
B_j_end:
	add $t0, $t0, 1
	j B_i
B_i_end:
	sub $s4, $s0, $s2
	add $s4, $s4, 1
	
	sub $s5, $s1, $s3
	add $s5, $s5, 1
	sub $s6, $s5, 1
	sub $s7, $s4, 1
	
	li $t0, 0
i:
	beq $t0, $s4, i_end
	li $t1,0
j:
	beq $t1, $s5, j_end
	li $t2, 0
k:
	beq $t2, $s2, k_end
	li $t3, 0
l:
	beq $t3, $s3, l_end
	
	getindex($t4, $s5, $t0, $t1)
	lw $t5, C($t4)
	
	add $t6, $t0, $t2
	add $t7, $t1, $t3
	getindex($t8, $s1, $t6, $t7)
	lw $t8, A($t8)
	
	getindex($t6, $s3, $t2, $t3)
	lw $t6, B($t6)
	
	mul $t7, $t8, $t6
	add $t5, $t5, $t7
	sw $t5, C($t4)
	
	add $t3, $t3, 1
	j l
l_end:
	add $t2, $t2, 1
	j k
k_end:
	add $t1, $t1, 1
	j j
j_end:
	add $t0, $t0, 1
	j i
i_end:
	li $t0, 0
out_i:
	beq $t0, $s4, out_i_end
	li $t1, 0
out_j:
	beq $t1, $s5, out_j_end
	
	getindex($t2, $s5, $t0, $t1)
	lw $a0, C($t2)
	li $v0, 1
	syscall
if:
	beq $t1, $s6, then
else:
	la $a0, space
	li $v0, 4
	syscall
	j if_end
then:
	beq $t0, $s7, end
	la $a0, newline
	li $v0, 4
	syscall
if_end:
	add $t1, $t1, 1
	j out_j
out_j_end:
	add $t0, $t0, 1
	j out_i
out_i_end:
end:
	li $v0, 10
	syscall