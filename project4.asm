.data
FPNum:  .word 0x0, 0xff800000, 0x7f800000 # Float-point numbers 0, -Infty and Infty

string1:  .asciiz "Input a Float-Point #:(0 indicates the end)\n" 
string2:  .asciiz "\n MAX:" 
string3:  .asciiz "\n MIN:"
string4:  .asciiz "\n SUM:"
vals:	  .space 4000

.text
main:	
		la $t0, FPNum
		la   $a1, vals		#base addr of the array
		lwc1 $f10, ($t0) 	# $f10=0.0	
		#lwc1 $f4, ($t0)	# SUM =0
		#lwc1 $f5, 4($t0)	# MAX=-InftY
		#lwc1 $f6, 8($t0)	# MIN=Infty
				
		addi $s1, $zero, 0	# FP number counts in array 
		
		# Input a number 
InputLoop:	li   $t0, 0
		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string1 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
		addi $v0, $zero, 6      # code for reading FP number is 6 
   		syscall           	# call operating system  

		add.s $f1, $f0, $f10	# move input fp number to $f1
 		
 		  		
 		# Tasks:
 		
 		c.eq.s	$f10, $f1	# 1) Add MIPS code to decide whether the input number is 0.0, 
 		bc1t Exit		# which indicates the end of input FP numbers and jump out of the InputLoop	
 					#(Currently there is no code to exit the loop)

		s.s	$f1, 0($t0)
		addi	$t0, $t0, 4
		addi	$t1, $t1, 1
		j	InputLoop
		#add.s $f4, $f4, $f1	# adds to SUM
 		#c.lt.s $f1, $f6	# checks to see if current is less than min
 		#bc1t setMin		# jumps to setMin
 		#c.lt.s $f1, $f5	# checks to see if current is less than max
 		#bc1f setMax		# if false jump to setMax

Iter: 		blt 	$a1,

Swap:		lw	
				


		# Print out the values of MAX, MIN, and SUM			
Exit:		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string2 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
		addi $v0, $zero, 2      # code for printing FP number is 2
		add.s $f12, $f5, $f10 
   		syscall           	# call operating system  
   		
 		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string3 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
		addi $v0, $zero, 2      # code for printing FP number is 2
		add.s $f12, $f6, $f10 
   		syscall           	# call operating system  
 
   		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string4 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
		addi $v0, $zero, 2      # code for printing FP number is 2
		add.s $f12, $f4, $f10 
   		syscall           	# call operating system  
  			  		
		addi $v0, $zero, 10
		syscall 
