.data
baseadd:  .word 43, -5, 11, -12, 64, -7, 14, 71, 103, 13, -27

string1:  .asciiz "Index i [0~10]:\n" 
string2:  .asciiz "Index j [0~10]:\n" 
string3:  .asciiz "\n A[i]=" 
string4:  .asciiz "\n A[j]=" 
string5:  .asciiz "\n A[i]+A[j]=" 
string6:  .asciiz "\n A[i]-A[j]=" 


.text
main:	
		# Read input i to $s1
		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string1 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
		addi $v0, $zero, 5      # code for reading integer is 5 
   		syscall           	# call operating system
   		add $s1, $v0, $zero  	# i in $s1
 
 		# Read input j to $s2
		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string2 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
   		# Write code here to read input j to $s2
   		addi $v0, $zero, 5      # code for reading integer is 5
   		syscall			# call operating command
   		add $s2, $v0, $zero	# j in $s2
   		
		
   		#baseadd of the array to $s5
   		la $s5, baseadd    	
  		
   		# Write code here to load A[i] to $s3
   					# $s5 = address start of A
   					# $s1 = i
   		sll $s1, $s1, 2		# $s1 = 4 * i
   		add $t2, $s5, $s1	# add offset to the address of A[0]
   					# $t2 = address of A[i]
   		lw $s3, 0($t2)		# $t3 = data in A[i]
   		# Print A[i] from $s3	
   		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string3 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 								   											   											
		add $a0, $s3, $zero	
		addi $v0,$zero,1	# prints integer
		syscall

		# Write code here to load and print A[j]
					# $s5 = address start of A
   					# $s2 = j
   		sll $s2, $s2, 2		# $s2 = 4 * i
   		add $t2, $s5, $s2	# add offset to the address of A[0]
   					# $t2 = address of A[i]
   		lw $s4, 0($t2)		# $t4 = data in A[i]
   		# Print A[i] from $s3	
   		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string4 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 								   											   											
		add $a0, $s4, $zero	
		addi $v0,$zero,1	# prints integer
		syscall
						
		# Write code here to compute and print A[i]+A[j]
		add $s5, $s4, $s3	# $s5 = A[i] + A[j]
   		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string5 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 								   											   											
		add $a0, $s5, $zero	
		addi $v0,$zero,1	# prints integer
		syscall	  

 		# Write code here to compute and print A[i]-A[j]	  
		sub $s5, $s3, $s4	# $s5 = A[i] - A[j]
   		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string5 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 								   											   											
		add $a0, $s5, $zero	
		addi $v0,$zero,1	# prints integer
		syscall	
		
		# exit	
		addi $v0, $zero, 10
		syscall 

		

