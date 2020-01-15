.data
OddArray:  .space 100
EvenArray: .space 100

string1:  .asciiz "Input a Number:\n" 
string2:  .asciiz "\n Odd #'s: " 
string3:  .asciiz "\n Even #'s: " 
string4:  .asciiz ", "

.text
main:	
		addi $s2, $zero, 99999	# Indicator for stop input new number
		addi $s3, $zero, 0	# Initialize # of input odd numbers
		addi $s4, $zero, 0	# Initialize # of input even numbers
		la $s5, OddArray	# BaseAddress of Odd Array
		la $s6, EvenArray	# BaseAddress of Even Array
		
		# Read input number until 99999 is input. 99999 is the indicator of the end and it will not be counted as an input number.
InputLoop:	addi $v0, $zero, 4     # code for printing string is 4 
      		la $a0, string1 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
		addi $v0, $zero, 5     # code for reading integer is 5 
   		syscall           	# call operating system
   		add $s1, $v0, $zero  	# input into $s1
   		
   		beq $s1, $s2, ExitLoop # No more input if 99999 is input
   			
  			
   		andi $s7, $s1, 1	# You write code here to decide whether the input is odd or even
   		beq $s7, $zero, Even	# If it is odd, store into the odd array, move to the next space and increase $s3, the count of the odd numbers.
   		sll $t2, $s3, 2		# If it is even, store into the even array, move to the next space and increase $s4, the count of the even numbers.
		add $t2, $t2, $s5
		sw $s1, ($t2)
		addi $s3, $s3, 1
		j InputLoop
		
Even:		sll $t2, $s4, 2
		add $t2, $t2, $s6
		sw $s1,($t2)
		addi $s4, $s4, 1
		j InputLoop

ExitLoop:
		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string2 	# load address of string to be printed into $a0    
      		syscall  
      		beq $s3, $0, Skip
      		
PrintLoop:	
 		addi $s3, $s3, -1	# You write the code here to print out the odd numbers in the OddArray. This is basically a for loop over $s3 elements in OddArray.
 		lw $t1, ($s5)		# The printed numbers are separted by ', ' as in string4 defined above.
    		li $v0, 1
    		move $a0, $t1
    		syscall
    		addi $s5, $s5, 4
    		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string4 	# load address of string to be printed into $a0    
      		syscall 
    		bne $s3, $0, PrintLoop
 		
Skip: 		     		     		
		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string3 	# load address of string to be printed into $a0    
      		syscall  
      		beq $s4, $0, Skip1
      		
PrintLoop2:	addi $s4, $s4, -1	# You write the code here to print out the even numbers in the EvenArray. This is basically a for loop over $s4 elements in OddArray.
		lw $s1, ($s6)		# The printed numbers are separted by ', ' as in string4 defined above.
 		li $v0, 1
    		move $a0, $s1
    		syscall
    		addi $s6, $s6, 4
    		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string4 	# load address of string to be printed into $a0    
      		syscall  
    		bne $s4, $0, PrintLoop2
 		
Skip1:		# exit	
		addi $v0, $zero, 10
		syscall 

		

