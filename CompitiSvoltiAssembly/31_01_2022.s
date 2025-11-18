;int processa(char *st, int d) 
;{ int i;     
;    for(i=0;i<d;i++) 
;       if(st[i]>=58) 
;      break;         
;   return i; 
;} 
 
;main() { 
;  char STRNG[16]; 
; int i,val,num;                      
;  for(i=0;i<3;i++) { 
;   do{   printf("Indica quanti caratteri (numeri) vuoi inserire (>=3))\n"); 
;         scanf("%d",&num); 
;   }while(num<3); 
;   printf("Inserisci la stringa con %d numeri\n",num); 
;   scanf("%s",STRNG); 
;   val=processa(STRNG,num);         
;   printf(" Valore= %d \n",val);  
;  }   
; }

.data
stack: .space 32
STRING: .space 16

m1: .asciiz "Indica quanti caratteri (numeri) vuoi inserire (>=3))\n"
m2: .asciiz "Inserisci la stringa con %d numeri\n"
m3: .asciiz " Valore= %d \n"

p1s5: .space 8
num: .space 8
val: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
daddi $sp, $0, stack
daddi $sp, $sp, 32
; char STRNG[16]; 
; int i,val,num;                      
daddi $s0, $0, 0 ; i = 0
for: slti $t0, $s0, 3
       beq $t0, $0, fine_esecuzione
;  for(i=0;i<3;i++) 
;   do{   printf("Indica quanti caratteri (numeri) vuoi inserire (>=3))\n"); 
do:  daddi $t1, $0, m1
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;     scanf("%d",&num); 
      jal input_unsigned
      move $a1, r1
;   }while(num<3); 
      slti $t1, $a1, 3
      bne $t1, $0, do 
;   printf("Inserisci la stringa con %d numeri\n",num); 
      sd $a1, num($0)
      daddi $t1, $0, m2
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;   scanf("%s",STRNG); 
      daddi $a0, $0, STRING
      sd $a0, ind($0)
      daddi r14, $0, p1s3
      syscall 3
;   val=processa(STRNG,num);         
      jal processa
      move $s1, r1
      sd $s1, val($0)
;   printf(" Valore= %d \n",val);  
      daddi $t1, $0, m3
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5

fine_esecuzione: syscall 0

processa: daddi $sp, $sp, -32
                sd $s0, 0($sp)
                daddi $s0, $0, 0  ; i = 0

for_f:        slt $t0, $s0, $a1
                beq $t0, $0, return_i
                ; &str[i] = &str + i = $a0 + $s0
                dadd $t1, $s0, $a0
                lbu $s1, 0($t1)
                slti $t2, $s1, 58
                beq $t2, $0, incr_i
                j return_i

incr_i:      daddi $s0, $s0, 1
                j for_f  

return_i:   move r1, $s0
                ld $s0, 0($sp)
                daddi $sp, $sp, 32
                jr r31

#include input_unsigned.s
