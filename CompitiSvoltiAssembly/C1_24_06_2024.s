;main() { 
;  char STRINGA[16]; 
;  int i, num, len,ris;      
     
;  printf("Inserisci il numero di stringhe da inserire \n"); 
;  scanf("%d",&num); 
;  for(i=0; i<num;) 
;  { 
;   printf("Inserisci una stringa di 6 caratteri con almeno un numero e una lettera maiuscola \n"); 
;   scanf("%s",STRINGA); 
       
;   ris= esegui(STRINGA); 
;   if(ris==2) 
;      { 
;    printf("Stringa %d-esima corretta\n",i); 
;   i++; 
;  } 
;   else printf("Stringa non corretta\n");    
;  } 
       
;} 

.data
STRINGA: .space 16

m1: .asciiz "Inserisci il numero di stringhe da inserire \n"
m2: .asciiz "Inserisci una stringa di 6 caratteri con almeno un numero e una lettera maiuscola \n"
m3: .asciiz "Stringa %d-esima corretta\n"
m4: .asciiz "Stringa non corretta\n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;  char STRINGA[16]; 
;  int i, num, len,ris;      
daddi $s0, $0, 0
;  printf("Inserisci il numero di stringhe da inserire \n"); 
daddi $t0, $0, m1
sd $t0, p1s5($0)
daddi r14, $0, p1s5
syscall 5
;  scanf("%d",&num); 
jal input_unsigned
move $s1, r1
;  for(i=0; i<num;) 
for: slt $t0, $s0, $s1
       beq $t0, $0, fine_exe
;   printf("Inserisci una stringa di 6 caratteri con almeno un numero e una lettera maiuscola \n"); 
       daddi $t1, $0, m2
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;   scanf("%s",STRINGA); 
       daddi $a0, $0, STRINGA
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
;   ris= esegui(STRINGA); 
       jal esegui
;   if(ris==2) 
       daddi $s2, $0, 2
       bne r1, $s2, else
;    printf("Stringa %d-esima corretta\n",i); 
       sd $s0, p2s5($0)
       daddi $t1, $0, m3
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;   i++; 
       j incrementa_i

;   else printf("Stringa non corretta\n");    
else: daddi $t1, $0, m4
          sd $t1, p1s5($0)
          daddi r14, $0, p1s5
          syscall 5

incrementa_i: daddi $s0, $s0, 1
                          j for

fine_exe: syscall 0


;int esegui(char *st) 
; $a0 = st
;{int i,lettera,numero; 
;  lettera=0; 
;  numero=0; 
     
;  for(i=0;i<6;i++) 
;    {  if(st[i]>=48 && st[i]<58) 
;      numero=1; 
;  if(st[i]>=65 && st[i]<91)   
;  lettera=1; 
; } 
;  return numero+lettera;   
;}  

esegui: daddi $sp, $sp, -24 
               sd $s0, 0($sp)  ; i
               sd $s1, 8($sp)  ; lettera
               sd $s2, 16($sp)  ; numero
               daddi $s0, $0, 0
               daddi $s1, $0, 0
               daddi $s2, $0, 0
;  for(i=0;i<6;i++) 
forf:       slti $t0, $s0, 6
               beq $t0, $0, return_numero_lettera
; if(st[i]>=48 && st[i]<58) 
;      numero=1;
               dadd $t0, $a0, $s0
               lbu $t1, 0($t0)
               slti $t2, $t1, 48
               bne $t2, $0, if_2
               slti $t2, $t1, 58
               beq $t2, $0, if_2
               daddi $s2, $0, 1
;  if(st[i]>=65 && st[i]<91)   
;  lettera=1; 
if_2:       slti $t2, $t1, 65
               bne $t2, $0, incr_if
               slti $t2, $t1, 91
               beq $t2, $0, incr_if
               daddi $s1, $0, 1

incr_if:  daddi $s0, $s0, 1
               j forf

return_numero_lettera: dadd r1, $s1, $s2
                                             ld $s0, 0($sp)  
                                             ld $s1, 8($sp)  
                                             ld $s2, 16($sp) 
                                             daddi $sp, $sp, 24
                                             jr $ra
               
#include input_unsigned.s
