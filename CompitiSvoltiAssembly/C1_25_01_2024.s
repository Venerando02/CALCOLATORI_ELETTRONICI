;int processa(char *a0, char *a1) 
;{int j,c; 
 
;  c=0; 
;  j=0;   
;  while (a0[j]!=0 && a1[j]!=0) 
; { 
;         if(a0[j] == a1[j])  
;                  c++; 
;     j++; 
; }  
;   return c; 
; } 
 
;main() { 
;  char ST1[16], ST2[16]; 
;  int i, ris;      
     
;     for(i=0; i<4;i++) 
;     { 
;   printf("Inserisci una stringa\n"); 
;       scanf("%s",ST1); 
         
;   printf("Inserisci una stringa\n"); 
;       scanf("%s",ST2); 
 
;       ris= processa(ST1,ST2);        
        
  
;  printf("%d – Ris = %d\n", i, ris) ;    
;     }  
;} 

.data
ST1: .space 16
ST2: .space 16

m1: .asciiz "Inserisci una stringa\n"
m2: .asciiz "%d – Ris = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code 
;  char ST1[16], ST2[16]; 
;  int i, ris;      
daddi $s0, $0, 0 ; i = 0
for: slti $t0, $s0, 4
        beq $t0, $0, fine_exe
 ;   printf("Inserisci una stringa\n");
        daddi $t0, $0, m1
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;       scanf("%s",ST1); 
        daddi $a0, $0, ST1
        sd $a0, ind($0)
        daddi r14, $0, p1s3
        syscall 3
;   printf("Inserisci una stringa\n"); 
       daddi $t0, $0, m1
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;       scanf("%s",ST2); 
        daddi $a1, $0, ST2
        sd $a1, ind($0)
        daddi r14, $0, p1s3
        syscall 3
;       ris= processa(ST1,ST2);        
        jal processa
        sd $s0, p2s5($0)
        sd r1, p3s5($0)
        daddi $t0, $0, m2
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5 
; incrementa i
        daddi $s0, $s0, 1
        j for

fine_exe: syscall 0

;int processa(char *a0, char *a1) 
; $a0 = a0, $a1 = a1
;{int j,c; 
;  c=0; 
;  j=0;   
processa: daddi $sp, $sp, -16
                    sd $s0, 0($sp)  ; j
                    sd $s1, 8($sp)  ; c
                    daddi $s0, $0, 0  ; j = 0
                    daddi $s1, $0, 0  ; c = 0
                    
;  while (a0[j]!=0 && a1[j]!=0) 
while:       dadd $t0, $s0, $a0
                   lbu $t1, 0($t0) ; $t1 =  a0[j]
                   dadd $t2, $s0, $a1
                   lbu $t3, 0($t2) ; $t3 =  a1[j]
                   beq $t1, $0, return_c  
                   beq $t3, $0, return_c
                   daddi $s1, $s1, 1 ; c++

incrementa_j: daddi $s0, $s0, 1
                          j while       

return_c:  move r1, $s1
                   ld $s0, 0($sp)  ; j
                   ld $s1, 8($sp)  ; c
                   daddi $sp, $sp, 16
                   jr $ra
