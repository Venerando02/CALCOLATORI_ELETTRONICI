;int verifica(char *st, int d) 
;{int i,conta_numeri; 
   
; conta_numeri=0; 
     
;  for(i=0;i<d;i++) 
;    {   
      
;    if(conta_numeri <2)  
;      if(st[i]>47 && st[i]<=57) 
;       conta_numeri++;       
; } 
;  return conta_numeri;   
;}  
 
 
;main() { 
;  char STRINGA[16]; 
;  int i, ris;      
     
      
 ;for(i=0; i<3;i++) 
; { 
;   do{ 
;   printf("Inserisci la stringa %d con almeno 4 caratteri e con almeno 2 numeri \n",i); 
 
;   scanf("%s",STRINGA); 
;   } while (strlen(STRINGA)<4); 
       
;   ris= verifica(STRINGA,strlen(STRINGA)); 
;   if(ris<2) 
;           printf("La stringa %d non e' valida\n",i); 
;   else 
;            printf("La stringa %d e' corretta\n",i); 
;  } 
       
;}

.data
STRINGA: .space 16

m1: .asciiz "Inserisci la stringa %d con almeno 4 caratteri e con almeno 2 numeri \n"
m2: .asciiz "La stringa %d non e' valida\n"
m3: .asciiz "La stringa %d e' corretta\n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;  char STRINGA[16]; 
;  int i, ris;      
daddi $s0, $0, 0           
 ;for(i=0; i<3;i++) 
for: slti $t0, $s0, 3
       beq $t0, $0, fine_exe
;   do{ 
;   printf("Inserisci la stringa %d con almeno 4 caratteri e con almeno 2 numeri \n",i); 
do: daddi $t1, $0, m1
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5 
;   scanf("%s",STRINGA); 
       daddi $a0, $0, STRINGA
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a1, r1
;   } while (strlen(STRINGA)<4); 
do_while_condition: slti $t1, $a1, 4
                                       bne $t1, $0, do
;   ris= verifica(STRINGA,strlen(STRINGA)); 
      jal verifica
      move $s1, r1 
;   if(ris<2) 
;          printf("La stringa %d non e' valida\n",i);      
      slti $t1, $s1, 2
      beq $t1, $0, else
      sd $s0, p2s5($0)
      daddi $t1, $0, m2
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
      j incrementa_i
;   else 
;            printf("La stringa %d e' corretta\n",i);       

else: sd $s0, p2s5($0)
          daddi $t1, $0, m3
          sd $t1, p1s5($0)
          daddi r14, $0, p1s5
          syscall 5 

incrementa_i: daddi $s0, $s0, 1
                          j for

;int verifica(char *st, int d) 
; $a0 = st, $a1 = d
;{int i,conta_numeri; 
   
; conta_numeri=0; 
     
;  for(i=0;i<d;i++) 
;    {         
;    if(conta_numeri <2)  
;      if(st[i]>47 && st[i]<=57) 
;       conta_numeri++;       
; } 
;  return conta_numeri;   
;}  

fine_exe: syscall 0

verifica: daddi $sp, $sp, -16
                sd $s0, 0($sp)  ; i
                sd $s1, 8($sp)  ; conta_numeri
                daddi $s0, $0, 0
                daddi $s1, $0, 0

forf:       slt $t0, $s0, $a1
               beq $t0, $0, return_conta_numeri
;    if(conta_numeri <2)  
               slti $t1, $s1, 2
               beq $t1, $0, incrementa_if
;      if(st[i]>47 && st[i]<=57) 
               dadd $t2, $a0, $s0
               lbu $t3, 0($t2)  ; $t3 = st[i]
               slti $t4, $t3, 47 
               bne $t4, $0, incrementa_if
               daddi $s2, $0, 57
               slt $t4, $s2, $t3  ; if(57 < st[i])
               bne $t4, $0, incrementa_if
;       conta_numeri++;       
               daddi $s1, $s1, 1

incrementa_if: daddi $s0, $s0, 1
                            j forf

return_conta_numeri: move r1, $s1
                                          ld $s0, 0($sp) 
                                          ld $s1, 8($sp) 
                                          daddi $sp, $sp, 16
                                          jr $ra
