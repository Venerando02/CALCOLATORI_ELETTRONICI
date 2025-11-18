;main() { 
;  char STRING[16]; 
;  int i, n, ris;      
     
;     for(i=0; i<3;i++) 
;     { 
;   printf("Inserisci un numero \n"); 
;      scanf("%d",&n); 
;      n=n%10; 
;   do { 
;   printf("Inserisci una stringa con almeno %d caratteri\n",n); 
;      scanf("%s",STRING); 
;      } while (strlen(STRING)<n); 
     
;      ris= calcola(STRING,n);        
         
;      printf("Risultato stringa %d = %d\n", (i+1), ris) ; 
      
        
;     }  
;}

.data
STRING: .space 16

m1: .asciiz "Inserisci un numero \n"
m2: .asciiz "Inserisci una stringa con almeno %d caratteri\n"
m3: .asciiz "Risultato stringa %d = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;  char STRING[16]; 
;  int i, n, ris;      
daddi $s0, $0, 0
daddi $s1, $0, 0     
;     for(i=0; i<3;i++) 
for: slti $t0, $s0, 3
       beq $t0, $0, fine_exe
;   printf("Inserisci un numero \n"); 
;      scanf("%d",&n); 
;      n=n%10; 
      daddi $t1, $0, m1
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
      jal input_unsigned
      move $a1, r1
      daddi $s2, $0, 10
      ddiv $a1, $s2
      mfhi $a1 ; $a1 = n%10 = n

;   do { 
;   printf("Inserisci una stringa con almeno %d caratteri\n",n); 
do: sd $a1, p2s5($0)
       daddi $t1, $0, m2
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5

 ;      scanf("%s",STRING); 
      daddi $a0, $0, STRING
      sd $a0, ind($0)
      daddi r14, $0, p1s3
      syscall 3
      move $s3, r1 ; $s3 = strlen(STRING)
;      } while (strlen(STRING)<n); 
do_while_condition: slt $t1, $s3, $a1
                                       bne $t1, $0, do

;      ris= calcola(STRING,n);        
        jal calcola 

       daddi $s1, $s1, 1  ; i+1 = $s1

;      printf("Risultato stringa %d = %d\n", (i+1), ris) ; 
       sd $s1, p2s5($0)
       sd r1, p3s5($0)
       daddi $t1, $0, m3
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5

; incremento i
       daddi $s0, $s0, 1
       j for

fine_exe: syscall 0


;int calcola(char *s, int p) 
; $a0 = s, $a1 = p
;{int j,cnt, r; 
; char c; 
  
;  cnt=0; 
   
;  for(j=0;j<p;j++) 
;    {r=s[j]/16; 
;  if(r<4) 
;      cnt++; 
; } 
 
;  return cnt;   
;}  

calcola: daddi $sp, $sp, -24
               sd $s0, 0($sp) ; j
               sd $s1, 8($sp) ; cnt
               sd $s2, 16($sp) ; r
               daddi $s0, $0, 0
               daddi $s1, $0, 0
;  for(j=0;j<p;j++) 
;    {r=s[j]/16; 
;  if(r<4) 
;      cnt++; 
; } 
forf:      slt $t0, $s0, $a1
              beq $t0, $0, return_cnt
              dadd $t1, $a0, $s0
              lbu $t2, 0($t1)
              daddi $s4, $0, 16
              ddiv $t2, $s4
              mflo $s2
              slti $t1, $s2, 4
              beq $t1, $0, incr_if
              daddi $s1, $s1, 1

incr_if: daddi $s0, $s0, 1
              j forf

return_cnt:  move r1, $s1
                       ld $s0, 0($sp) ; j
                       ld $s1, 8($sp) ; cnt
                       ld $s2, 16($sp) ; r
                       daddi $sp, $sp, 24
                       jr $ra

#include input_unsigned.s
