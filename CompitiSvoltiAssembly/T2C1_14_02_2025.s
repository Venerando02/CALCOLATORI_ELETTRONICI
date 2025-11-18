;main() { 
;  char string[16]; 
;  int i, res;      
;  int number; 
     
;     for(i=0; i<4;i++) 
;     { 
     
;   printf("Inserisci una stringa con al massimo 8 caratteri (lettere minuscole) \n"); 
;       scanf("%s",string); 
        
;   printf("Inserisci un numero (max 2 cifre)\n"); 
;       scanf("%d",&number); 
        
;       res= calcola(string, strlen(string),number);        
        
;   printf("Ciclo %d: Risultato = %d\n", i, res) ; 
            
;     }  
;} 
 
 
;int calcola(char *let,  int a1, int num) 
;{int i,somma,conta; 
  
;  conta=0; 
;  somma=0; 
; for(i=a1-1;i>=0;i--) 
;   { 
;    if(let[i]-97>= 0 && let[i]-97 <num ) 
;       {conta++; 
;        somma+=(let[i]-97); 
;       }      
          
; }  
; if(conta<1) 
;   return 0; 
; else return somma/conta; 
;}

.data
string: .space 16

m1: .asciiz "Inserisci una stringa con al massimo 8 caratteri (lettere minuscole) \n"
m2: .asciiz "Inserisci un numero (max 2 cifre)\n"
m3: .asciiz "Ciclo %d: Risultato = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;  char string[16]; 
;  int i, res;      
;  int number; 
daddi $s0, $0, 0     
;     for(i=0; i<4;i++) 
for: slti $t0, $s0, 4
       beq $t0, $0, fine_exe
;   printf("Inserisci una stringa con al massimo 8 caratteri (lettere minuscole) \n"); 
       daddi $t1, $0, m1
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;       scanf("%s",string); 
      daddi $a0, $0, string
      sd $a0, ind($0)
      daddi r14, $0, p1s3
      syscall 3
      move $a1, r1
;   printf("Inserisci un numero (max 2 cifre)\n"); 
       daddi $t1, $0, m2
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;       scanf("%d",&number); 
      jal input_unsigned
      move $a2, r1
      jal calcola
;   printf("Ciclo %d: Risultato = %d\n", i, res) ;
     sd $s0, p2s5($0)
     sd r1, p3s5($0)
     daddi $t1, $0, m3
     sd $t1, p1s5($0)
     daddi r14, $0, p1s5
     syscall 5

incrementa_i: daddi $s0, $s0, 1
                          j for

fine_exe: syscall 0

;int calcola(char *let,  int a1, int num) 
; $a0 = let, $a1 = a1, $a2 = num
;{int i,somma,conta;  
;  conta=0; 
;  somma=0

calcola: daddi $sp, $sp, -24
               sd $s0, 0($sp)  ; i
               sd $s1, 8($sp)  ; somma
               sd $s2, 16($sp)  ; conta
               daddi $s0, $a1, -1
               daddi $s1, $0, 0
               daddi $s2, $0, 0
              
; for(i=a1-1;i>=0;i--) 
forf:       slti $t0, $s0, 0
               bne $t0, $0, if_funzione
;    if(let[i]-97>= 0 && let[i]-97 <num ) 
               dadd $t1, $a0, $s0
               lbu $t2, 0($t1)
               daddi $t2, $t2, -97  ; $t2 = $t2 - 97 = let[i] - 97
               slti $t3, $t2, 0
               bne $t3, $0, decrementa_i
               slt $t3, $t2, $a2
               beq $t3, $0, decrementa_i
;       {conta++; 
               daddi $s2, $s2, 1
;        somma+=(let[i]-97); 
               dadd $s1, $s1, $t2 

decrementa_i: daddi $s0, $s0, -1
                            j forf

if_funzione: daddi $s3, $0, 1
                       slt $t0, $s2, $s3
                       beq $t0, $0, return_somma_conta
                       daddi r1, $0, 0
                       ld $s0, 0($sp)
                       ld $s1, 8($sp)
                       ld $s2, 16($sp)
                       daddi $sp, $sp, 24
                       jr $ra

return_somma_conta: ddiv $s1, $s2
                                           mflo r1
                                           ld $s0, 0($sp)
                                           ld $s1, 8($sp)
                                           ld $s2, 16($sp)
                                           daddi $sp, $sp, 24
                                           jr $ra

#include input_unsigned.s
