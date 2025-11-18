;int calcola(char *s, int d,int num) 
;{int j,p; 
 
;  p=0; 
;  for(j=0;j<d;j++) 
;     if(s[j] % 2 == 0) 
;    p++;    
; return p; 
;} 
 
;main() { 
;  char NUM[8]; 
;  int i,val,ris;      
     
;     for(i=0; i<3;i++) 
;     { 
;   printf("Inserisci una stringa di soli numeri \n"); 
;       scanf("%s",NUM); 
      
;   printf("Quanti sono i numeri pari?"); 
;       scanf("%d",&val); 
     
 ;      ris= calcola(NUM, strlen(NUM),val);        
 ;      if(ris==val) 
;   printf(" Esatto, sono %d \n",ris); 
;  else printf("I numeri pari sono %d\n", ris) ;    
;     }  
;}

.data
NUM: .space 8

m1: .asciiz "Inserisci una stringa di soli numeri \n"
m2: .asciiz "Quanti sono i numeri pari?"
m3: .asciiz " Esatto, sono %d \n"
m4: .asciiz "I numeri pari sono %d\n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 8

.code 
;  char NUM[8]; 
;  int i,val,ris;      
daddi $s0, $0, 0 ; i = 0     
;     for(i=0; i<3;i++) 
for: slti $t0, $s0, 3
        beq $t0, $0, fine_exe
;   printf("Inserisci una stringa di soli numeri \n"); 
        daddi $t0, $0, m1
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;       scanf("%s",NUM); 
        daddi $a0, $0, NUM
        sd $a0, ind($0)
        daddi r14, $0, p1s3
        syscall 3
        move $a1, r1
;   printf("Quanti sono i numeri pari?"); 
       daddi $t0, $0, m2
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;       scanf("%d",&val); 
       jal input_unsigned
       move $a2, r1 ; $a2 = val
 ;      ris= calcola(NUM, strlen(NUM),val);        
       jal calcola
       move $s1, r1 ; $s1 = ris
 ;      if(ris==val) 
       bne $s1, $a2, else
;   printf(" Esatto, sono %d \n",ris); 
       sd $s1, p2s5($0) 
       daddi $t0, $0, m3
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
       j incr_i

; printf("I numeri pari sono %d\n", ris) ; 
else: sd $s1, p2s5($0) 
          daddi $t0, $0, m4
          sd $t0, p1s5($0)
          daddi r14, $0, p1s5
          syscall 5

incr_i: daddi $s0, $s0, 1
            j for

fine_exe: syscall 0

;int calcola(char *s, int d,int num) 
; $a0 = s, $a1 = d, $a2 = num
;{int j,p;  
;  p=0; 
calcola: daddi $sp, $sp, -16
               sd $s0, 0($sp)  ; j
               sd $s1, 8($sp)  ; p
               daddi $s0, $0, 0 ; j = 0
               daddi $s1, $0, 0 ; p = 0

for_funzione: slt $t0, $s0, $a1
                          beq $t0, $0, return_p
                          dadd $t1, $s0, $a0
                          lbu $t2, 0($t1)  ; $t2 = s[j]
                          daddi $s2, $0, 2  ; $s2 = 2
                          ddiv $t2, $s2
                          mfhi $t3 ; $t3 = s[j] % 2 = $t2 % $s2
                          bne $t3, $0, incr_j_f  
                          daddi $s1, $s1, 1  ; p++

incr_j_f:          daddi $s0, $s0, 1
                         j for_funzione

return_p:        move r1, $s1
                         ld $s0, 0($sp)  ; j
                         ld $s1, 8($sp)  ; p
                         daddi $sp, $sp, 16
                         jr $ra

#include input_unsigned.s
