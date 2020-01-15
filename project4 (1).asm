.data
FPNum:  .word 0x0, 0xff800000, 0x7f800000 # Float-point numbers 0, -Infty and Infty
array:  .space 4000  
prompt: .asciiz "Enter a number: " 
spacee: .asciiz " "
output: .asciiz "The numbers are: "
string1:.asciiz "Input a Float-Point #:(0 indicates the end)\n" 
string4:  .asciiz ", "
.text

main:
 		la 	$t0, FPNum
 		la 	$a1,array      	#load a pointer to array into $a1
		lwc1 	$f10, ($t0) 	# $f10=0.0
		addi 	$s1, $zero, 0	# FP number counts in array 
		li	$t6, 0		# Current offset
loop:
 		addi 	$v0, $zero, 4   # code for printing string is 4 
      		la 	$a0, string1 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
		addi 	$v0, $zero, 6   # code for reading FP number is 6 
   		syscall           	# call operating system  

		add.s 	$f1, $f0, $f10	# move input fp number to $f1
 		
 		c.eq.s	$f10, $f1	# 1) Add MIPS code to decide whether the input number is 0.0, 
 		bc1t 	loop1		# which indicates the end of input FP numbers and jump out of the InputLoop
 		
 		s.s	$f1, 0($a1)
 		addi	$a1, $a1, 4			
 		addi	$s1, $s1, 1	# Increments the counter
 		j	loop		
		
loop1:		addi	$t1, $s1, -1
		addi	$t2, $s1, -1
		la	$a1, array
		
		

loop2: 		beqz 	$t2,here     	#if $t2 is zero, goto here
 		addi 	$t2,$t2,-1   	#subtract 1 from $t2, save to $t2
 		l.s 	$f4,0($a1)     	#load an input int into $t5
 		l.s 	$f6,4($a1)     	#load the next one into $t6
 		addi 	$a1,$a1,4    	#add 4 to $a1, save to $a1
 		c.lt.s 	$f4,$f6
 		bc1t	loop2 		#if $t5 <= $t6, goto loop1
 		s.s 	$f4,0($a1)     	#else, store $t5 in $a1
 		s.s 	$f6,-4($a1)    	#and store $t6 in $a1-4 (swapping them)
 		bnez 	$s2,loop2    	#if $t2 is not zero, to go loop1

here:
 		la 	$a1,array     	#load array into $a1
 		addi 	$t1,$t1,-1   	#subtract 1 from $t1, save to $t1
 		add 	$t2,$t2,$t1   	#add $t2 to $t1, save to $t2
 		bnez 	$t1,loop2    	#if $t1 isn't zero, goto loop1
	 	li 	$v0,4          	#load 4 into $v0 (print string)
 		la 	$a0,output     	#load 'the numbers are' into $a0
 		syscall           	#display message to screen
 		la 	$a1,array      	#load array pointer into $a1
 		li 	$t1,10         	#load 10 into $t1

loop3:
 		addi $s1, $s1, -1	# You write the code here to print out the even numbers in the EvenArray. This is basically a for loop over $s4 elements in OddArray.
		l.s $f1, ($a1)		# The printed numbers are separted by ', ' as in string4 defined above.
 		li $v0, 2
    		mov.s $f12, $f1
    		syscall
    		addi $a1, $a1, 4
    		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string4 	# load address of string to be printed into $a0    
      		syscall  
    		bne $s1, $0, loop3

 		li 	$v0,10         	#exit

 		syscall
