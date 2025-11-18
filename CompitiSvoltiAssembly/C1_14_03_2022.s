;int elabora(char *vet, int d) 
;{ int i,pari; 
;    pari=0; 
;    for(i=0;i<d;i++) 
;       if(vet[i]%2==0) 
;       pari++;  
       
;   return pari; 
;} 
 
;main() { 
;  char VAL[32]; 
;  int i,ris,numero;      
                
;  for(i=0;i<3;i++) { 
;   printf("Inserisci una stringa con almeno 4 caratteri\n"); 
;   scanf("%s",VAL); 
;   if(strlen(VAL)<4) 
;      { printf("Inserisci un numero maggiore di %d\n",strlen(VAL)); 
;     scanf("%d",&ris); 
;      } 
;   else  
;    ris=elabora(VAL,strlen(VAL));         
;  printf(" Ris[%d]= %d \n",i,ris);  
;  }  
    
 ;}

.data
VAL: .space 32

m1: .asciiz "Inserisci una stringa con almeno 4 caratteri\n"
m2: .asciiz "Inserisci un numero maggiore di %d\n" 
m3: .asciiz " Ris[%d]= %d \n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 32

.code
;  char VAL[32]; 
;  int i,ris,numero;      
daddi $s0, $0, 0                
;  for(i=0;i<3;i++) { 
for: slti $t0, $s0, 3
       beq $t0, $0, fine_exe
;   printf("Inserisci una stringa con almeno 4 caratteri\n"); 
      daddi $t0, $0, m1
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;   scanf("%s",VAL); 
     daddi $a0, $0, VAL
     sd $a0, ind($0)
    daddi r14, $0, p1s3
    syscall 3
    move $a1, r1
;   if(strlen(VAL)<4) 
;      { printf("Inserisci un numero maggiore di %d\n",strlen(VAL)); 
;     scanf("%d",&ris); 
;      } 
     slti $t0, $a1, 4
     beq $t0, $0, else
     sd $a1, p2s5($0)
     daddi $t0, $0, m2
     sd $t0, p1s5($0)
     daddi r14, $0, p1s5
     syscall 5
     jal input_unsigned
     j incrementa_i

else: jal elabora
         sd $s0, p2s5($0)
         sd r1, p3s5($0)
         daddi $t0, $0, m3
         sd $t0, p1s5($0)
         daddi r14, $0, p1s5
         syscall 5

incrementa_i: daddi $s0, $s0, 1
                          j for

fine_exe: syscall 0

;int elabora(char *vet, int d) 
; $a0 = vet, $a1 = d
;{ int i,pari; 
;    pari=0; 
;    for(i=0;i<d;i++) 
;       if(vet[i]%2==0) 
;       pari++;  
       
;   return pari; 
;} 
elabora: daddi $sp, $sp, -16
                sd $s0, 0($sp) ; i
                sd $s1, 8($sp) ; pari
                daddi $s0, $0, 0 ; i = 0
                daddi $s1, $0, 0 ; pari = 0

forf:       slt $t0, $s0, $a1
               beq $t0, $0, return_pari

               dadd $t1, $a0, $s0
               lbu $t2, 0($t1)
               daddi $s2, $0, 2
               ddiv $t2, $s2
               mfhi $t3  ; $t3 = vet[i] % 2
               
               bne $t3, $0, incrementa_if
               daddi $s1, $s1, 1

incrementa_if: daddi $s0, $s0, 1
                           j forf

return_pari: move r1, $s1
                       ld $s0, 0($sp)
                       ld $s1, 8($sp)
                      daddi $sp, $sp, 16
                       jr $ra
#include input_unsigned.s
