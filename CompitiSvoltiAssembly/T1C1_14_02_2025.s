;main() { 
;  char stringa[8]; 
;  int i, a2,ris;      
;  long numero; 
     
;     for(i=0; i<3;i++) 
;     { 
;   printf("Inserisci una stringa con al massimo 6 caratteri (solo lettere maiuscole)\n"); 
;       scanf("%s",stringa); 
     
;   printf("Inserisci un numero di %d cifre\n",strlen(stringa) ); 
;       scanf("%ld",&numero); 
        
;       ris= elabora(stringa,numero, strlen(stringa));        
        
;   printf("Ciclo %d: Risultato = %d\n", i, ris) ; 
            
;     }  
;} 
 
 
;int elabora(char *let, long num, int a2) 
;{int i,c; 
; int r; 
;  long n; 
   
;  n=num; 
;  c=0; 
; for(i=a2-1;i>=0;i--) 
;   { 
;    if(let[i]< 65 || let[i] >=91 ) 
;      break; 
  
; r = n %10;   
;     n = n / 10; 
   
;   if(r > let[i]-65)  
;  c++; 
;    }  
 
;return c; 
;}

.data
stringa: .space 8

m1: .asciiz "Inserisci una stringa con al massimo 6 caratteri (solo lettere maiuscole)\n"
m2: .asciiz "Inserisci un numero di %d cifre\n"
m3: .asciiz "Ciclo %d: Risultato = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 8

.code
;  char stringa[8]; 
;  int i, a2,ris;      
;  long numero; 
daddi $s0, $0, 0     
;     for(i=0; i<3;i++) 
for: slti $t0, $s0, 3
       beq $t0, $0, fine_exe
;   printf("Inserisci una stringa con al massimo 6 caratteri (solo lettere maiuscole)\n"); 
       daddi $t1, $0, m1
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;       scanf("%s",stringa); 
       daddi $a0, $0, stringa
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a2, r1
;   printf("Inserisci un numero di %d cifre\n",strlen(stringa) ); 
       sd $a2, p2s5($0)
       daddi $t1, $0, m2
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;       scanf("%ld",&numero); 
       jal input_unsigned
       move $a1, r1
;       ris= elabora(stringa,numero, strlen(stringa));        
       jal elabora
;   printf("Ciclo %d: Risultato = %d\n", i, ris) ;
       sd $s0, p2s5($0)
       sd r1, p3s5($0)
       daddi $t1, $0, m3
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5

incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0

; int elabora(char *let, long num, int a2) 
; $a0 = let, $a1 = num, $a2 = a2
;{int i,c; 
; int r; 
;  long n;    
;  n=num; 
;  c=0; 

elabora: daddi $sp, $sp, -32
                sd $s0, 0($sp) ; i
                sd $s1, 8($sp) ; c
                sd $s2, 16($sp) ; r
                sd $s3, 24($sp) ; n
                dadd $s3, $0, $a1 ; $s3 = $a1 = n = num
                daddi $s1, $0, 0     ; $s1 = c = 0
                daddi $s0, $a2, -1  ; $s0 = $a2 - 1 = i = a2 -1
; for(i=a2-1;i>=0;i--) 
forf:        slti $t0, $s0, 0
                bne $t0, $0, return_c
;    if(let[i]< 65 || let[i] >=91 ) 
;      break; 
                dadd $t0, $a0, $s0
                lbu $t1, 0($t0)  ; $t1 = let[i] 
                slti $t2, $t1, 65
                bne $t2, $0, return_c
                slti $t2, $t1, 91
                beq $t2, $0, return_c
; r = n %10;   
                daddi $s4, $0, 10
                ddiv $s3, $s4
                mfhi $s2
;     n = n / 10; 
                mflo $s3
;   if(r > let[i]-65)
                daddi $t1, $t1, -65  ; $t1 = $t1 - 65 = let[i] - 65
                slt $t2, $t1, $s2  ; if(let[i] - 65 < r)  
                beq $t2, $0, decrementa_i
;  c++; 
                daddi $s1, $s1, 1

decrementa_i: daddi $s0, $s0, -1
                            j forf

return_c:  move r1, $s1
                   ld $s0, 0($sp)
                   ld $s1, 8($sp)
                   ld $s2, 16($sp)
                   ld $s3, 24($sp)
                   daddi $sp, $sp, 32
                   jr $ra



#include input_unsigned.s
