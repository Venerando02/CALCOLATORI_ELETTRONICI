;main() { 
;  char STRINGA[8]; 
;  int i,ris;      
;  long num;  
   
; i=0; 
;  do 
;  { 
;     printf("Inserisci una stringa con al massimo 8 caratteri\n");  
;     scanf("%s",STRINGA); 
      
;     printf("Inserisci un numero con %d cifre\n",strlen(STRINGA)); 
;     scanf("%d",&num); 
; ris= elabora(STRINGA,strlen(STRINGA),num);        
;     printf(" Risultato= %d \n",ris);  
; i++;  
;  } while (ris!=0&& i<3);  
;}

.data
STRINGA: .space 16

m1: .asciiz "Inserisci una stringa con al massimo 8 caratteri\n"
m2: .asciiz "Inserisci un numero con %d cifre\n"
m3: .asciiz " Risultato= %d \n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;  char STRINGA[8]; 
;  int i,ris;      
;  long num;     
; i=0; 
 daddi $s0, $0, 0
;     printf("Inserisci una stringa con al massimo 8 caratteri\n");  
do: daddi $t0, $0, m1
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;     scanf("%s",STRINGA); 
       daddi $a0, $0, STRINGA
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a1, r1
;     printf("Inserisci un numero con %d cifre\n",strlen(STRINGA)); 
      sd $a1, p2s5($0)
      daddi $t0, $0, m2
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;     scanf("%d",&num); 
      jal input_unsigned
      move $a2, r1
; ris= elabora(STRINGA,strlen(STRINGA),num);        
      jal elabora
      move $s1, r1
;     printf(" Risultato= %d \n",ris);  
      sd $s1, p2s5($0)
      daddi $t0, $0, m3
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
; i++;  
      daddi $s0, $s0, 1
;  } while (ris!=0&& i<3);  
do_while_condition: beq $s1, $0, fine_exe       
                                       slti $t0, $s0, 3
                                       bne $t0, $0, do

fine_exe: syscall 0


;int elabora(char *s, int d, int n) 
; $a0 = s, $a1 = d, $a2 = n
;{ int i,t,val; 
 
;   t=0; 
;   for(i=0;i<d;i++) 
;   { val=n%10;  
;     if(val<s[i]-48) 
;       t++;      
;   }   
          
;   return t; 
;}
elabora: daddi $sp, $sp, -24
                sd $s0, 0($sp) ; i
                sd $s1, 8($sp) ; t
                sd $s2, 16($sp) ; val
                daddi $s0, $0, 0
                daddi $s1, $0, 0

forf:        slt $t0, $s0, $a1
                beq $t0, $0, return_t
                daddi $s3, $0, 10
                daddi $s4, $0, 48
                ddiv $a2, $s3
                mfhi $s2  ; val = n % 10
                dadd $t1, $a0, $s0
                lbu $t2, 0($t1)
                dsub $t3, $t2, $s4 ; $t3 = $t2 - $s4 = s[i] - 48
                slt $t0, $s2, $t3
                beq $t0, $0, incr_if
                daddi $s1, $s1, 1
 
incr_if:   daddi $s0, $s0, 1
                j forf

return_t: move r1, $s1
                 ld $s0, 0($sp) ; i
                 ld $s1, 8($sp) ; t
                 ld $s2, 16($sp) ; val
                 daddi $sp, $sp, 24
                 jr $ra               

#include input_unsigned.s
