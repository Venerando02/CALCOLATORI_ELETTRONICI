; C1_22_01_2025
;int esegui(char *let, char *num, int a2) 
;{int i,c;
; c=0; 
; for(i=0;i<a2;i++) 
;   { 
;    if(num[i]-48  < 0 || let[i] -91 >= 0) 
;        return -1; 
;    if(let[i] - 65 == num[i]-48)  
;  c++; 
;   }  
;  return c; 
;}

;main() { 
;char numeri[16], lettere[16]; 
;int i, a2,r1;      
     
;for(i=0; i<3;i++) 
 ;{ 
 ; printf("Inserisci una stringa di soli numeri\n"); 
 ; scanf("%s",numeri); 
 ; a2=strlen(numeri);     
 ; printf("Inserisci una stringa con %d caratteri di sole lettere maiuscole\n",a2); 
 ; scanf("%s",lettere); 
 
 ; r1= esegui(lettere,numeri, a2);        
 ; if(r1>=0)    
 ;       printf("Ciclo %d: Risultato = %d\n", i, r1) ; 
 ; else break;   
 ;}  
;} 
 
.data
NUMERI: .space 16
LETTERE: .space 16

m1: .asciiz "Inserisci una stringa di soli numeri\n"
m2: .asciiz "Inserisci una stringa con %d caratteri di sole lettere maiuscole\n"
m3: .asciiz "Ciclo %d: Risultato = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;char numeri[16], lettere[16]; 
;int i, a2,r1;      
daddi $s0, $0, 0 
;for(i=0; i<3;i++) 
for: slti $t0, $s0, 3
        beq $t0, $0, fine_exe
 ; printf("Inserisci una stringa di soli numeri\n"); 
        daddi $t1, $0, m1
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
 ; scanf("%s",numeri);
        daddi $a1, $0, NUMERI
        sd $a1, ind($0)
        daddi r14, $0, p1s3
        syscall 3
 ; a2=strlen(numeri);
        move $a2, r1      
 ; printf("Inserisci una stringa con %d caratteri di sole lettere maiuscole\n",a2); 
        sd $a2, p2s5($0)
        daddi $t1, $0, m2
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
; scanf("%s",lettere); 
        daddi $a0, $0, LETTERE
        sd $a0, ind($0)
        daddi r14, $0, p1s3
        syscall 3
 ; r1= esegui(lettere,numeri, a2);   
; $a0 = lettere, $a1 = numeri, $a2 = strlen(numeri)
        jal esegui
; if(r1>=0)   
        slt $t0, r1, $0
        bne $t0, $0, fine_exe  ; else break;  

 ;       printf("Ciclo %d: Risultato = %d\n", i, r1) ;
        sd $s0, p2s5($0)
        sd r1, p3s5($0)
        daddi $t1, $0, m3
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
; i++
        daddi $s0, $s0, 1
        j for

fine_exe: syscall 0

;int esegui(char *let, char *num, int a2) 
; $a0 = let, $a1 = num, $a2 = a2
;{int i,c;
; c=0; 
; for(i=0;i<a2;i++) 
esegui: daddi $sp, $sp, -16
               sd $s0, 0($sp)  ; i
               sd $s1, 8($sp)  ; c
               daddi $s0, $0, 0  ; i = 0
               daddi $s1, $0, 0  ; c = 0

forf:       slt $t0, $s0, $a2
               beq $t0, $0, return_c
;    if(num[i]-48  < 0 || let[i] -91 >= 0) 
               dadd $t1, $s0, $a1
               lbu $t2, 0($t1)
               daddi $t2, $t2, -48 ; $t2 = $t2 - 48 = num[i] - 48
               dadd $t3, $s0, $a0
               lbu $t4, 0($t3)        ; $t4 = let[i]
               daddi $s2, $t4, -91  ; $s2 = let[i] - 91
               slti $t5, $t2, 0
               bne $t5, $0, return_-1
;        return -1; 
               slti $t5, $s2, 0
               beq $t5, $0, return_-1
;    if(let[i] - 65 == num[i]-48) 
               daddi $s3, $t4, -65
               bne $s3, $t2, incr_i_f
;  c++; 
               daddi $s1, $s1, 1
              
incr_i_f:  daddi $s0, $s0, 1
                 j forf

return_-1: daddi r1, $0, -1
                   ld $s0, 0($sp)  ; i
                   ld $s1, 8($sp)  ; c
                   daddi $sp, $sp, 16
                   jr $ra

return_c:  move r1, $s1
                   ld $s0, 0($sp)  ; i
                   ld $s1, 8($sp)  ; c
                   daddi $sp, $sp, 16
                   jr $ra
