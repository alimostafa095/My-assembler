
INCLUDE Irvine32.inc
.data
welcome byte '		Welcome To My Assembler ',0
enter_instruction BYTE 'Enter your instruction : ',0
message BYTE '		The instruction is not supported ',0
all_instruction BYTE 'INC/DEC/MUL/DIV/MOV/ADD/SUB/CALL/'
temp_eax BYTE 'EAX',0
temp_ebx BYTE 'EBX',0
temp_ecx BYTE 'ECX',0
temp_edx BYTE 'EDX',0
temp_esi BYTE 'ESI',0
temp_edi BYTE 'EDI',0
temp_esp BYTE 'ESP',0
temp_ebp BYTE 'EBP',0
temp_call BYTE  'DUMPREGS',0

register_eax DWORD ?         
register_ebx DWORD ?
register_edx DWORD ?
register_ecx DWORD ?
register_esi DWORD ?
register_edi DWORD ?


want_continuo1 BYTE 'Y',0
your_choice byte 'Y',0
want_continuo2 BYTE 'If you want continuo Enter yes to exit Enter no : ',0


instruction BYTE 100 dup(?)           ;;;;; de el instruction ele h2raha mn el user 
my_instruction BYTE 100 dup(?)      ;;;; ed ele bykon feha el instruction b3d mshel mno el space w de ele hsht8al beha 
length_of_instruction BYTE 1           ;;;;;;;;;; length el string ele b2rah // initialize be one 3lshan lmya bysfar el my_instruction awel mara 
instruction_Name BYTE 10 dup(?)      ;;;; h7ot feha esm el instruction bta3e 
temp BYTE 10 dup(?)
the_end BYTE '		Thank You To Use My Assembler :D',0

	;your data goes here
.code
main PROC
mov register_eax , eax
mov register_ebx , ebx
mov register_edx , edx
mov register_ecx , ecx
mov register_esi , esi
mov register_edi , edi

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; inshltize ll trmplet memory bta3e 
 mov edx , offset welcome
 call writestring
 call crlf
 call crlf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; de b2lo welcome bas 
to_continuo:
mov esi , offset want_continuo1     
mov edi , offset your_choice                          ;;;;;;;;;;;; dol 3lshan lma kont bs2al YES OR NO 
cmpsb 
jne exitt
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov esi , offset my_instruction
mov cl , length_of_instruction
empty:
mov al , ','
mov [esi],al
inc esi
loop empty
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; b fdet my instruction 3lshan lma akteb 3leh tane 
mov edx , offset enter_instruction
call writestring
mov ecx , lengthof instruction
mov edx , offset instruction
call readstring
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; bkteb (enter instruction ) w b2raha mn el user
mov length_of_instruction ,al
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 7tet tol el instruction fe (length_of_instruction)
mov edi , offset instruction
mov cl , length_of_instruction
mov bl , ' '
com:
mov al , [edi]
cmp al , ';'
je com2
inc edi
loop com
com2:
jmp no_comment        ;;; 3lshan lw mfesh comment by8yarsh el dei 
mov [edi],bl
inc edi
loop com2
no_comment:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;shelt el comment mn el instruction b3te 
mov esi , offset instruction
mov edi , offset my_instruction
mov cl , length_of_instruction
LL :
mov al , [esi]
cmp al , ' '           ;;; comper lw howa space 
je LLw
cmp al , '	'
je LLw
mov [edi] , al
inc esi
inc edi
loop LL
jmp LLe
LLw:
inc esi
dec length_of_instruction    ;;;;; b3mel dec ll length hena 3lshan b3d keda f el mul aw el add lma age a5od ele b3d el ( , ) akon 3arf  
dec ecx                      ;;;;; howa kam rakam 
cmp ecx , 0       ;;;; hena 3lshan y3mel comper hya el loop 5lset wala lesa 
je LLe
jmp LL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; bshel el spase w el tab w b7ot el instruction fe (my_instruction)
LLe:
mov cl , length_of_instruction
mov esi , offset my_instruction
capital :
mov al , [esi]
cmp al , ","
je LLee
and al , 11011111b
mov [esi] , al
inc esi
loop capital
jmp dig      ;;;;;;; 3lshan lma y5las y5rog 
LLee:
inc esi 
call is_digit
je dig          ;;;;;;; lw l2aha rakam hynot y5rog
dec ecx
jmp capital
dig:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; b7wel my_instruction kolo l capital l7ad abl el 3lama 
mov ecx , 3
mov esi , offset my_instruction
mov edi , offset instruction_Name
mov dl , 'C'
cmp [esi] , dl
jne oo
add ecx , 1
oo:
mov al ,[esi]
mov [edi] ,al
inc esi
inc edi
loop oo 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; fslt esm el instruction ele el user md5lo fe (instruction_Name) 
mov esi , offset all_instruction
mov edi , offset temp
mov cl , lengthof all_instruction-5
LL2 :
mov al , [esi]
cmp al , '/'
je l2
mov [edi] , al
inc esi
inc edi
loop LL2
jmp message_not
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; by2ta3 el all_instruction w kol mara by7ot f el (temp) el instruction 
L2:
push esi 
push ecx
mov ecx , length instruction_Name
mov esi , offset temp
mov edi , offset instruction_Name
CLD
repZ cmpsb 
je next 
mov edi , offset temp
pop ecx
pop esi 
INC esi
jmp LL2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; btshof el instruction da mwgod wala l2 
next :
pop ecx 
cmp ecx , 25
jne w1
call instruction_INC
w1: 
cmp ecx , 22
jne w2
call instruction_DEC
w2 :
cmp ecx , 19
jne w3 
call instruction_MUL
w3:
cmp ecx , 16
jne w4
call instruction_DIV
w4:
cmp ecx , 13
jne w5
call instruction_MOV
w5:
cmp ecx , 10
jne w6
call instruction_ADD
w6 :
cmp ecx , 7
jne w7
call instruction_SUB
w7:
cmp ecx , 3
jne w8
call instruction_CALL
w8:
jmp continuo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; byro7 lel instruction  ele e5trto

