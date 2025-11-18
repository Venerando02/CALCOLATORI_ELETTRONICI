;main() { 
;  char STRINGA[32]; 
;  int i,a1,num,valore;      
    
; for(i=0;i<4;i++) 
;  {   
;  printf("%d Inserisci una stringa con almeno 2 numeri\n",i); 
;  scanf("%s",STRINGA); 
;  a1=strlen(STRINGA); 
  
;  printf("%d) Inserisci un numero ad una sola cifra\n",i); 
;  scanf("%d",&num); 
 
;  valore= calcola(STRINGA, a1,num); 
   
;  if(valore!=-1) 
;      printf("%d Risultato = %d\n",i, valore); 
 
;  }  
   
;}

.data
STRINGA: .space 32

m1: .asciiz "%d Inserisci una stringa con almeno 2 numeri\n"
m2: .asciiz "%d) Inserisci un numero ad una sola cifra\n"
m3: .asciiz "%d Risultato = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 32

.code
;  char STRINGA[32]; 
;  int i,a1,num,valore;      
daddi $s0, $0, 0    
; for(i=0;i<4;i++) 
for: slti $t0, $s0, 4
       beq $t0, $0, fine_exe
;  printf("%d Inserisci una stringa con almeno 2 numeri\n",i); 
       sd $s0, p2s5($0)
       daddi $t0, $0, m1
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;  scanf("%s",STRINGA); 
      daddi $a0, $0, STRINGA
      sd $a0, ind($0)
      daddi r14, $0, p1s3
      syscall 3
      move $a1, r1
;  printf("%d) Inserisci un numero ad una sola cifra\n",i); 
      sd $s0, p2s5($0)
      daddi $t0, $0, m2
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;  scanf("%d",&num); 
      jal input_unsigned
      move $a2, r1
      daddi $s1, $0, -1
;  valore= calcola(STRINGA, a1,num); 
      jal calcola
      move $s2, r1
      beq $s2, $s1, incrementa_i
;      printf("%d Risultato = %d\n",i, valore); 
      sd $s0, p2s5($0)
      sd $s2, p3s5($0)     
      daddi $t0, $0, m3
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5

incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0

;int calcola(char *str, int a1, int num) 
; $a0 = str, $a1 = a1, $a2 = num
;{ int i,s,c;  
;   c=0; 
;   s=0; 
;   for(i=0;i<a1;i++) 
;    if(str[i]<58) 
;    {s=s+str[i]-48; 
;     c++; 
;      }  
   
;  if(c<2)   
;      return -1; 
;  else return s/num;            
 
;} 

calcola: daddi $sp, $sp, -24
               sd $s0, 0($sp)  ; i
               sd $s1, 8($sp)  ; s
               sd $s2, 16($sp)  ; c
               daddi $s0, $0, 0
               daddi $s1, $0, 0
               daddi $s2, $0, 0

forf:       slt $t0, $s0, $a1
               beq $t0, $0, if_f
;    if(str[i]<58) 
;    {s=s+str[i]-48; 
;     c++; 
;      }  
              dadd $t1, $s0, $a0
              lbu $t2, 0($t1)  ; $t2 = str[i]
              slti $t0, $t2, 58
              beq $t0, $0, incr_if
              daddi $t3, $t2, -48
              dadd $s1, $s1, $t3
              daddi $s2, $s2, 1

incr_if:  daddi $s0, $s0, 1
               j forf

;  if(c<2)   
;      return -1; 
;  else return s/num;            
if_f:  slti $t0, $s2, 2
         beq $t0, $0, return_s_num
         daddi r1, $0, -1
         ld $s0, 0($sp) 
         ld $s1, 8($sp)
         ld $s2, 16($sp)
         daddi $sp, $sp, 24
         jr $ra

return_s_num: ddiv $s1, $a2
                             mflo r1 
                             ld $s0, 0($sp)  
                             ld $s1, 8($sp)  
                             ld $s2, 16($sp)
                             daddi $sp, $sp, 24
                             jr $ra

#include input_unsigned.s
