;main() { 
;char STR[16]; 
;int val;      
;do{ 
;printf("Inserisci una stringa\n"); 
;scanf("%s",STR); 
;val=elabora(ST,strlen(ST));        
;if(val!=0) 
;printf(" Valore= %d \n",val);  
;} 
;while (val!=0); 
;}

.data
STR: .space 16

m1: .asciiz "Inserisci una stringa\n"
m2: .asciiz " Valore= %d \n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;char STR[16]; 
;int val;      
;do{ 
;printf("Inserisci una stringa\n"); 
;scanf("%s",STR); 
;val=elabora(ST,strlen(ST));        
;if(val!=0) 
;printf(" Valore= %d \n",val);  
;} 
;while (val!=0); 
;}
do: daddi $t0, $0, m1
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
      
       daddi $a0, $0, STR
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a1, r1
     
       jal elabora
       move $s1, r1
;if(val!=0) 
; se val = 0 allora vado alla fine_exe, altrimenti stampo e ritorno al do       
       beq $s1, $0, fine_exe 
;printf(" Valore= %d \n",val);         
       sd $s1, p2s5($0)
       daddi $t0, $0, m2
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
       j do

fine_exe: syscall 0

 ;int elabora(char *st, int d) 
;{   
;int i,conta; 
;conta=0; 
;for(i=0;i<d;i++) 
;if(st[i]<58)  
;conta++;   
;return conta; 
;}
elabora: daddi $sp, $sp, -16
                sd $s0, 0($sp) ; i
                sd $s1, 8($sp)  ; conta
                daddi $s0, $0, 0  ; i = 0
                daddi $s1, $0, 0  ; conta = 0

forf:        slt $t0, $s0, $a1
                beq $t0, $0, return_conta
                dadd $t1, $s0, $a0
                lbu $t2, 0($t1)
                slti $t0, $t2, 58
                beq $t0, $0, incr_if
                daddi $s1, $s1, 1

incr_if:   daddi $s0, $s0, 1
                j forf

return_conta: move r1, $s1
                           ld $s0, 0($sp)
                           ld $s1, 8($sp)
                           daddi $sp, $sp, 16
                           jr $ra
