org 00h
	sjmp main
	org 10h
	DISP1:db 'MicroController'
	DISP2:db 'KIRAN'
	DISP3:db 'AMC_LAB'
;;	DISP4:db 'HELLO'

org 60h
main: mov p1,#0xFF
     Acall INIT_LCD
back:acall readinput
	acall display
	sjmp back
 INIT_LCD:
        ACALL   DELAY3reg
        MOV     R0, #0x38
        ACALL   INST_LCD
        ACALL   DELAY3reg
        MOV     R0, #0x38
        ACALL   INST_LCD
        ACALL   DELAY3reg
        MOV     R0, #0x38
        ACALL   INST_LCD
        ACALL   DELAY3reg
        MOV     R0, #0xF
        ACALL   INST_LCD
to_clear:  ACALL   DELAY2reg
		MOV     R0, #0x1
        ACALL   INST_LCD
        ACALL   DELAY2reg
        RET


INST_LCD:
		
        CLR     P3.7
        CLR     P3.6
        
        MOV     P2, R0
        
        SETB    P3.5
        ACALL   DELAY2reg
        CLR     P3.5
        
        RET
        
DATA_LCD:
        SETB    P3.7
        CLR     P3.6
        
        MOV     P2, R0
        
        SETB    P3.5
        ACALL   DELAY2reg
        CLR     P3.5
      RET
readinput: mov a,p1
		   anl a,#0x03
		   mov r4,a
		   ret
display: cjne r4,#0,n0
		 acall display1
		 acall last
		 n0:cjne r4,#1,n1
		 acall display2
		 acall last
		  n1:cjne r4,#2,n2
		 acall display3
		 acall last
		  n2: acall to_clear
		  last:
		  ret

display1: mov dptr,#disp1
		  mov r1,#0
		  b1:  mov a,r1
		  movc a,@a+dptr
		  mov r0,a 
		  acall DATA_LCD
		  inc r1
		  cjne r1,#0x0f,b1
		  ACALL to_clear
		  ret
		  
display2: mov dptr,#disp2
		  mov r1,#0
		  b2:  mov a,r1
		  movc a,@a+dptr
		  mov r0,a 
		  acall DATA_LCD
		  inc r1
		  cjne r1,#0x05,b2
		   ACALL to_clear
		  ret
		  
display3: mov dptr,#disp3
		  mov r1,#0
		  b3:  mov a,r1
		  movc a,@a+dptr
		  mov r0,a 
		  acall DATA_LCD
		  inc r1
		  cjne r1,#0x07,b3
		   ACALL to_clear
		  ret
	DELAY3reg:
        DJNZ    R4, DELAY3reg
        DJNZ    R5, DELAY3reg
        ;DJNZ    R6, DELAY3reg
        RET
        
DELAY2reg:
        DJNZ    R4, DELAY2reg
        DJNZ    R5, DELAY2reg
		;DJNZ    R6, DELAY2reg
		
        RET
END	