message_not :   ;;;;;;;;;;; de ele btole el insturction ele d5le 8lat 
mov edx ,offset message
call writestring
call crlf

continuo :
call crlf 
mov edx ,offset want_continuo2
call writestring
mov edx , offset your_choice
mov ecx,2
call readstring
call crlf
mov edi , offset your_choice
mov al , [edi]
and al , 11011111b
mov [edi] , al

jmp to_continuo 

 exitt:
mov edx , offset the_end
call writestring
call crlf


	;your code goes here 
	exit
	call crlf
 mov edx , offset the_end
 call writestring
 call crlf
main ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instruction_INC PROC
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne inc_2
INC register_eax
ret
;;;;;;;;;;;;;;;;;;;;; inc eax
inc_2:
mov esi , offset my_instruction + 3  
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne inc_3
INC register_ebx
ret
;;;;;;;;;;;;;;;;; inc ebx
inc_3:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne inc_4
INC register_ecx
ret
;;;;;;;;;;;;;;;;;;; inc ecx
inc_4:
mov esi , offset my_instruction + 3  
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne inc_5
INC register_edx
ret
;;;;;;;;;;;;;;;;;;; inc edx
inc_5 :
mov esi , offset my_instruction + 3  
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne inc_6
INC register_esi
ret
;;;;;;;;;;;;;;;;;;;;;; inc esi
inc_6 :
mov esi , offset my_instruction + 3
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne INC_7
INC register_edi
ret
;;;;;;;;;;;;;;;;;;;;;; inc edi
inc_7 :
mov esi , offset my_instruction + 3
mov cl , 3
mov edi , offset temp_esp  
CLD
repz cmpsb
jne  INC_8
INC esp

ret
;;;;;;;;;;;;;;;;;;;;;; inc esp
inc_8:
mov esi , offset my_instruction + 3
mov cl , 3
mov edi , offset temp_ebp  
CLD
repz cmpsb
jne  message_not2
INC ebp
ret
instruction_INC ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;INC_Ebp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



