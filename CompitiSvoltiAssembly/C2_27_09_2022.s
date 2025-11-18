;main() { 
;  char STR1[16],STR2[16];  
;  int i,dim,ris;      
       
;   for(i=0;i<3;i++) 
;   { 
;    printf("Inserisci una prima stringa\n"); 
;    scanf("%s",STR1); 
;    printf("Inserisci una seconda stringa di %d caratteri \n",strlen(STR1)); 
;    scanf("%s",STR2); 
             
;    ris= processa(STR1,STR2,strlen(STR1));  
; printf("Risultato=' %d \n",ris);  
   
;   }      
;}

.data
STR1: .space 16
STR2: .space 16

m1: .asciiz "Inserisci una prima stringa\n"
m2: .asciiz "Inserisci una seconda stringa di %d caratteri \n"
m3: .asciiz "Risultato=' %d \n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code 
;  char STR1[16],STR2[16];  
;  int i,dim,ris;      
daddi $s0, $0, 0       
;   for(i=0;i<3;i++) 
for: slti $t0, $s0, 3
       beq $t0, $0, fine_exe
;    printf("Inserisci una prima stringa\n"); 
;    scanf("%s",STR1); 
      daddi $t0, $0, m1
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5

      daddi $a0, $0, STR1
      sd $a0, ind($0)
      daddi r14, $0, p1s3
      syscall 3
      move $a2, r1

;    printf("Inserisci una seconda stringa di %d caratteri \n",strlen(STR1)); 
;    scanf("%s",STR2); 
     sd $a2, p2s5($0)
     daddi $t0, $0, m2
     sd $t0, p1s5($0)
     daddi r14, $0, p1s5
     syscall 5

     daddi $a1, $0, STR2
     sd $a1, ind($0)
     daddi r14, $0, p1s3
     syscall 3

     jal processa
; printf("Risultato=' %d \n",ris);  
     sd r1, p2s5($0)
     daddi $t0, $0, m3
     sd $t0, p1s5($0)
     daddi r14, $0, p1s5
     syscall 5

incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0


;int processa(char *st1, char *st2, int d) 
;{ int j,conta; 
   
;    conta=0; 
;    for(j=0;j<d;j++) 
;     if (st1[j] < st2[j] ) 
;    { st1[j]= 48; 
;      conta++; 
;    } 
  
;   return conta; 
;} 

processa:  daddi $sp, $sp, -16
                    sd $s0, 0($sp)  ; j
                    sd $s1, 8($sp)  ; conta
                    daddi $s0, $0, 0  ; j = 0
                    daddi $s1, $0, 0  ; conta = 0

forf:             slt $t0, $s0, $a2
                     beq $t0, $0, return_conta
                     dadd $t1, $s0, $a0
                     lbu $t2, 0($t1) ; $t2 = st1[j]
                     dadd $t3, $s0, $a1
                     lbu $t4,  0($t3) ; $t4 = st2[j]
                     slt $t5, $t2, $t4
                     beq $t5, $0, incrementa_if
                     daddi $t2, $0, 48
                     daddi $s1, $s1, 1

incrementa_if: daddi $s0, $s0, 1
                            j forf

return_conta:  move r1, $s1
                           ld $s0, 0($sp)  ; j
                           ld $s1, 8($sp)  ; conta
                           daddi $sp, $sp, 16
                           jr $ra
