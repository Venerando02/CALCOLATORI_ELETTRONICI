;int processa(char *st, char val, int d) 
;{ int j,cnt; 
;cnt=0; 
;for(j=0;j<d;j++) 
;if(st[j]<val) 
;cnt++; 
;return cnt; 
;} 

;main() { 
;char ST[16]; 
;int i,pos,conta;      
;for(i=0;i<4;i++) { 
;printf("Inserisci una stringa \n"); 
;scanf("%s",ST); 
;pos=strlen(ST)/2;   
;conta= processa(ST,ST[pos],strlen(ST));        
;printf(" Valore= %d \n",conta);  
;}   
;}

.data
ST: .space 16
stack: .space 32

m1: .asciiz "Inserisci una stringa \n"
m2: .asciiz " Valore= %d \n"

p1s3: .space 8
ind: .space 8
dim: .word 16

p1s5: .word 0
val: .space 8

.code 
; inizializzazione stack
daddi $sp, $0, stack
daddi $sp, $sp, 32
; inizializzazione i
daddi $s0, $0, 0
; for(i=0;i<4;i++) { 
for: slti $t0, $s0, 4
       beq $t0, $0, fine_es
; printf("Inserisci una stringa \n"); 
       daddi $t0, $0, m1
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;scanf("%s",ST); 
       daddi $a0, $0, ST ; $a0 = ST
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a2, r1 ; $a2 = strlen(ST)
;pos=strlen(ST)/2;   
       daddi $s1, $0, 2
       ddiv $a2, $s1
       mflo $s2
;conta= processa(ST,ST[pos],strlen(ST));                       
       lbu $a1, ST($s2)
       jal processa
       move $s3, r1
       sd $s3, val($0)
;printf(" Valore= %d \n",conta);         
       daddi $t0, $0, m2
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
       daddi $s0, $s0, 1
       j for

fine_es: syscall 0


processa: daddi $sp, $sp, -16
                  sd $s0, 0($sp)  ; j = 0
                  sd $s1, 8($sp)  ; cnt;
                  daddi $s0, $s0, 0
                  daddi $s1, $s1, 0
for_f: slt $t0, $s0, $a2
           beq $t0, $0, return
           ; st[j] = &str + i = $a0 + $s0
           dadd $t1, $s0, $a0 
           lbu $t2, 0($t1)
           slt $t0, $t2, $a1
           beq $t0, $0, return
           daddi $s1, $s1, 1

incr_i:  daddi $s0, $s0, 1
             j for_f

return:  move r1, $s1
              ld $s0, 0($sp)  ; j = 0
              ld $s1, 8($sp)  ; cnt;    
              daddi $sp, $sp, 16
              jr r31    