instruction_DEC PROC
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne DEC_2
DEC eax
mov  register_eax , eax
ret
;;;;;;;;;;;;;;;; DEC eax
DEC_2:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne DEC_3
DEC ebx
mov  register_ebx , ebx
ret
;;;;;;;;;;;;;;;;; DEC ebx
DEC_3:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne DEC_4
DEC ecx
mov  register_ecx , ecx
ret
;;;;;;;;;;;;;;;;;;; DEC ecx
DEC_4:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne DEC_5
DEC edx
mov  register_edx , edx
ret
;;;;;;;;;;;;;;;;;;; DEC edx
DEC_5 :
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne DEC_6
DEC esi
mov  register_esi , esi
ret
;;;;;;;;;;;;;;;;;;;;;; DEC esi
DEC_6 :
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne DEC_7
DEC edi
mov  register_edi , edi
ret
;;;;;;;;;;;;;;;;;;;;;; DEC edi
DEC_7 :
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_esp  
CLD
repz cmpsb
jne DEC_8
DEC esp
ret
;;;;;;;;;;;;;;;;;;;;;; DEC esp
DEC_8 :
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ebp  
CLD
repz cmpsb
jne message_not2
DEC ebp
ret
instruction_DEC ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DEC_EBP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instruction_MUL PROC
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne MUL_2
mov eax , register_eax
mov edx , register_edx
MUL register_eax
mov register_eax , eax
mov register_edx , edx
ret
;;;;;;;;;;;;;;;;;;;;;; MUL eax
MUL_2:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne MUL_3
mov eax , register_eax
mov edx , register_edx
MUL register_ebx
mov register_eax , eax
mov register_edx , edx
ret
;;;;;;;;;;;;;;;;;;;;;; MUL ebx
MUL_3:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne MUL_4

