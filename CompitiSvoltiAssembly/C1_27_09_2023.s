;int elabora(char *s, int d) 
;{ int i,t,c; 
 
; if(d<2) return -1; 
  
; t=0; 
; for(i=0;i<d-1;i++) 
;       if(s[i]==s[i+1]) 
;        t++; 
     
; return t; 
;} 
 
;main() { 
;  char STR[32]; 
;  char *a0; 
   
;  int i,a1,ris;      
    
;   for(i=0;i<3; i++)  
;     { 
;   do 
;   { 
;       printf("%d) Inserisci una stringa con almeno 2 caratteri\n",i);  
;       scanf("%s",STR); 
;       a1=strlen(STR); 
       
;   a0=STR; 
;   ris=elabora(a0,a1); 
    
;   printf(" Valore= %d \n",ris);  
       
;   }while(ris<0); 
      
;     }     
;}

.data
STR: .space 32

m1: .asciiz "%d) Inserisci una stringa con almeno 2 caratteri\n"
m2: .asciiz " Valore= %d \n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 32

.code 
;  char STR[32]; 
;  char *a0; 
;  int i,a1,ris;      
daddi $s0, $0, 0    
;   for(i=0;i<3; i++)  
for: slti $t0, $s0, 3
       beq $t0, $0, fine_exe

;       printf("%d) Inserisci una stringa con almeno 2 caratteri\n",i);  
;       scanf("%s",STR); 
do:  sd $s0, p2s5($0)
        daddi $t0, $0, m1
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
        daddi $a0, $0, STR
        sd $a0, ind($0)
        daddi r14, $0, p1s3
        syscall 3
        move $a1, r1
;       a1=strlen(STR); 
;     a0=STR; 
;   ris=elabora(a0,a1); 
       jal elabora
       move $s1, r1
;   printf(" Valore= %d \n",ris);  
        sd $s1, p2s5($0)
        daddi $t0, $0, m2
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5

do_while_condition: slti $t0, $s1, 0
                                       bne $t0, $0, do

incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0

;int elabora(char *s, int d) 
; $a0 = s, $a1 = d
;{ int i,t,c; 
 
; if(d<2) return -1; 
  
; t=0; 
; for(i=0;i<d-1;i++) 
;       if(s[i]==s[i+1]) 
;        t++; 
     
; return t; 
elabora: daddi $sp, $sp, -16
                 sd $s0, 0($sp) ; i
                 sd $s1, 8($sp) ; t
                 daddi $s0, $0, 0  ; i = 0
                 daddi $s1, $0, 0  ; t = 0              
if_1:         slti $t0, $a1, 2
                 bne $t0, $0, return_-1
                 daddi $a1, $a1, -1
forf:         slt $t0, $s0, $a1
                 beq $t0, $0, return_t 
                 dadd $t1, $s0, $a0
                 lbu $t2, 0($t1)
                 lbu $t3, 1($t1)
                 bne $t2, $t3, incr_if
                 daddi $s1, $s1, 1

incr_if:    daddi $s0, $s0, 1
                 j forf

return_-1: daddi r1, $0, -1
                   ld $s0, 0($sp)
                   ld $s1, 8($sp)
                   daddi $sp, $sp, 16
                   jr $ra

return_t:  move r1, $s1
                  ld $s0, 0($sp)
                  ld $s1, 8($sp)
                  daddi $sp, $sp, 16
                  jr $ra
