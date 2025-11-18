; Esercitazione
;
; int elabora(char * a0, int a1)
; { int i;
;   for(i = 0; i<a1; i++)
;        if(a0[i] < 48 || a0[i] >= 58)
;                    return -1;
;    return a1;
;  }
;
;  main() { char STR[16];
;  int A_i, i, n;
;  for(i = 0; i<4; i++)
;  { 
;     printf("Inserire una stringa con soli numeri\n");
;     scanf("%s", STR);
;     do{
;           printf("Inserisci un numero minore di %d \n", strlen(STR));
;           scanf("%d", &n);
;      } while(n >= strlen(STR));
;      A_i = elabora(STR, n);
;      printf("A[%d] = %d", i, A_i);
;  }
; }

.data
STR: .space 16

m1: .asciiz "Inserire una stringa con soli numeri\n"
m2: .asciiz "Inserisci un numero minore di %d \n"
m3: .asciiz "A[%d] = %d"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
; char STR[16];
;  int A_i, i, n;
daddi $s0, $s0, 0 ; i = 0
;  for(i = 0; i<4; i++)
for: slti $t0, $s0, 4
       beq $t0, $0, fine_exe
;     printf("Inserire una stringa con soli numeri\n");
      daddi $t1, $0, m1
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;     scanf("%s", STR);
      daddi $a0, $0, STR
      sd $a0, ind($0)
      daddi r14, $0, p1s3
      syscall 3
      move $s1, r1
;     do
;           printf("Inserisci un numero minore di %d \n", strlen(STR));
do: sd $s1, p2s5($0) 
       daddi $t1, $0, m2
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;     scanf("%d", &n);
       jal input_unsigned
       move $a1, r1  ; $a1 = n

; while(n >= strlen(STR));
while_condition: slt $t1, $a1, $s1
                                beq $t1, $0, do
                                
;      A_i = elabora(STR, n);
succ:  jal elabora
;      printf("A[%d] = %d", i, A_i);
            sd $s0, p2s5($0)
            sd r1, p3s5($0)
            daddi $t1, $0, m3
            sd $t1, p1s5($0)
            daddi r14, $0, p1s5
            syscall 5
            daddi $s0, $s0, 1 ; i++
            j for

fine_exe: syscall 0

; int elabora(char * a0, int a1)
; { int i;
elabora: daddi $sp, $sp, -8
                sd $s0, 0($sp) ; i
                daddi $s0, $0, 0
;   for(i = 0; i<a1; i++)
for_funzione: slt $t0, $s0, $a1
                          beq $t0, $0, return_a1    
;        if(a0[i] < 48 || a0[i] >= 58)
                          dadd $t0, $s0, $a0
                          lbu $t1, 0($t0)  ; $t1 = a0[i]
                          slti $t2, $t1, 48
                          bne $t2, $0, return_-1
                          slti $t2, $t1, 58
                          beq $t2, $0, return_-1
                          j incrementa_i
;                    return -1;
return_-1:       daddi r1, $0, -1
                          ld $s0, 0($sp)
                          daddi $sp, $sp, 8
                          jr $ra             

incrementa_i: daddi $s0, $s0, 1
                            j for_funzione   

return_a1:      move r1, $a1
                          ld $s0, 0($sp)
                          daddi $sp, $sp, 8
                          jr $ra
#include input_unsigned.s