mov eax , register_eax
mov edx , register_edx
MUL register_edx
mov register_eax ,eax
mov register_edx ,edx
ret
;;;;;;;;;;;;;;;;;;;;;; MUL edx
MUL_4:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne MUL_5
mov eax , register_eax
mov edx , register_edx
MUL register_ecx
mov register_eax , eax
mov register_edx , edx
ret
;;;;;;;;;;;;;;;;;;;;;; MUL ecx
MUL_5:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne MUL_6
mov eax , register_eax
mov edx , register_edx
MUL register_esi
mov register_eax , eax
mov register_edx , edx
ret
;;;;;;;;;;;;;;;;;;;;;; MUL esi
MUL_6:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne MUL_7
mov eax , register_eax
mov edx , register_edx
MUL register_edi
mov register_eax , eax
mov register_edx , edx
ret
;;;;;;;;;;;;;;;;;;;;;; MUL edi
MUL_7:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_esp  
CLD
repz cmpsb
jne MUL_8
mov eax , register_eax
MUL esp
ret
;;;;;;;;;;;;;;;;;;;;;; MUL esp
MUL_8:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ebp  
CLD
repz cmpsb
jne message_not2
mov eax , register_eax
mov edx , register_edx
MUL ebp
mov register_eax , eax
mov register_edx , edx
ret
instruction_MUL ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;MUL_EBP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instruction_ADD PROC
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne ADD_2
inc esi 
call is_digit
jne add_10
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32
add register_eax , eax
mov eax , register_eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ADD eax , val
add_10:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne add_11
mov eax ,register_eax 
add register_eax , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add eax , eax
add_11:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne add_12
mov eax ,register_ebx 
add register_eax , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add eax , ebx
add_12:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne add_13
mov eax ,register_ecx 
add register_eax , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add eax , ecx
add_13:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne add_14
mov eax ,register_edx 
add register_eax , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add eax , edx
add_14:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne add_15
mov eax ,register_esi 
add register_eax , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add eax , esi
add_15:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne not_add_1
mov eax ,register_edi 
add register_eax , eax
not_add_1:
call message_not2
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add eax , edi
ADD_2:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne ADD_3
inc esi
call is_digit
jne add_16 
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32
add register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;; ADD EBX , val
add_16:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne add_17
mov eax ,register_eax 
add register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add ebx , eax
add_17:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne add_18
mov eax ,register_ebx 
add register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add ebx , ebx
add_18:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne add_19
mov eax ,register_ecx 
add register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add ebx , ecx
add_19:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne add_20
mov eax ,register_edx 
add register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add ebx , edx
add_20:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne add_21
mov eax ,register_esi 
add register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add ebx , esi
add_21:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne not_add_2
mov eax ,register_edi 
add register_ebx , eax
not_add_2:
call message_not2
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add ebx , edi
ADD_3:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne ADD_4
inc esi 
call is_digit
jne add_22
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32
add register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ADD EDX , val
add_22:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne add_23
mov eax ,register_eax 
add register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edx , eax
add_23:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne add_24
mov eax ,register_ebx 
add register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edx , ebx
add_24:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne add_25
mov eax ,register_ecx 
add register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edx , ecx
add_25:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne add_26
mov eax ,register_edx 
add register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edx , edx
add_26:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne add_27
mov eax ,register_esi 
add register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edx , esi
add_27:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne not_add_3
mov eax ,register_edi 
add register_edx , eax
not_add_3:
call message_not2
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edx , edi
ADD_4:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne ADD_5
inc esi
call is_digit
jne add_28
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32
add register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;ADD_ECX , val
add_28:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne add_29
mov eax ,register_eax 
add register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add ecx , eax
add_29:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne add_30
mov eax ,register_ebx 
add register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add ecx , ebx
add_30:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne add_31
mov eax ,register_ecx 
add register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add ecx , ecx
add_31:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne add_32
mov eax ,register_edx 
add register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add ecx , edx
add_32:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne add_33
mov eax ,register_esi 
add register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add ecx , esi
add_33:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne not_add_4
mov eax ,register_edi 
add register_ecx , eax
not_add_4:
call message_not2
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add ecx , edi
ADD_5:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne ADD_6
inc esi 
call is_digit
jne add_34
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32
add register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ADD_ESI , val
add_34:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne add_35
mov eax ,register_eax 
add register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add esi , eax
add_35:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne add_36
mov eax ,register_ebx 
add register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add esi , ebx
add_36:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne add_37
mov eax ,register_ecx 
add register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add esi , ecx
add_37:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne add_38
mov eax ,register_edx 
add register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add esi , edx
add_38:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne add_39
mov eax ,register_esi 
add register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add esi , esi
add_39:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne not_add_5
mov eax ,register_edi 
add register_esi , eax
not_add_5:
call message_not2
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add esi , edi
ADD_6:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne ADD_7
inc esi 
call is_digit
jne add_40
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32 
add register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ADD_EDI , val
add_40:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne add_41
mov eax ,register_eax 
add register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edi , eax
add_41:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne add_42
mov eax ,register_ebx 
add register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edi , ebx
add_42:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne add_43
mov eax ,register_ecx 
add register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edi , ecx
add_43:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne add_44
mov eax ,register_edx 
add register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edi , edx
add_44:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne add_45
mov eax ,register_esi 
add register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edi , esi
add_45:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne not_add_6
mov eax ,register_edi 
add register_edi , eax
not_add_6:
call message_not2
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edi , edi
ADD_7:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_esp  
CLD
repz cmpsb
jne ADD_8
inc esi 
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32 
add esp , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ADD_ESP
ADD_8:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ebp  
CLD
repz cmpsb
jne message_not2
inc esi 
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32 
add ebp , eax
ret
instruction_ADD ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ADD_EBP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



