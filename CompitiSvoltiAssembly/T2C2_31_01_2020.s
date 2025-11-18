; COMPITO T2C2 31_01_2020
;int conta_numeri(char *str, int d) 
; {   int i,conta; 
;    conta=0; 
;    for(i=0;i<d;i++) 
;    if(str[i]>=48 && str[i]<58) 
;      conta++; 
;    return conta; 
; } 

;main() 
; {     char STR[3][16]; 
;       int  N,R,i;                  
;       for(i=0;i<3;i++) 
;       {printf("Inserisci quanti numeri devono essere presenti in una stringa\n"); 
;        scanf("%d",&N);  
;        printf("Inserisci una stringa con almeno %d numeri\n",N); 
;        scanf("%s",STR[i]); 
;       R=conta_numeri(STR[i],strlen(STR[i])); 
;       if(R<N) printf("La stringa %d contiene pochi numeri\n",i);  
;       else printf("La stringa %d e' corretta\n",i);          
;       } 
;}

.data 
STR: .space 48
stack: .space 32

m1: .asciiz "Inserisci quanti numeri devono essere presenti in una stringa\n"
m2: .asciiz "Inserisci una stringa con almeno %d numeri\n"
m3: .asciiz "La stringa %d contiene pochi numeri\n"
m4: .asciiz "La stringa %d e' corretta\n"

p1s3: .word 0
inds3: .space 8
dims3: .word 16

p1s5: .space 8
val: .space 8
 
.code 
daddi $sp, $0, stack
daddi $sp, $0, 32

daddi $s0, $0, 0 ; i = 0
daddi $s1, $0, 0 ; i = 0 multiplo di 16
;       for(i=0;i<3;i++) 
for:  slti $t0, $s0, 3
        beq $t0, $0, fine_esecuzione
;       {printf("Inserisci quanti numeri devono essere presenti in una stringa\n"); 
        daddi $t0, $0, m1
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;        scanf("%d",&N);  
        jal input_unsigned
        move $s2, r1
;        printf("Inserisci una stringa con almeno %d numeri\n",N); 
       sd $s2, val($0) 
       daddi $t0, $0, m2
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5 
;        scanf("%s",STR[i]);
;       STR[i] = STR + i*16 = STR + $s1
       daddi $t0, $s1, STR
       sd $t0, inds3($0)
       daddi r14, $0, p1s3
       syscall 3
     
       daddi $a0, $s1, STR
       move $a1, r1
;       R=conta_numeri(STR[i],strlen(STR[i])); 
       jal conta_numeri
       move $s3, r1
;       if(R<N) printf("La stringa %d contiene pochi numeri\n",i);  
       slt $t0, $s3, $s2
       beq $t0, $0, else
       
       sd $0, val($0)
       daddi $t0, $0, m3
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
       j incr_i

incr_i:  daddi $s0, $s0, 1  ; i++ per la printf
             daddi $s1, $s1, 16 ; i++ per STR
             j for


else:  sd $s0, val($0) 
          daddi $t0, $0, m4
          sd $t0, p1s5($0)
          daddi r14, $0, p1s5
          syscall 5

fine_esecuzione: syscall 0
;int conta_numeri(char *str, int d) 
; {   int i,conta; 
;    conta=0; 
;    for(i=0;i<d;i++) 
;    if(str[i]>=48 && str[i]<58) 
;      conta++; 
;    return conta; 
; } 
conta_numeri: daddi $sp, $sp, -16
                           sd $s0, 0($sp)
                           sd $s1, 8($sp)
;    conta=0; 
                           daddi $s0, $0, 0 ; conta = 0
                           daddi $s1, $0, 0 ; i = 0
;    for(i=0;i<d;i++) 
for_f: slt $t0, $s1, $a1
       beq $t0, $0, return
; str[i] = &str + i = &str + $s1
       dadd $t0, $a0, $s1
       lbu $t1, 0($t0) ; t1 = str[i]
;    if(str[i]>=48 && str[i]<58) 
       slti $t2, $t1, 48
       bne $t2, $0, incr_ind_i
       slti $t2, $t1, 58
       beq $t2, $0, incr_ind_i
       ;      conta++; 
       daddi $s0, $s0, 1

incr_ind_i:        daddi $s1, $s1, 1
                           j for_f

return:             move r1, $s0
                         ld $s0, 0($sp)
                         ld $s1, 8($sp) 
                         daddi $sp, $0, 16
                         jr r31

#include input_unsigned.s
