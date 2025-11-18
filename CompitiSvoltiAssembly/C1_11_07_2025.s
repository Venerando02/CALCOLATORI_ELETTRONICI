 ;main() { 
 ; char STR[32]; 
 ; int i, soglia, val;      
          
;     for(i=0; i<4;i++) 
;     { 
       
;   printf("Inserisci una stringa di numeri \n"); 
;       scanf("%s",STR); 
;       printf("Inserisci un valore di soglia (<10)\n"); 
;        scanf("%d",&soglia); 
;       val= elabora(STR,strlen(STR),soglia); 
;       if(val!=-1)  
;    printf("Il risultato e' %d\n", val); 
    
;  } 
       
;} 
 
;int elabora(char *a0, int a1, int a2) 
;{int s0, s1, n; 
   
;  s1=0; 
;  for(s0=0;s0<a1;s0++) 
;     {  
;  n=a0[s0]-48;    
;  if(n<0 || n>=10) // Se non e’ un numero 
;   return -1; 
;  if(n<a2)   
;   s1 += n; 
; } 
 
;  return s1/a1;   
;}

.data
STR: .space 32

m1: .asciiz "Inserisci una stringa di numeri \n"
m2: .asciiz "Inserisci un valore di soglia (<10)\n"
m3: .asciiz "Il risultato e' %d\n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 32

.code
 ; char STR[32]; 
 ; int i, soglia, val;      
daddi $s0, $0, 0          
;     for(i=0; i<4;i++) 
for: slti $t0, $s0, 4
       beq $t0, $0, fine_exe
;   printf("Inserisci una stringa di numeri \n"); 
      daddi $t1, $0, m1
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;       scanf("%s",STR); 
      daddi $a0, $0, STR
      sd $a0, ind($0)
      daddi r14, $0, p1s3
      syscall 3
      move $a1, r1
;       printf("Inserisci un valore di soglia (<10)\n"); 
      daddi $t1, $0, m2
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;        scanf("%d",&soglia); 
      jal input_unsigned
      move $a2, r1
      jal elabora
;       if(val!=-1)  
;    printf("Il risultato e' %d\n", val); 
      daddi $s1, $0, -1
      beq r1, $s1, incr_i
;    printf("Il risultato e' %d\n", val); 
      sd r1, p2s5($0)
      daddi $t1, $0, m3
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5     

incr_i:  daddi $s0, $s0, 1
              j for

fine_exe: syscall 0

;int elabora(char *a0, int a1, int a2)
; $a0 = STR, $a1 = strlen(STR), $a2 = a2 
;{int s0, s1, n; 
   
;  s1=0; 
;  for(s0=0;s0<a1;s0++) 
;     {  
;  n=a0[s0]-48;    
;  if(n<0 || n>=10) // Se non e’ un numero 
;   return -1; 
;  if(n<a2)   
;   s1 += n; 
; } 
 
;  return s1/a1;   
;}

elabora: daddi $sp, $sp, -24
                sd $s0, 0($sp)  ; s0
                sd $s1, 8($sp)  ; s1
                sd $s2, 16($sp)  ; n
                daddi $s1, $0, 0 ; $s1 = 0
                daddi $s0, $0, 0

forf:        slt $t0, $s0, $a1
                beq $t0, $0, return_s1a1
;  n=a0[s0]-48;    
                dadd $t1, $a0, $s0
                lbu $s2, 0($t1)
                daddi $s2, $s2, -48  ; n = $s2 = a0[s0] - 48
;  if(n<0 || n>=10) // Se non e’ un numero 
                slti $t2, $s2, 0
                bne $t2, $0, return_-1
;   return -1; 
                slti $t2, $s2, 10
                beq $t2, $0, return_-1
;  if(n<a2)   
                slt $t2, $s2, $a2
                beq $t2, $0, incr_i_funzione
;   s1 += n; 
                dadd $s1, $s1, $s2

incr_i_funzione: daddi $s0, $s0, 1
                               j forf

return_-1:  daddi r1, $0, -1
                     ld $s0, 0($sp)
                     ld $s1, 8($sp)
                     ld $s2, 16($sp)
                     daddi $sp, $sp, 24
                     jr $ra

return_s1a1: ddiv $s1, $a1
                         mflo r1
                         ld $s0, 0($sp)
                         ld $s1, 8($sp)
                         ld $s2, 16($sp)
                         daddi $sp, $sp, 24
                         jr $ra
#include input_unsigned.s
