;main() { 
;  char *a0,LET[16]; 
;  int i, a1,a2, val;      
          
;     for(i=0; i<3;i++) 
;     { 
;       printf("Inserisci una stringa di lettere maiuscole \n"); 
;      scanf("%s",LET); 
;      printf("Inserisci un numero minore di 26\n"); 
;       scanf("%d",&a2); 
;       a0=LET; 
;       a1=strlen(LET); 
;      val= calcola(a0,a1,a2); 
;  if(val>=0)  
;    printf("Il risultato e' %d\n", val); 
    
;     } 
       
;} 
 
;int calcola(char *a0, int a1, int a2) 
;{int s0,s1, n; 
   
;  s1=0; 
;  for(s0=0;s0<a1;s0++) 
;    {  
;  n=a0[s0]-65;    
;  if(n<0)  
;    break;  
;  if(n<a2) 
;    s1 += n; 
; } 
;  if(s0!=0) 
;  return s1/s0; 
;  else return -1;    
;}

.data
LET: .space 16

m1: .asciiz "Inserisci una stringa di lettere maiuscole \n"
m2: .asciiz "Inserisci un numero minore di 26\n"
m3: .asciiz "Il risultato e' %d\n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;  char *a0,LET[16]; 
;  int i, a1,a2, val;      
daddi $s0, $0, 0
;     for(i=0; i<3;i++) 
for: slti $t0, $s0, 3
        beq $t0, $0, fine_exe
;       printf("Inserisci una stringa di lettere maiuscole \n"); 
        daddi $t1, $0, m1
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;      scanf("%s",LET); 
       daddi $a0, $0, LET ; $a0 = LET
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a1, r1  ; $a1 = strlen(LET)
;      printf("Inserisci un numero minore di 26\n"); 
       daddi $t1, $0, m2
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;       scanf("%d",&a2); 
      jal input_unsigned
      move $a2, r1 ; $a2 = a2
;      val= calcola(a0,a1,a2); 
      jal calcola
;  if(val>=0)  
;    printf("Il risultato e' %d\n", val); 
      slti $t1, r1, 0
      bne $t1, $0, incrementa_i
 ;   printf("Il risultato e' %d\n", val); 
      sd r1, p2s5($0)
      daddi $t1, $0, m3
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5

incrementa_i: daddi $s0, $s0, 1
                          j for

fine_exe: syscall 0

;int calcola(char *a0, int a1, int a2) 
;{int s0,s1, n; 
   
;  s1=0; 
;  for(s0=0;s0<a1;s0++) 

calcola: daddi $sp, $sp, -24
               sd $s0, 0($sp)  
               sd $s1, 8($sp)
               sd $s2, 16($sp) ; n
               daddi $s0, $0, 0  ; $s0 = 0
               daddi $s1, $0, 0  ; $s1 = 0

forf:       slt $t0, $s0, $a1
               beq $t0, $0, if_funzione
;  n=a0[s0]-65;    
               dadd $t1, $s0, $a0
               lbu $s2, 0($t1)
               daddi $s2, $s2, -65  ; $s2 = a0[s0] - 65
;  if(n<0)  
;    break;  
              slti $t2, $s2, 0
              bne $t2, $0, if_funzione
;  if(n<a2)
;    s1 += n; 
              slt $t2, $s2, $a2
              beq $t2, $0, incrementa_s0
              dadd $s1, $s1, $s2

incrementa_s0: daddi $s0, $s0, 1
                              j forf

if_funzione: beq $s0, $0, else_funzione 
;  return s1/s0; 
                       ddiv $s1, $s0
                       mflo r1
                       ld $s0, 0($sp)  
                       ld $s1, 8($sp)
                       ld $s2, 16($sp) ; n
                       daddi $sp, $sp, 24
                       jr $ra

;  else return -1;    
else_funzione:  daddi r1, $0, -1
                              ld $s0, 0($sp)  
                              ld $s1, 8($sp)
                              ld $s2, 16($sp) ; n
                              daddi $sp, $sp, 24
                              jr $ra

#include input_unsigned.s
