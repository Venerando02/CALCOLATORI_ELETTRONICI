; int calcola(char *s, int d, char val) 
;{ int j,sm; 
;    sm=0;   
;    for(j=0;j<d;j++) 
;     if(s[j]<val) 
;     sm=sm+s[j]/2; 
;  else sm=sm+s[j]-val;           
;   return sm; 
; } 
 
;main() { 
;  char stringa[16]; 
;  int i,num,ris;      
;   printf("Inserisci un valore di soglia "); 
;    scanf("%d",&num); 
;   for(i=0;i<3;i++) 
;   { 
;    printf("Inserisci una stringa  \n"); 
;    scanf("%s",stringa);     
;    ris= calcola(stringa,strlen(stringa),num);  
;    printf("Il valore calcolato  e' %d \n",ris);   
;   }   
; }

.data
stack: .space 32
stringa: .space 16

m1: .asciiz "Inserisci un valore di soglia "
m2: .asciiz "Inserisci una stringa  \n"
m3: .asciiz "Il valore calcolato  e' %d \n"

p1s3: .word 0
ind: .space 8
dim: .word 16

p1s5: .space 8
ris: .space 8

.code
daddi $sp, $0, stack
daddi $sp, $sp, 32
;  char stringa[16]; 
;  int i,num,ris;      
daddi $s0, $0, 0 ; i = 0
;   printf("Inserisci un valore di soglia "); 
daddi $t0, $0, m1
sd $t0, p1s5($0)
daddi r14, $0, p1s5
syscall 5
;    scanf("%d",&num); 
jal input_unsigned
move $a1, r1
;   for(i=0;i<3;i++) 
for: slti $t0, $s0, 3
      beq $t0, $0, fine_esec
;    printf("Inserisci una stringa  \n"); 
      daddi $t0, $0, m2
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5    
;    scanf("%s",stringa);     
      daddi $a0, $0, stringa
      sd $a0, ind($0)
      daddi r14, $0, p1s3
      syscall 3
      move $a2, r1
;    ris= calcola(stringa,strlen(stringa),num);  
      jal calcola
      move $s1, r1  ; $s1 = ris
;    printf("Il valore calcolato  e' %d \n",ris);         
      sd $s1, ris($0)
      daddi $t0, $0, m3
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
         
      daddi $s0, $s0, 1  ; i++
      j for

fine_esec: syscall 0

;{ int j,sm; 
;    sm=0;   
;    for(j=0;j<d;j++) 
;     if(s[j]<val) 
;     sm=sm+s[j]/2; 
;  else sm=sm+s[j]-val;           
;   return sm; 
calcola: daddi $sp, $sp, -32
             sd $s0, 0($sp) ; j 
             sd $s1, 8($sp) ; sm
             daddi $s0, $0, 0 
             daddi $s1, $0, 0

for_f:     slt $t0, $s0, $a1
             beq $t0, $0, return_sm
             dadd $t1, $s0, $a0  ; &s[j] = &str + j
             lbu $t2, 0($t1)  ; s[j]
             
             daddi $s2, $0, 2  ; $s2 = 2 mi serve per la divisione
             daddi $s3, $0, 0  ; copierò il valore di $s3 su sm che è $s1
             
             slt $t3, $t2, $a2
             beq $t3, $0, else_f
             ddiv $t2, $s2
             mflo $t4   ; $t3 = s[j]/2
             dadd $s3, $s3, $t4
             j incr_j
             
 else_f:  sub $s4, $t2, $a2
             dadd $s3, $s3, $s4

incr_j:   daddi $s0, $s0, 1
             j for_f

return_sm:  dadd $s1, $0, $s3
                   move r1, $s1
                   ld $s0, 0($sp)  
                   ld $s1, 8($sp) 
                   daddi $sp, $sp, 32
                   jr $ra

#include input_unsigned.s
