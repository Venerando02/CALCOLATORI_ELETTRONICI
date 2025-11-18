;main() { 
;  char STR[16]; 
;  int i, a2, ris;      
     
;     for(i=0; i<4;) 
;     { 
;   printf("Inserisci una stringa con solo numeri\n"); 
;      scanf("%s",STR);  
;      printf("Inserisci un numero ad una cifra\n"); 
;      scanf("%d",&a2); 
;   ris= elabora(STR,strlen(STR),a2);        
       
;   printf("%d Ris = %d\n", i, ris) ; 
;    if(ris>=0)   
;        i++;  
;     }  
;}

.data
STR: .space 16

m1: .asciiz "Inserisci una stringa con solo numeri\n"
m2: .asciiz "Inserisci un numero ad una cifra\n"
m3: .asciiz "%d Ris = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
 ;  char STR[16]; 
;  int i, a2, ris;      
daddi $s0, $0, 0     
;     for(i=0; i<4;) 
for: slti $t0, $s0, 4
        beq $t0, $0, fine_exe
;   printf("Inserisci una stringa con solo numeri\n"); 
        daddi $t1, $0, m1
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;      scanf("%s",STR);  
       daddi $a0, $0, STR
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a1, r1
;      printf("Inserisci un numero ad una cifra\n"); 
       daddi $t1, $0, m2
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;      scanf("%d",&a2); 
       jal input_unsigned
       move $a2, r1
       jal elabora
       move $s1, r1
;   printf("%d Ris = %d\n", i, ris) ; 
      sd $s0, p2s5($0)
      sd $s1, p3s5($0)
      daddi $t1, $0, m3
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;    if(ris>=0)
      slti $t1, $s1, 0
      bne $t1, $0, for  
;        i++;  
incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0

;int elabora(char *a0, int n, int a2) 
; $a0 = a0, $a1 = n, $a2 = a2
;{int i,c;  
;  c=0;    
;  for(i=0;i<n;i++)  
;   {  
;     if (a0[i]<48 || a0[i] >= 58)  
;  return -1 ;  
;  else if(a0[i]-48 < a2) 
;    c++;   
;   }   
;return c; 
;} 

elabora: daddi $sp, $sp, -16
                sd $s0, 0($sp) ; i
                sd $s1, 8($sp) ; c
                daddi $s0, $0, 0
                daddi $s1, $0, 0

for_funzione: slt $t0, $s0, $a1
                          beq $t0, $0, return_c
;     if (a0[i]<48 || a0[i] >= 58)  
                          dadd $t1, $a0, $s0
                          lbu $t2, 0($t1)
                          slti $t3, $t2, 48
                          bne $t3, $0, return_-1
                          slti $t3, $t2, 58
                          beq $t3, $0, return_-1
;  else if(a0[i]-48 < a2) 
                         daddi $t2, $t2, -48
                         slt $t3, $t2, $a2
                         beq $t3, $0, incr_if
;    c++;   
                         daddi $s1, $s1, 1

incr_if:    daddi $s0, $s0, 1
                 j for_funzione


return_-1:      daddi r1, $0, -1
                         ld $s0, 0($sp) 
                         ld $s1, 8($sp) 
                         daddi $sp, $sp, 16
                         jr $ra

return_c:        move r1, $s1
                         ld $s0, 0($sp) 
                         ld $s1, 8($sp) 
                         daddi $sp, $sp, 16
                         jr $ra


#include input_unsigned.s
