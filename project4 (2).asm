.data
FPNum:		.word 0x0, 0xff800000, 0x7f800000 # Float-point numbers 0, -Infty and Infty

string1:  	.asciiz "Input a Float-Point #:(0 indicates the end)\n" 
array:		.space 4000

.text


main:		addi 	$s1, $zero, 0	# FP number counts in array 
		la 	$a1, array 	# $s1 = array address
		
		# Input a number 
InputLoop:	addi 	$v0, $zero, 4   # code for printing string is 4 
      		la 	$a0, string1 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
		addi 	$v0, $zero, 6   # code for reading FP number is 6 
   		syscall           	# call operating system  

		add.s 	$f1, $f0, $f10	# move input fp number to $f1
 		
 		c.eq.s	$f10, $f1	# 1) Add MIPS code to decide whether the input number is 0.0, 
 		bc1t Exit		# which indicates the end of input FP numbers and jump out of the InputLoop	
 					#(Currently there is no code to exit the loop)
 					
		s.s 	$f1, ($a1)
		addi 	$a1, $a1, 4
		addi 	$s1, $s1, 1
		j	InputLoop
		
Exit:		li 	$v0, 2           
		l.s 	$f12, ($a3)         
		syscall 