instruction_SUB PROC
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne SUB_2
inc esi 
call is_digit
jne sub_10
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32 
sub register_eax , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUB_EAX val
sub_10:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne sub_20
mov eax ,register_eax 
sub register_eax , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub eax , eax
sub_20:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne sub_30
mov eax ,register_ebx 
sub register_eax , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;sub eax , ebx
sub_30:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne sub_40
mov eax ,register_ecx 
sub register_eax , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub eax , ecx
sub_40:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne sub_50
mov eax ,register_edx 
sub register_eax , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub eax , edx
sub_50:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne sub_60
mov eax ,register_esi 
sub register_eax , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;sub eax , esi
sub_60:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne not_sub_1
mov eax ,register_edi 
sub register_eax , eax
not_sub_1:
call message_not2
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub eax , edi
;//////////////////////////////////////////////////
SUB_2:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne SUB_3
inc esi 
call is_digit
jne sub_70
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32
sub register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUB_EBX,val
sub_70:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne sub_80
mov eax ,register_eax 
sub register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub ebx , eax
sub_80:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne sub_90
mov eax ,register_ebx 
sub register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub ebx , ebx
sub_90:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne sub_100
mov eax ,register_ecx 
sub register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub ebx , ecx
sub_100:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne sub_11
mov eax ,register_edx 
sub register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub ebx , edx
sub_11:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne sub_12
mov eax ,register_esi 
sub register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub ebx , esi
sub_12:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne not_sub_2
mov eax ,register_edi 
sub register_ebx , eax
not_sub_2:
call message_not2
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub ebx , edi
;///////////////////////////////////////////////////////////
SUB_3:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne SUB_4
inc esi 
call is_digit
jne sub_13 
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32
sub register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUB_EDX val
sub_13:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne sub_14
mov eax ,register_eax 
sub register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub edx , eax
sub_14:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne sub_15
mov eax ,register_ebx 
sub register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub edx , ebx
sub_15:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne sub_16
mov eax ,register_ecx 
sub register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub edx , ecx
sub_16:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne sub_17
mov eax ,register_edx 
sub register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub edx , edx
sub_17:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne sub_18
mov eax ,register_esi 
sub register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub edx , esi
sub_18:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne not_sub_3
mov eax ,register_edi 
sub register_edx , eax
not_sub_3:
call message_not2
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub , edx,edi
SUB_4:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne SUB_5
inc esi 
call is_digit
jne sub_21
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32
sub register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;SUB_ECX , val
sub_21:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne sub_22
mov eax ,register_eax 
sub register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub ecx , eax
sub_22:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne sub_23
mov eax ,register_ebx 
sub register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub ecx , ebx
sub_23:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne sub_24
mov eax ,register_ecx 
sub register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub ecx , ecx
sub_24:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne sub_25
mov eax ,register_edx 
sub register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub ecx , edx
sub_25:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne sub_26
mov eax ,register_esi 
sub register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  sub ecx , esi
sub_26:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne not_sub_4
mov eax ,register_edi 
sub register_ecx , eax
not_sub_4:
call message_not2
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub ecx , edi
;//////////////////////////////////////////////////////////////
SUB_5:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne SUB_6
inc esi 
call is_digit
jne sub_31
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32
sub register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SUB_esi , val
sub_31:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne sub_32
mov eax ,register_eax 
sub register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub esi , eax
sub_32:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne sub_33
mov eax ,register_ebx 
sub register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub esi , ebx
sub_33:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne sub_34
mov eax ,register_ecx 
sub register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub esi , ecx
sub_34:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne sub_35
mov eax ,register_edx 
sub register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub esi , edx
sub_35:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne sub_36
mov eax ,register_esi 
sub register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub esi , esi
sub_36:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne not_sub_5
mov eax ,register_edi 
sub register_esi , eax
not_sub_5:
call message_not2
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub esi , edi
;//////////////////////////////////////////////////////////////////
SUB_6:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne SUB_7
inc esi 
call is_digit
jne sub_51
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32
sub register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;SUB_sdi,val
sub_51:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_eax  
CLD
repz cmpsb
jne sub_52
mov eax ,register_eax 
sub register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add edi , eax
sub_52:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ebx  
CLD
repz cmpsb
jne sub_53
mov eax ,register_ebx 
sub register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub edi , ebx
sub_53:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_ecx  
CLD
repz cmpsb
jne sub_54
mov eax ,register_ecx 
sub register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub edi , ecx
sub_54:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edx  
CLD
repz cmpsb
jne sub_55
mov eax ,register_edx 
sub register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub edi , edx
sub_55:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_esi  
CLD
repz cmpsb
jne sub_56
mov eax ,register_esi 
sub register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub edi , esi
sub_56:
mov esi , offset my_instruction + 7
mov cl , 3
mov edi , offset temp_edi  
CLD
repz cmpsb
jne not_sub_6
mov eax ,register_edi 
sub register_edi , eax
not_sub_6:
call message_not2
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; sub edi ,edi
SUB_7:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_esp  
CLD
repz cmpsb
jne SUB_8
inc esi 
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32 
sub esp , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;SUB_ESP
SUB_8:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ebp  
CLD
repz cmpsb
jne message_not2
inc esi 
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32 
sub ebp , eax
ret
instruction_SUB ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;SUB_EBP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;/@/@/@/@/@/@/@/@/@/@/@@/@/@/@/@/@/@/@/@/@/@/@/@/@@/@/@/@/@/@/@/@/@@@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@@//@/@/@/@/@/@/@/@/@/@/@@/
;/@/@/@/@/@/@/@/@/@/@/@@/@/@/@/@/@/@/@/@/@/@/@/@/@@/@/@/@/@/@/@/@/@@@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@@//@/@/@/@/@/@/@/@/@/@/@@/


