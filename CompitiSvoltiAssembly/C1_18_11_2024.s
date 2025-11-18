; int calcola(char *a0, int a1, int a2) 
;{ int s0,s1; 
 
; s0=0; 
; for(s1=0;s1<a1;s1++) 
;       s0=s0+a0[s1]/a2; 
     
; return s0; 
;} 
 
;main() { 
;  char VALORI[32]; 
   
;  int s0,a1,a2,r1;      
    
;   for(s0=0;s0<3;s0++ )  
;     { 
;  do { 
;    printf("indice= %d : Inserisci una stringa con almeno 2 caratteri\n",s0);  
;        scanf("%s",VALORI); 
;       } while (strlen(VALORI)<2); 
;       printf("Inserisci un numero intero !=0\n");  
;       scanf("%d",&a2);  
;   a1=strlen(VALORI); 
;   r1=calcola(VALORI,a1,a2); 
;   printf(" Risultato= %d \n",r1);      
; } 
;}

.data
VALORI: .space 32

m1: .asciiz "indice= %d : Inserisci una stringa con almeno 2 caratteri\n"
m2: .asciiz "Inserisci un numero intero !=0\n"
m3: .asciiz " Risultato= %d \n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 32

.code
 ;  char VALORI[32];    
;  int s0,a1,a2,r1;      
daddi $s0, $0, 0    
;   for(s0=0;s0<3;s0++ )  
for: slti $t0, $s0, 3
       beq $t0, $0, fine_exe
;  do { 
;    printf("indice= %d : Inserisci una stringa con almeno 2 caratteri\n",s0);  
do: sd $s0, p2s5($0)
       daddi $t1, $0, m1
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;        scanf("%s",VALORI); 
      daddi $a0, $0, VALORI
      sd $a0, ind($0)
      daddi r14, $0, p1s3
      syscall 3
      move $a1, r1
;       } while (strlen(VALORI)<2); 
do_while_condition: slti $t1, $a1, 2
                                       bne $t1, $0, do
;       printf("Inserisci un numero intero !=0\n");  
       daddi $t1, $0, m2
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;       scanf("%d",&a2);
       jal input_unsigned  
       move $a2, r1
;   a1=strlen(VALORI); 
;   r1=calcola(VALORI,a1,a2);
       jal calcola 
;   printf(" Risultato= %d \n",r1);
       sd r1, p2s5($0)
       daddi $t1, $0, m3
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
      
incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0

; int calcola(char *a0, int a1, int a2) 
; $a0 = a0, $a1 = a1, $a2 = a2
;{ int s0,s1; 
; s0=0; 
; for(s1=0;s1<a1;s1++) 
;       s0=s0+a0[s1]/a2; 
     
; return s0; 
;} 

calcola: daddi $sp, $sp, -16
               sd $s0, 0($sp)
               sd $s1, 8($sp)
               daddi $s0, $0, 0
               daddi $s1, $0, 0
; for(s1=0;s1<a1;s1++) 
;       s0=s0+a0[s1]/a2; 

forf: slt $t0, $s0, $a1
         beq $t0, $0, return_s0
;       s0=s0+a0[s1]/a2; 
         dadd $t1, $a0, $s1
         lbu $t2, 0($t1)
         ddiv $t2, $a2
         mflo $s2
         dadd $s0, $s0, $s2 ; $s0 = $s0 + a0[s1] / a2 = s0 + $s2 

incr_i_f: daddi $s0, $s0, 1
                j forf

return_s0: move r1, $s0
                    ld $s0, 0($sp)
                    ld $s1, 8($sp)
                    daddi $sp, $sp, 16
                    jr $ra

#include input_unsigned.s
