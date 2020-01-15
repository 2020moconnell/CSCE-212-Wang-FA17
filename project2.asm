.data
baseadd:  .word 43, -5, 11, -12, 64, -7, 14, 71, 103, 13, -27

string1:  .asciiz "Index i [0~10]:\n" 
string2:  .asciiz "\n MIN=" 
string3:  .asciiz "\n MAX=" 

.text
main:	
		# Input i to $s1
		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string1 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 
		addi $v0, $zero, 5      # code for reading integer is 5 
   		syscall           	# call operating system
   		add $s1, $v0, $zero  	# i in $s1
    		
   		#baseadd of the array to $s5
   		la $s5, baseadd   
   		
   		#Load A[0] to initialize MIN ($s6) and MAX ($s7)
   		lw $s6, ($s5)
   		lw $s7, ($s5) 	
  		
  		# initialize j=0 (j in $t1)
  		add $t1, $zero, $zero
 
 loop1:
 		ble $t1, $s1, loop2	# If j is less than or equal to i then move into loop2
 		j Exit
 loop2:
 		sw   $s2, ($s5)		# Sets $s2 as temp value of baseadd[j]
 		addi $s0, $0, 4
 		mult $s5, $s0 
 		move $s2, $t1 
  		bge  $s2, $s7, setMax	# If the value at baseadd[j] is greater than the current max, replace
  		ble  $s2, $s6, setMin	# If the value at baseadd[j] is less than current min, replace
  		addi $t1, $t1, 1	#If no case was matched increment j
  		move $s2, $0		# Sets $s2 back to 0
  		j loop1
 	 	
 setMax:
 		move $s7, $s2		# Moves the value from $s2 into $s7
 		move $s2, $0		# Sets $s2 back to 0
 		addi $t1, $t1, 1 	#Increments the counter
  		j loop1
  		
 setMin:
 		move $s6, $s2		# Moves the value from $s2 into $s6
 		move $s2, $0		# Sets $s2 back to 0
 		addi $t1, $t1, 1 	#Increments the counter
  		j loop1

 
   		# while (j<=i)
  		#	{
  		#	if A[j]<MIN
  		#		MIN=A[j];
  		#	if A[j]>MAX
  		#		MAX=A[j];
  		#	j=j+1;
  		#	}	
   
     		# Print MIN from s6	
  Exit: 	addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string2 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 								   											   											
		add $a0, $s6, $zero	
		addi $v0,$zero,1	# prints integer
		syscall

    		# Print MAX from s7	
   		addi $v0, $zero, 4      # code for printing string is 4 
      		la $a0, string3 	# load address of string to be printed into $a0    
      		syscall         	# call operating system 								   											   											
		add $a0, $s7, $zero	
		addi $v0,$zero,1	# prints integer
		syscall

		# exit	
		addi $v0, $zero, 10
		syscall 

		