instruction_MOV PROC
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_eax
CLD
repz cmpsb
jne MOV_2
inc esi 
mov cl , length_of_instruction
call is_digit
jne mov_9
mov edx , esi
call  ParseDecimal32
mov register_eax , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov eax , val 
mov_9 :
mov esi , offset my_instruction +7
mov cl , 3
mov edi ,  offset temp_ebx
CLD
repz cmpsb 
jne mov_10
mov ebx , register_ebx
mov register_eax , ebx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov eax , ebx
mov_10:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_eax 
CLD
repz cmpsb 
jne mov_11
mov eax , register_eax
mov register_eax , eax 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov eax , ebx
mov_11:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_ecx 
CLD
repz cmpsb 
jne mov_12
mov ecx , register_ecx
mov register_eax , ecx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov eax , ecx
mov_12:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_edx 
CLD
repz cmpsb 
jne mov_13
mov edx , register_edx
mov register_eax , edx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov eax , edx
mov_13:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_esi 
CLD
repz cmpsb 
jne mov_14
mov esi , register_esi
mov register_eax , esi
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov eax , esi
mov_14:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_edi 
CLD
repz cmpsb 
je ka
call message_not2
jmp no
ka:
mov edi , register_edi
mov register_eax , edi
no:
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov eax, edi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MOV_EAX
MOV_2:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ebx
CLD
repz cmpsb
jne MOV_3
inc esi 
mov cl , length_of_instruction
call is_digit
jne mov_166
mov edx , esi
call  ParseDecimal32
mov register_ebx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ebx , val
mov_166 :
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_eax 
CLD
repz cmpsb 
jne mov_16
mov eax , register_eax
mov register_ebx , eax 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ebx,eax
mov_16:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_ecx 
CLD
repz cmpsb 
jne mov_177
mov ecx , register_ecx
mov register_ebx , ecx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ebx,ecx
mov_177:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_ebx 
CLD
repz cmpsb 
jne mov_17
mov ebx , register_ebx
mov register_ebx , ebx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ebx , ebx
mov_17:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_edx 
CLD
repz cmpsb 
jne mov_18
mov edx , register_edx
mov register_ebx , edx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ebx , edx
mov_18:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_esi 
CLD
repz cmpsb 
jne mov_19
mov esi , register_esi
mov register_ebx , esi 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ebx , esi
mov_19:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_edi 
CLD
repz cmpsb 
je ka_2
call message_not2
jmp no_2
ka_2:
mov edi , register_edi
mov register_ebx , edi 
no_2:
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ebx,edi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MOV_EBX
MOV_3:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_edx
CLD
repz cmpsb
jne MOV_4
inc esi  
mov cl , length_of_instruction
call is_digit
jne mov_211
mov edx , esi
call  ParseDecimal32
mov register_edx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edx , val
mov_211 :
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_eax 
CLD
repz cmpsb 
jne mov_21
mov eax , register_eax
mov register_edx , eax 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edx , eax
mov_21:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_ebx 
CLD
repz cmpsb 
jne mov_22
mov ebx , register_ebx
mov register_edx , ebx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edx , ebx
mov_22:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_ecx 
CLD
repz cmpsb 
jne mov_23
mov ecx , register_ecx
mov register_edx , ecx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edx , ecx
mov_23:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_esi 
CLD
repz cmpsb 
jne mov_244
mov esi , register_esi
mov register_edx , esi 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edx , esi
mov_244:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_edx 
CLD
repz cmpsb 
jne mov_24
mov edx , register_edx
mov register_edx , edx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edx , edx
mov_24:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_edi 
CLD
repz cmpsb 
je ka_3
call message_not2
jmp no_3
ka_3:
mov edi , register_edi
mov register_edx , edi 
no_3:
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edx , edi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MOV_EDX
MOV_4:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ecx
CLD
repz cmpsb
jne MOV_5
inc esi 
mov cl , length_of_instruction
call is_digit
jne mov_266
mov edx , esi
call  ParseDecimal32
mov register_ecx , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ecx , val
mov_266 :
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_eax 
CLD
repz cmpsb 
jne mov_26
mov eax , register_eax
mov register_ecx , eax 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ecx,eax
mov_26:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_ebx 
CLD
repz cmpsb 
jne mov_27
mov ebx , register_ebx
mov register_ecx , ebx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ecx,ebx
mov_27:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_edx 
CLD
repz cmpsb 
jne mov_288
mov edx , register_edx
mov register_ecx , edx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ecx,edx
mov_288:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_ecx 
CLD
repz cmpsb 
jne mov_28
mov ecx , register_ecx
mov register_ecx , ecx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ecx,ecx
mov_28:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_esi 
CLD
repz cmpsb 
jne mov_29
mov esi , register_esi
mov register_ecx , esi 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ecx,esi
mov_29:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_edi 
CLD
repz cmpsb 
je ka_4
call message_not2
jmp no_4
ka_4:
mov edi , register_edi
mov register_ecx , edi 
no_4:
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov ecx,edi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MOV_ECX
MOV_5:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_esi
CLD
repz cmpsb
jne MOV_6
inc esi 
mov cl , length_of_instruction
call is_digit
jne mov_311
mov edx , esi
call  ParseDecimal32
mov register_esi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov esi , val
mov_311 :
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_eax 
CLD
repz cmpsb 
jne mov_31
mov eax , register_eax
mov register_esi , eax 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov esi,eax
mov_31:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_ebx 
CLD
repz cmpsb 
jne mov_32
mov ebx , register_ebx
mov register_esi , ebx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov esi,ebx
mov_32:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_ecx 
CLD
repz cmpsb 
jne mov_33
mov ecx , register_ecx
mov register_esi , ecx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov esi,ecx
mov_33:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_edx 
CLD
repz cmpsb 
jne mov_34
mov edx , register_edx
mov register_esi , edx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov esi,edx
mov_34:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_edi 
CLD
repz cmpsb 
jne mov_355
mov edi , register_edi
mov register_esi , edi 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov esi,edi
mov_355:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_esi 
CLD
repz cmpsb 
je ka_5
call message_not2
jmp no_5
ka_5:
mov esi , register_esi
mov register_esi , esi  
no_5:
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov esi,esi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MOV_ESI
MOV_6:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_edi
CLD
repz cmpsb
jne MOV_7
inc esi 
mov cl , length_of_instruction
call is_digit
jne mov_366
mov edx , esi
call  ParseDecimal32
mov register_edi , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edi , val
mov_366 :
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_eax 
CLD
repz cmpsb 
jne mov_36
mov eax , register_eax
mov register_edi , eax 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edi,eax
mov_36:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_ebx 
CLD
repz cmpsb 
jne mov_37
mov ebx , register_ebx
mov register_edi , ebx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edi,ebx
mov_37:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_ecx 
CLD
repz cmpsb 
jne mov_38
mov ecx , register_ecx
mov register_edi , ecx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edi,ecx
mov_38:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_edx 
CLD
repz cmpsb 
jne mov_39
mov edx , register_edx
mov register_edi , edx 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edi,edx
mov_39:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_esi 
CLD
repz cmpsb 
jne mov_400
mov esi , register_esi
mov register_edi , esi 
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edi,esi
mov_400:
mov esi , offset my_instruction + 7 
mov cl , 3
mov edi , offset temp_esi 
CLD
repz cmpsb 
je ka_6
call message_not2
jmp no_6
ka_6:
mov edi , register_edi
mov register_edi , edi 
no_6:
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mov edi,edi
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MOV_EDI
MOV_7:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_esp
CLD
repz cmpsb
jne MOV_8
inc esi 
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32
mov esp , eax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MOV_ESP
MOV_8:
mov esi , offset my_instruction + 3 
mov cl , 3
mov edi , offset temp_ebp
CLD
repz cmpsb
jne message_not2
inc esi 
mov cl , length_of_instruction
mov edx , esi
call  ParseDecimal32
mov ebp , eax
ret
instruction_MOV ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MOV_EBP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;/@/@/@/@/@/@/@/@/@/@/@@/@/@/@/@/@/@/@/@/@/@/@/@/@@/@/@/@/@/@/@/@/@@@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@@//@/@/@/@/@/@/@/@/@/@/@@/
;/@/@/@/@/@/@/@/@/@/@/@@/@/@/@/@/@/@/@/@/@/@/@/@/@@/@/@/@/@/@/@/@/@@@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@/@@//@/@/@/@/@/@/@/@/@/@/@@/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instruction_DIV PROC
mov esi , offset my_instruction + 3
mov cl , 3
mov edi , offset temp_ebx
CLD
repz cmpsb
jne DIV_2
mov eax , register_eax
mov ebx , register_ebx
mov edx,0
div ebx
mov register_eax , eax
mov register_edx , edx
ret
;;;;;;;;;;;;;;;;;;;;;; div_ebx
DIV_2:
mov esi , offset my_instruction + 3
mov cl , 3
mov edi , offset temp_ecx
CLD
repz cmpsb
jne DIV_3
mov eax , register_eax
mov ecx , register_ecx
mov edx,0
div ecx
mov register_eax , eax
mov register_edx , edx
ret
;;;;;;;;;;;;;;;;;;;;;;; div_ecx
DIV_3:
mov esi , offset my_instruction + 3
mov cl , 3
mov edi , offset temp_esi
CLD
repz cmpsb
jne DIV_4
mov eax , register_eax
mov esi , register_esi
mov edx,0
div esi
mov register_eax , eax
mov register_edx , edx
ret
;;;;;;;;;;;;;;;;;;;;;;; div_esi
DIV_4:
mov esi , offset my_instruction + 3
mov cl , 3
mov edi , offset temp_edi
CLD
repz cmpsb
jne DIV_5
mov eax , register_eax
mov edi , register_edi
mov edx,0
div edi
mov register_eax , eax
mov register_edx , edx
ret
;;;;;;;;;;;;;;;;;;;;;;; div_edi
DIV_5:
mov esi , offset my_instruction + 3
mov cl , 3
mov edi , offset temp_eax
CLD
repz cmpsb
jne DIV_6
mov eax , register_eax
mov edx,0
div register_eax
mov register_eax , eax
mov register_edx , edx
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;div_eax
DIV_6:
mov esi , offset my_instruction + 3
mov cl , 3
mov edi , offset temp_edx
CLD
repz cmpsb
jne DIV_7
mov eax , register_eax
div edx
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;div_edx
DIV_7:
mov esi , offset my_instruction + 3
mov cl , 3
mov edi , offset temp_esp
CLD
repz cmpsb
jne DIV_8
mov eax , register_eax
div esp
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;div_esp
DIV_8:
mov esi , offset my_instruction + 3
mov cl , 3
mov edi , offset temp_ebp
CLD
repz cmpsb
jne message_not2
mov eax , register_eax
div ebp
ret
instruction_DIV ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; div_ebp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



instruction_CALL PROC
mov esi , offset my_instruction + 4
mov cl , 8
mov edi , offset temp_call
CLD
repz cmpsb
jne call_2
mov eax , register_eax 
mov ebx , register_ebx
mov ecx , register_ecx
mov edx , register_edx
mov esi , register_esi
mov edi , register_edi
call DUMPREGS
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
call_2:
jmp message_not2
ret
instruction_CALL ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


message_not2 PROC   ;;;;;;;;;;; de ele btole el insturction ele d5le 8lat 
mov edx ,offset message
call writestring
call crlf
ret
message_not2 ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

is_digit PROC   ;;;;;;;;;;;;; btshof el mkan ele hya w2fa 3leh rkam wala l2 
mov al ,[esi]
call IsDigit
ret
is_digit ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

END main
