TITLE Boolean Calculator (Boolean Calculator.asm)
;Luis Selvera


INCLUDE Irvine32.inc

.data
caseTable byte '1'        ;lookup value
          dword AND_op ;address of lookup value
		  byte '2'       
          dword NAND_op 
		  entrySize = ($ - caseTable )
          byte '3'
          dword OR_op
		  byte '4'
          dword NOR_op
          byte '5'
          dword NOT_op
          byte '6'
          dword XOR_op
		  byte '7'
          dword XNOR_op
          byte '8'
          dword Exit_op
numberOfEntries = 8
   
msgSelMn  byte "       32-Bit Boolean Calculator"     ,0dh,0ah
	  byte "1. x AND y"     ,0dh,0ah
	  byte "2. x NAND y"     ,0dh,0ah
	  byte "3. x OR y"      ,0dh,0ah
	  byte "4. x NOR y"      ,0dh,0ah
	  byte "5. NOT x"       ,0dh,0ah
	  byte "6. x XOR y"     ,0dh,0ah
	  byte "7. x XNOR y"     ,0dh,0ah
	  byte "8. Exit Program",0dh,0ah
	  byte "-------------------------------------",0dh,0ah
          byte "Please enter selection 1,2,3,4,5,6,7 or 8: ",0
msg1      byte "1.) x AND y",0dh,0ah,0
msg2	  byte "2.) x NAND y",0dh,0ah,0
msg3      byte "3.) x OR y",0dh,0ah,0
msg4      byte "4.) x NOR y",0dh,0ah,0
msg5      byte "5.) NOT x",0dh,0ah,0
msg6      byte "6.) x XOR y",0dh,0ah,0
msg7      byte "7.) x XNOR y",0dh,0ah,0
msg8      byte "8.) Exit ",0dh,0ah,0
InputHexX byte "Please enter hexadecimal operand x:",0
HexX	dword ?
InputHexY byte "Please enter hexadecimal operand y:",0
HexY	dword ?
HexAnswer byte "The 32-bit Hexadecimal result is:",0

.code
main PROC

        call Clrscr              
        call Menu                ;menu procedure

ExitProg::exit                   ;global label to exit
main ENDP

;------------------------------------------------
Menu PROC

	mov  edx,OFFSET msgSelMn 		;ask  for input
	call WriteString         
	call ReadChar		 			;read one character
	call Crlf
	call Crlf
        mov  ebx,OFFSET caseTable	;point EBX to the table
	mov  ecx,numberOfEntries 		;loop counter

        L1:
	cmp  al,[ebx]		 			;match found?
	jne  L2		         			;no: continue
	call NEAR PTR [ebx + 1]	 		;yes: call the procedure
	call Crlf                
	call WaitMsg             
	call Clrscr              
	jmp  L3		         			;exit the search
        L2:
	add  ebx,5						;point to the next entry
	loop L1		         			;repeat until ECX = 0

        L3:
		call Clrscr
	jmp Menu	         			;run Menu again

Menu EndP

;------------------------------------------------
AND_op PROC 
;
; Receives: 2 inputs HexX & HexY
; Returns: AND between HexX & HexY
;------------------------------------------------
	call Crlf  
	mov  edx,OFFSET msg1     
	call WriteString              
	call Crlf
	call InputInfo
	mov eax, HexX
	and eax, HexY
	mov edx, OFFSET HexAnswer
	
	call WriteString
	call Crlf
	call WriteHex
	
	call Crlf       
	
	ret                      ;return
AND_op ENDP

;------------------------------------------------
NAND_op PROC 
;
; Receives: 2 inputs HexX & HexY
; Returns: AND between HexX & HexY
;------------------------------------------------
	call Crlf  
	mov  edx,OFFSET msg2   
	call WriteString             
	call Crlf
	call InputInfo
	mov eax, HexX
	and eax, HexY
	not eax
	mov edx, OFFSET HexAnswer
	
	call WriteString
	call Crlf
	call WriteHex
	
	call Crlf                
	ret                      ;return
NAND_op ENDP

;------------------------------------------------
OR_op PROC
;
; Receives: 2 inputs HexX & HexY
; Returns: OR between HexX & HexY
;------------------------------------------------
	call Crlf  
	mov  edx,OFFSET msg3   
	call WriteString
	call Crlf    	;endl
	call InputInfo
	mov eax, HexX
	or eax, HexY
	mov edx, OFFSET HexAnswer
	call WriteString
call Crlf
	call WriteHex
	
	call Crlf                
	ret                      ;return
OR_op ENDP

;------------------------------------------------
NOR_op PROC
;
; Receives: 2 inputs HexX & HexY
; Returns: OR between HexX & HexY
;------------------------------------------------
	call Crlf  
	mov  edx,OFFSET msg4   
	call WriteString
	call Crlf    	;endl
	call InputInfo
	mov eax, HexX
	or eax, HexY
	not eax
	mov edx, OFFSET HexAnswer
	call WriteString
call Crlf
	call WriteHex
	
	call Crlf                
	ret                      ;return
NOR_op ENDP

;------------------------------------------------
NOT_op PROC
;
; Receives only 1 input: HexX
; Returns: Not of HexX 
;------------------------------------------------
	call Crlf  
	mov  edx,OFFSET msg5
	call WriteString
	call Crlf                ;endl
	
	mov edx, OFFSET InputHexX
	call WriteString
	call ReadHex
	call WriteHex
	not eax
	call Crlf
	mov edx, OFFSET HexAnswer
	call WriteString
	call Crlf
	call WriteHex
	
	call Crlf                
	ret                      ;return
NOT_op ENDP

;------------------------------------------------
XOR_op PROC
;
; Receives: 2 inputs HexX & HexY
; Returns: XOR between HexX & HexY
;------------------------------------------------
	call Crlf
	mov  edx,OFFSET msg6
	call WriteString
	call Crlf 	;endl
	call InputInfo
	mov eax, HexX
	xor eax, HexY
	mov edx, OFFSET HexAnswer
	call WriteString
	call Crlf
	call WriteHex
	
	call Crlf               
	ret                      ;return
XOR_op ENDP

;------------------------------------------------
XNOR_op PROC
;
; Receives: 2 inputs HexX & HexY
; Returns: XOR between HexX & HexY
;------------------------------------------------
	call Crlf
	mov  edx,OFFSET msg7
	call WriteString
	call Crlf 	;endl
	call InputInfo
	mov eax, HexX
	xor eax, HexY
	not eax
	mov edx, OFFSET HexAnswer
	call WriteString
	call Crlf
	call WriteHex
	
	call Crlf                
	ret                      ;return
XNOR_op ENDP

;------------------------------------------------
Exit_op PROC
; Exits program
; Sets CF = 1 to signal end of program
;------------------------------------------------
	mov  edx,OFFSET msg8
	call Crlf                
	call Crlf                
	call WriteString	 
	call Crlf               
	stc	                 ;CF = 1
	jc ExitProg    	         ;if CF=1 then jump to Global ExitProg

Exit_op ENDP

;------------------------------------------------
InputInfo PROC USES edx
; Inputs HexX & HexY
; Returns the operands
;------------------------------------------------
	mov edx,OFFSET InputHexX
	call WriteString
	call ReadHex
	call WriteHex
	mov HexX, eax
	 call Crlf
	
	mov edx, OFFSET InputHexY
	call WriteString
	call ReadHex
	call WriteHex
	mov HexY, eax
	
	call Crlf
	ret
	InputInfo ENDP


END main