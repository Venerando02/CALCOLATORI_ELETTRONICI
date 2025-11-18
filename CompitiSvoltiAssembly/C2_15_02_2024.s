;main() { 
;  char STR[16],NUM[16]; 
;  int i, a2, ris;      
     
; for(i=0; i<4;i++) 
; { 
 
;  printf("Ciclo %d: Inserisci una stringa \n",i); 
;  scanf("%s",STR); 
  
;  do{ 
;  printf("Inserisci una stringa di numeri di dimensione %d \n", strlen(STR)); 
;  scanf("%s",NUM); 
;  } while (strlen(STR)!=strlen(NUM)); 
       
;  ris= processa_stringhe(STR,NUM,strlen(NUM));        
       
;  printf("%d Ris = %d\n", i, ris); 
    
; }  
;}

.data
STR: .space 16
NUM: .space 16

m1: .asciiz "Ciclo %d: Inserisci una stringa \n"
m2: .asciiz "Inserisci una stringa di numeri di dimensione %d \n"
m3: .asciiz "%d Ris = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;  char STR[16],NUM[16]; 
;  int i, a2, ris;      
daddi $s0, $0, 0     
; for(i=0; i<4;i++) 
for: slti $t0, $s0, 4
        beq $t0, $0, fine_exe
;  printf("Ciclo %d: Inserisci una stringa \n",i); 
        sd $s0, p2s5($0)
        daddi $t0, $0, m1
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;  scanf("%s",STR); 
        daddi $a0, $0, STR
        sd $a0, ind($0)
        daddi r14, $0, p1s3
        syscall 3
        move $s1, r1 
;  do{ 
;  printf("Inserisci una stringa di numeri di dimensione %d \n", strlen(STR)); 
;  scanf("%s",NUM); 
;  } while (strlen(STR)!=strlen(NUM)); 
do:  sd $s1, p2s5($0)
        daddi $t0, $0, m2
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
        
        daddi $a1, $0, NUM
        sd $a1, ind($0)
        daddi r14, $0, p1s3
        syscall 3
        move $a2, r1

do_while_condition: bne $s1, $a2, do

;  ris= processa_stringhe(STR,NUM,strlen(NUM));        
         jal processa_stringhe       
;  printf("%d Ris = %d\n", i, ris); 
        sd $s0, p2s5($0)
        sd r1, p3s5($0)
        daddi $t0, $0, m3
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5

        daddi $s0, $s0, 1
        j for
       
fine_exe: syscall 0

;int processa_stringhe(char *a0, char *a1, int n) 
; $a0 = a0, $a1 = a1, $a2 = n
;{int i,c,t; 
 
;  c=0;   
;  for(i=0;i<n;i++)  
;   {  
;     if(a1[i]<58)  
;      { 
;     t=a0[i]-a1[i]; 
;     if (t<10) 
;    c+= t; 
;      }  
;   }  
 
;return c; 
;} 
processa_stringhe: daddi $sp, $sp, -24
                                     sd $s0, 0($sp) ; i
                                     sd $s1, 8($sp) ; c
                                     sd $s2, 16($sp) ; t
                                     daddi $s0, $0, 0
                                     daddi $s1, $0, 0

forf: slt $t0, $s0, $a2
         beq $t0, $0, return_c
;     if(a1[i]<58)  
         dadd $t1, $a0, $s0
         lbu $t2, 0($t1) ; a0[i]
         dadd $t3, $a1, $s0
         lbu $t4, 0($t3)  ; a1[i]
         slti $t0, $t4, 58
         beq $t0, $0, incr_if
;     t=a0[i]-a1[i]; 
         dsub $s2, $t2, $t4
;     if (t<10) 
         slti $t0, $s2, 10
         beq $t0, $0, incr_if
;    c+= t; 
        dadd $s1, $s1, $s2

incr_if: daddi $s0, $s0, 1
              j forf

return_c: move r1, $s1
                  ld $s0, 0($sp) ; i
                  ld $s1, 8($sp) ; c
                  ld $s2, 16($sp) ; t
                  daddi $sp, $sp, 24
                  jr $ra                   
