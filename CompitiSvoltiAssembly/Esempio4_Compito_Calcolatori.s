;int elabora(char *a0, int a1, int a2) 
;{   int i,conta; 
;conta=0; 
;for(i=0;i<a1;i++) 
;if(a0[i]-48<a2)   
;conta++; 
;return conta;             
;} 

;main() {
;char STRINGA[16]; 
;int A, num;      
;printf("Inserisci il numero minimo di caratteri\n"); 
;scanf("%d",&num) 
;do{ 
;printf("Inserire una stringa con almeno %d caratteri\n",num); 
;scanf("%s",STRINGA);         
;}
; while (strlen(STRINGA)<num); 
;A=elabora(STRINGA,strlen(STRINGA),num); 
;printf("A=%d", A);     
;}

.data
STRINGA: .space 16

m1: .asciiz "Inserisci il numero minimo di caratteri\n"
m2: .asciiz "Inserire una stringa con almeno %d caratteri\n" 
m3: .asciiz "A=%d"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;char STRINGA[16]; 
;int A, num;      
;printf("Inserisci il numero minimo di caratteri\n"); 
daddi $t0, $0, m1
sd $t0, p1s5($0)
daddi r14, $0, p1s5
syscall 5
jal input_unsigned
move $a2, r1

do: sd $a2, p2s5($0)
;printf("Inserire una stringa con almeno %d caratteri\n",num); 
      daddi $t0, $0, m2
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;scanf("%s",STRINGA);         
     daddi $a0, $0, STRINGA
     sd $a0, ind($0)
     daddi r14, $0, p1s3
     syscall 3
     move $a1, r1
; while (strlen(STRINGA)<num); 
do_while_condition: slt $t0, $a1, $a2
                                       bne $t0, $0, do
;A=elabora(STRINGA,strlen(STRINGA),num); 
     jal elabora
;printf("A=%d", A);     
    sd r1, p2s5($0)
    daddi $t0, $0, m3
    sd $t0, p1s5($0)
    daddi r14, $0, p1s5
    syscall 5

fine_exe: syscall 0

;int elabora(char *a0, int a1, int a2) 
;{   int i,conta; 
;conta=0; 
;for(i=0;i<a1;i++) 
;if(a0[i]-48<a2)   
;conta++; 
;return conta;             
;} 
elabora: daddi $sp, $sp, -16
                sd $s0, 0($sp)
                sd $s1, 8($sp)
                daddi $s0, $0, 0
                daddi $s1, $0, 0

forf:        slt $t0, $s0, $a1
                beq $t0, $0, return_conta
                dadd $t1, $s0, $a0
                lbu $t2, 0($t1)
                daddi $t2, $t2, -48
                slt $t0, $t2, $a2
                beq $t0, $0, incrementa_if
                daddi $s1, $s1, 1

incrementa_if: daddi $s0, $s0, 1
                            j forf

return_conta: move r1, $s1
                          ld $s0, 0($sp)
                          ld $s1, 8($sp)
                          daddi $sp, $sp, 16
                          jr $ra

#include input_unsigned.s
