;int processa(char *s, int dim) 
;{int j,somma; 
 
;    somma=0; 
;    for(j=0;j<dim;j++) 
;       somma= somma+ s[j]%16;  
       
;   return somma; 
;} 
 
;main() { 
;  char ST[32]; 
;  int i,num,val;      
    
;  for(i=0;i<3;) 
;   { 
;    printf("Inserisci un numero >0 e <=16\n"); 
;    scanf("%d",&num); 
;    if(num!=0) 
;     {  printf("Inserisci una stringa con almeno %d caratteri\n",num); 
;        scanf("%s",ST); 
;        if(strlen(ST)>=num)  
;   { 
;      val= processa(ST,strlen(ST));        
;              printf(" Valore= %d \n",val);  
;              i++; 
;           } 
;     }  
;   } 
;}} 

.data
ST: .space 32

m1: .asciiz "Inserisci un numero >0 e <=16\n"
m2: .asciiz "Inserisci una stringa con almeno %d caratteri\n"
m3: .asciiz " Valore= %d \n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 32

.code
;  char ST[32]; 
;  int i,num,val;      
daddi $s0, $0, 0     
;  for(i=0;i<3;) 
for: slti $t0, $s0, 3
        beq $t0, $0, fine_exe
;    printf("Inserisci un numero >0 e <=16\n"); 
       daddi $t0, $0, m1
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;    scanf("%d",&num); 
       jal input_unsigned
       move $s1, r1  ; $s1 = num
;    if(num!=0) 
       beq $s1, $0, incr_i
; printf("Inserisci una stringa con almeno %d caratteri\n",num); 
       sd $s1, p2s5($0)
       daddi $t0, $0, m2
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;        scanf("%s",ST); 
       daddi $a0, $0, ST
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a1, r1  ; $a1 = strlen(ST);
;        if(strlen(ST)>=num)  
       slt $t0, $a1, $s1
       bne $t0, $0, incr_i
;      val= processa(ST,strlen(ST));  
       jal processa
       sd r1, p2s5($0)
;              printf(" Valore= %d \n",val);  
       daddi $t0, $0, m3
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;              i++; 
incr_i: daddi $s0, $s0, 1  ; i++
             j for

fine_exe: syscall 0

;int processa(char *s, int dim) 
; $a0 = s, $a1 = dim
;{int j,somma;  
;    somma=0; 
processa: daddi $sp, $sp, -16
                    sd $s0, 0($sp) ; j
                    sd $s1, 8($sp) ; somma
                    daddi $s0, $0, 0
                    daddi $s1, $0, 0

;    for(j=0;j<dim;j++) 
for_funzione: slt $t0, $s0, $a1
                          beq $t0, $0, return_somma
;       somma= somma+ s[j]%16;  
                          dadd $t1, $s0, $a0
                          lbu $t2, 0($t1) ; $t2 = s[j]
                          daddi $s2, $0, 16 ; $s2 = 16
                          ddiv $t2, $s2
                          mfhi $t3  ; $t3 = s[j] % 16
                          dadd $s1, $s1, $t3

incr_j_funzione: daddi $s0, $s0, 1
                               j for_funzione

 return_somma: move r1, $s1
                               ld $s0, 0($sp) 
                               ld $s1, 8($sp) 
                               daddi $sp, $sp, 16
                               jr $ra

#include input_unsigned.s
