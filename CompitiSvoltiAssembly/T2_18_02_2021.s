;int verifica(char *st,  int d) 
;{ int j; 
;for(j=0;j<d;j++) 
;if(st[j]>=st[j+1]) 
;break; 
;return j+1; 
;} 
;main() { 
;char STRINGA[16]; 
;int i, conta; 
;i=0; 
;do { 
;printf("Inserisci una stringa di numeri crescenti\n"); 
;scanf("%s",STRINGA); 
;conta= verifica(STRINGA, strlen(STRINGA));        
;printf("Valore = %d \n",conta);  
;i++; 
;} while (i<4 && strlen(STRINGA)==conta);  
;}

.data
stack: .space 32
STRINGA: .space 16

m1: .asciiz "Inserisci una stringa di numeri crescenti\n"
m2: .asciiz "Valore = %d \n"

p1s5: .space 8
conta: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code 
daddi $sp, $0, stack
daddi $sp, $sp, 32
;char STRINGA[16]; 
;int i, conta; 
;i=0;
daddi $s0, $0, 0 
;do { 
;printf("Inserisci una stringa di numeri crescenti\n"); 
do: daddi $t0, $0, m1
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5 
;scanf("%s",STRINGA); 
       daddi $a0, $0, STRINGA
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a1, r1
;conta= verifica(STRINGA, strlen(STRINGA));        
       jal verifica
       move $s1, r1 ; conta = r1
;printf("Valore = %d \n",conta);  
       sd $s1, conta($0)
       daddi $t0, $0, m2
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5 
;i++;
      daddi $s0, $s0, 1
      slti $t0, $s0, 4
      beq $t0, $t0, fine_ciclo
      bne $a1, $s1, fine_ciclo
      j do  
;} while (i<4 && strlen(STRINGA)==conta);  
;}

fine_ciclo: syscall 0

verifica: daddi $sp, $sp, -32
               sd $s0, 0($sp)  ; j = 0

for_f: slt $t0, $s0, $a1
           beq $t0, $0, return_j+1
           dadd $t1, $a0, $s0
           lbu $t2, 0($t1)
           lbu $t3, 1($t1)
           slt $t4, $t2, $t3
           beq $t4, $0, return_j+1
           daddi $s0, $s0, 1
           j for_f

return_j+1: daddi $s0, $s0, 1
                    move r1, $s0
                    ld $s0, 0($sp)
                    daddi $sp, $sp, 32
                    jr $ra
