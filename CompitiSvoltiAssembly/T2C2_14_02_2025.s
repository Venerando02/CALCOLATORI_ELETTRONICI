 ;main() { 
 ; char MAIUSCOLE[16]; 
 ; int i, a1,  soglia, risultato;      
     
 ;    for(i=0; i<3;i++) 
 ;    { 
 ;  do { 
 ;   printf("Inserisci una stringa con almeno 4 caratteri\n"); 
 ;       scanf("%s",MAIUSCOLE);  
 ;      } while (strlen(MAIUSCOLE)<4); 
 ;  printf("Inserisci un numero maggiore di %d (max 2 cifre)\n", strlen(MAIUSCOLE)); 
 ;      scanf("%d",&soglia); 
       
                   
 ;  risultato= calcola(MAIUSCOLE,strlen(MAIUSCOLE),soglia);        
       
;   printf("Ciclo %d ) Il risultato e'  %d\n", i, risultato) ; 
   
;     }  
;} 
 
;int calcola(char *mai, int a1, int th) 
;{int i,s; 
 
;  s=0;   
    
;  for(i=0;i<a1;i++)  
;   {  
;    if(mai[i] >= 91) // Se non e' una lettera maiuscola 
;  continue;  
; else 
; if (th < mai[i]-65 )    
; { 
;    s+=(mai[i]-65)/th; 
       
; } 
;   }  
 
;return s; 
;}

.data
MAIUSCOLE: .space 16

m1: .asciiz "Inserisci una stringa con almeno 4 caratteri\n"
m2: .asciiz "Inserisci un numero maggiore di %d (max 2 cifre)\n"
m3: .asciiz "Ciclo %d ) Il risultato e'  %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code 
; char MAIUSCOLE[16]; 
; int i, a1,  soglia, risultato;      
daddi $s0, $0, 0    
 ;    for(i=0; i<3;i++) 
for: slti $t0, $s0, 3
       beq $t0, $0, fine_exe 
 ;  do { 
 ;   printf("Inserisci una stringa con almeno 4 caratteri\n"); 
do:  daddi $t1, $0, m1
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;       scanf("%s",MAIUSCOLE);  
        daddi $a0, $0, MAIUSCOLE
        sd $a0, ind($0)
        daddi r14, $0, p1s3
        syscall 3 
        move $a1, r1
 ;      } while (strlen(MAIUSCOLE)<4); 
  do_while_condition: slti $t1, $a1, 4
                                         bne $t1, $0, do
;  printf("Inserisci un numero maggiore di %d (max 2 cifre)\n", strlen(MAIUSCOLE)); 
         sd $a1, p2s5($0)
         daddi $t1, $0, m2
         sd $t1, p1s5($0)
         daddi r14, $0, p1s5
         syscall 5
;      scanf("%d",&soglia); 
        jal input_unsigned
        move $a2, r1
 ;  risultato= calcola(MAIUSCOLE,strlen(MAIUSCOLE),soglia);        
        jal calcola
;   printf("Ciclo %d ) Il risultato e'  %d\n", i, risultato) ;
        sd $s0, p2s5($0)
        sd r1, p3s5($0)
        daddi $t1, $0, m3
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5

incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0

;int calcola(char *mai, int a1, int th) 
; $a0 = mai, $a1 = a1, $a2 = th
;{int i,s; 
;  s=0;   
;  for(i=0;i<a1;i++)  

calcola: daddi $sp, $sp, -16
               sd $s0, 0($sp)  ; i
               sd $s1, 8($sp)  ; s
               daddi $s0, $0, 0  ; i = 0 
               daddi $s1, $0, 0  ; s = 0

forf:       slt $t0, $s0, $a1
               beq $t0, $0, return_s
;    if(mai[i] >= 91) // Se non e' una lettera maiuscola 
;  continue;  
               dadd $t1, $a0, $s0
               lbu $t2, 0($t1)  ; $t2 = mai[i]
               slti $t3, $t2, 91
               bne $t3, $0, incrementa_i_funzione
; else 
; if (th < mai[i]-65 )    
; { 
;    s+=(mai[i]-65)/th;        
; } 
              daddi $s2, $t2, -65  ; $s2 = $t2 - 65 = mai[i] - 65
              slt $t3, $a2, $s2
              beq $t3, $0, incrementa_i_funzione
              ddiv $s2, $a2  ; mai[i] - 65 / th
              mflo $s3
              dadd $s1, $s1, $s3 

incrementa_i_funzione: daddi $s0, $s0, 1
                                             j forf

return_s: move r1, $s1
                  ld $s0, 0($sp)  ; i
                  ld $s1, 8($sp)  ; s
                  daddi $sp, $sp, 16
                  jr $ra

#include input_unsigned.s
