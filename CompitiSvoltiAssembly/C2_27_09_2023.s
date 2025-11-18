; int calcola(char *st, int num) 
;{ int i,ris,t; 
 
;   t=1; 
;   ris=0; 
;   for(i=0;i<num-1;i+=2) 
;    if(st[i]<st[i+1]) 
;  { 
;  t++; 
;  ris+=st[i]-48; 
;  } 
                  
;   return ris/t; 
;} 
 
;main() { 
;  char STRINGA[32]; 
;  char *a0; 
;  int i,a1,valore;      
   
;  for(i=0;i<4;i++) 
;  { 
;   do{ 
;     printf("Inserisci una stringa con un numero pari di caratteri\n"); 
;     scanf("%s",STRINGA); 
;     a1=strlen(STRINGA); 
;   }while (a1%2==1); 
   
;    a0=STRINGA; 
;  valore=  calcola(a0,a1); 
; printf("Il risultato e' %d\n",valore); 
;  } 
    
;}

.data
 STRINGA: .space 32

m1: .asciiz "Inserisci una stringa con un numero pari di caratteri\n"
m2: .asciiz "Il risultato e' %d\n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 32

.code
;  char STRINGA[32]; 
;  char *a0; 
;  int i,a1,valore;      
daddi $s0, $0, 1
for: slti $t0, $s0, 4
       beq $t0, $0, fine_exe
;   do{ 
;     printf("Inserisci una stringa con un numero pari di caratteri\n"); 
do:  daddi $t1, $0, m1
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5       
;     scanf("%s",STRINGA); 
       daddi $a0, $0, STRINGA  ; $a0 = STRINGA
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
;     a1=strlen(STRINGA); 
       move $a1, r1  ; $a1 = strlen(STRINGA)
;   }while (a1%2==1); 
      daddi $s1, $0, 1
      daddi $s2, $0, 2
      ddiv $a1, $s2 
      mfhi $s3
      beq $s3, $s1, do
      jal calcola
;  valore=  calcola(a0,a1); 
; printf("Il risultato e' %d\n",valore); 
     sd r1, p2s5($0)
     daddi $t1, $0, m2
     sd $t1, p1s5($0)
     daddi r14, $0, p1s5
     syscall 5        

incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0

; int calcola(char *st, int num) 
; $a0 = str, $a1 = num
;{ int i,ris,t; 
;   t=1; 
;   ris=0; 
;   for(i=0;i<num-1;i+=2) 
calcola: daddi $sp, $sp, -24
               sd $s0, 0($sp) ; i
               sd $s1, 8($sp)  ; ris
               sd $s2, 16($sp) ; t
               
               daddi $s0, $0, 0 ; i = 0
               daddi $s1, $0, 0 ; ris = 0
               daddi $s2, $0, 1 ; t = 1
               daddi $a1, $a1, -1 ; $a1 = $a1 -1 = num-1

for_funzione: slt $t0, $s0, $a1
                          beq $t0, $0, return_ris
;    if(st[i]<st[i+1]) 
                          dadd $t1, $s0, $a0
                          lbu $t2, 0($t1)
                          lbu $t3, 1($t1)
                          slt $t4, $t2, $t3
                          beq $t4, $0,  incrementa_i_funzione
;  t++; 
                          daddi $s2, $s2, 1
;  ris+=st[i]-48; 
                          daddi $s1, $t2, -48 

incrementa_i_funzione: daddi $s0, $s0, 2
                                             j for_funzione

return_ris:      ddiv $s1, $s2
                          mflo r1
                          ld $s0, 0($sp) ; i
                          ld $s1, 8($sp)  ; ris
                          ld $s2, 16($sp) ; t
                          daddi $sp, $sp, 24
                          jr $ra
