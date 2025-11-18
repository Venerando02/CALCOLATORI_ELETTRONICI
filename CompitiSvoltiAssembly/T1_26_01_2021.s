;int processa(char *num, int d) 
;{ int i,somma; 
;    somma=0; 
;    for(i=0;i<d;i++) 
;      somma=somma+ num[i]-48;         
;   return somma; 
;} 
 
;main() { 
;  char NUMERO[16]; 
;  int i,val;                    
;  for(i=0;i<4;i++) { 
;   printf("Inserisci una stringa con soli numeri\n"); 
;   scanf("%s",NUMERO); 
;   if(strlen(NUMERO)<2) 
; val=NUMERO[0]-48; 
;   else val=processa(NUMERO,strlen(NUMERO));        
;  printf(" Valore= %d \n",val);  
;  }   
; }

.data
NUMERO: .space 16
stack: .space 32

m1: .asciiz "Inserisci una stringa con soli numeri\n"
m2: .asciiz " Valore= %d \n"

p1s5: .space 8
val: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code 
daddi $sp, $0, stack
daddi $sp, $sp, 32
;  for(i=0;i<4;i++) { 
daddi $s0, $0, 0
for: slti $t0, $s0, 4
       beq $t0, $0, fine_esecuzione
;    printf("Inserisci una stringa con soli numeri\n"); 
       daddi $t0, $0, m1
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;   scanf("%s",NUMERO); 
       daddi $a0, $0, NUMERO
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a1, r1
 ;   if(strlen(NUMERO)<2) 
      slti $t0, $a1, 2
      beq $t0, $0, else
      lbu $s1, NUMERO($s0)
      daddi $s1, $s1, -48
      sd $s2, val($0)
       j print

else: jal processa
         move $s2, r1
         sd $s2, val($0)

print: daddi $t0, $0, m2
           sd $t0, p1s5($0)
           daddi r14, $0, p1s5
           syscall 5

incr_i:  daddi $s0, $s0, 1  ; i++
             j for

fine_esecuzione: syscall 0

processa: daddi $sp, $sp, -16
                  sd $s0, 0($sp)  ; i = 0
                  sd $s1, 8($sp)  ; somma = 0
                  daddi $s0, $s0, 0
                  daddi $s1, $s1, 0
 forf: slt $t0, $s0, $a1
        beq $t0, $0, return
; num[i] = &num + i = &num + $s0
        dadd $t1, $a0, $s0
        lbu $t2, 0($t1) 
        daddi $t2, $t2, -48
        dadd $s1, $s1, $t2
        daddi $s0, $s0, 1
        j forf

return: move r1, $s1
             ld $s0, 0($sp)  
             ld $s1, 8($sp)  
             daddi $sp, $sp, 16
             jr $ra
