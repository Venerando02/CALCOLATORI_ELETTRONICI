;int calcola(char *s, int d, int n) 
;{int j,cnt,incr ; 
   
;  cnt=0; 
;  incr=n/d; 
   
;  for(j=0;j<d;j++) 
;      if(s[j]-48<n) 
;      cnt=cnt+incr; 
  
;  return cnt;   
;}  
 
 
;main() { 
;  char STRING[16]; 
;  int i, n, len,ris;      
     
;     for(i=0; i<3;i++) 
;     { 
;  printf("Inserisci una stringa con almeno 4 caratteri \n"); 
;      scanf("%s",STRING); 
;      len=strlen(STRING); 
;      printf("Inserisci un numero maggiore o uguale a %d\n",len); 
;      scanf("%d",&n); 
;  if(n<len) 
;     n=len;  
;      ris= calcola(STRING,len,n);        
;      if(ris>0)     
;       printf("ciclo %d: Risultato = %d\n", i, ris) ; 
      
;     }  
;}

.data
STRING: .space 16

m1: .asciiz "Inserisci una stringa con almeno 4 caratteri \n"
m2: .asciiz "Inserisci un numero maggiore o uguale a %d\n"
m3: .asciiz "ciclo %d: Risultato = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;  char STRING[16]; 
;  int i, n, len,ris;      
daddi $s0, $0, 0 ; i =0     
;     for(i=0; i<3;i++) 
for: slti $t0, $s0, 3
         beq $t0, $0, fine_exe
;  printf("Inserisci una stringa con almeno 4 caratteri \n"); 
        daddi $t1, $0, m1
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;      scanf("%s",STRING); 
;      len=strlen(STRING); 
       daddi $a0, $0, STRING
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a1, r1
;      printf("Inserisci un numero maggiore o uguale a %d\n",len); 
       sd $a1, p2s5($0)
       daddi $t1, $0, m2
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;      scanf("%d",&n); 
       jal input_unsigned
       move $a2, r1
;  if(n<len) 
       slt $t1, $a2, $a1
       beq $t1, $0, succ
;     n=len;  
       dadd $a2, $0, $a1
;      ris= calcola(STRING,len,n);        
succ: jal calcola
;      if(ris>0)     
;       printf("ciclo %d: Risultato = %d\n", i, ris) ; 
          slti $t1, r1, 0
          bne $t1, $0,  incrementa_i
          sd $s0, p2s5($0)
          sd r1, p3s5($0)
          daddi $t1, $0, m3
          sd $t1, p1s5($0)
          daddi r14, $0, p1s5
          syscall 5

 incrementa_i: daddi $s0, $s0, 1
                            j for

fine_exe: syscall 0

;int calcola(char *s, int d, int n) 
; $a0 = s, $a1 = d, $a2 = n
;{int j,cnt,incr ;    
;  cnt=0; 
;  incr=n/d; 
   
;  for(j=0;j<d;j++) 
;      if(s[j]-48<n) 
;      cnt=cnt+incr; 
  
;  return cnt;   
;}  
calcola:  daddi $sp, $sp, -24
                sd $s0, 0($sp) ; j
                sd $s1, 8($sp) ; cnt
                sd $s2, 16($sp) ; incr
                daddi $s1, $0, 0 ; cnt = 0
                ddiv $a2, $a1
                mflo $s2  ; $s2 = $a2 / $a1 = n / d
                daddi $s0, $0, 0 ; $s0 = 0 = j
;  for(j=0;j<d;j++) 
forf:        slt $t0, $s0, $a1
                beq $t0, $0, return_cnt
;      if(s[j]-48<n) 
                dadd $t1, $s0, $a0
                lbu $t2, 0($t1)
                daddi $t2, $t2, -48  ; s[j] - 48
                slt $t0, $t2, $a2
                beq $t0, $0, incr_if
;      cnt=cnt+incr; 
                dadd $s1, $s1, $s2

incr_if:  daddi $s0, $s0, 1
               j forf

return_cnt: move r1, $s1
                      ld $s0, 0($sp) 
                      ld $s1, 8($sp) 
                      ld $s2, 16($sp) 
                      daddi $sp, $sp, 24
                      jr $ra

#include input_unsigned.s
