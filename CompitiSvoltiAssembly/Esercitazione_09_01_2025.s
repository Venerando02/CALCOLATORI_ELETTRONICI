;int elabora(char *str, int a1, int a2) 
;{ int i,s; 
;s=0; 
;for(i=0;i<a1;i++) 
;{ 
;if(str[i]-48<0) // Esempio simboli ! # $ % & ( ) * + - / 
;return -1; 
;if(str[i]-48<a2 ) 
;s=s+str[i]-48; 
;} 
;return s;    
;}

;main() { 
;char STRINGA[16],*a0; 
;int i,a1,a2,valore;      
;for(i=0;i<4;i++) 
;{   
;printf("Inserisci una stringa di soli numeri con almeno 2 caratteri\n"); 
;scanf("%s",STRINGA); 
;if(strlen(STRINGA)>=2) 
;{ printf("%d) Inserisci un numero maggiore di %d\n",i, strlen(STRINGA)); 
;scanf("%d",&a2); 
;a0= STRINGA; 
;a1=strlen(STRINGA); 
;valore=elabora(a0, a1,a2); 
;printf("%d Risultato = %d\n",i, valore); 
;}  
;} 
;} 

.data
STRINGA: .space 16

m1: .asciiz "Inserisci una stringa di soli numeri con almeno 2 caratteri\n"
m2: .asciiz "%d) Inserisci un numero maggiore di %d\n"
m3: .asciiz "%d Risultato = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;char STRINGA[16],*a0; 
;int i,a1,a2,valore;      
daddi $s0, $0, 0 ; i = 0
;for(i=0;i<4;i++) 
for: slti $t0, $s0, 4
       beq $t0, $0, fine_exe
;printf("Inserisci una stringa di soli numeri con almeno 2 caratteri\n"); 
       daddi $t0, $0, m1
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;scanf("%s",STRINGA); 
       daddi $a0, $0, STRINGA ; $a0 = STRINGA
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a1, r1  ; $a1 = strlen(STRINGA)
;if(strlen(STRINGA)>=2) 
       slti $t0, $a1, 2
       bne $t0, $0, incr_i
; printf("%d) Inserisci un numero maggiore di %d\n",i, strlen(STRINGA));       
       sd $s0, p2s5($0)
       sd $a1, p3s5($0)
       daddi $t0, $0, m2
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;scanf("%d",&a2); 
       jal input_unsigned
       move $a2, r1 
;valore=elabora(a0, a1,a2); 
       jal elabora
       move $s1, r1
;printf("%d Risultato = %d\n",i, valore); 
       sd $s1, p3s5($0)
       daddi $t0, $0, m3
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5

incr_i: daddi $s0, $s0, 1
            j for

fine_exe: syscall 0

;int elabora(char *str, int a1, int a2)
; $a0 = str, $a1 = a1, $a2 = a2
;{ int i,s; 
;s=0; 
;for(i=0;i<a1;i++) 

elabora: daddi $sp, $sp, -16
                sd $s0, 0($sp)  ; i
                sd $s1, 8($sp)  ; s
                daddi $s0, $0, 0  ; i = 0
                daddi $s1, $0, 0  ; s = 0

for_funzione: slt $t0, $s0, $a1
                          beq $t0, $0, return_s
;if(str[i]-48<0) // Esempio simboli ! # $ % & ( ) * + - / 
;return -1; 
                          dadd $t0, $s0, $a0
                          lbu $t1, 0($t0)  ; $t1 = str[i]
                          daddi $t1, $t1, -48  ; $t1 = str[i] - 48

primo_if:          slti $t0, $t1, 0
                          beq $t0, $0, secondo_if
                          daddi r1, $0, -1
                          ld $s0, 0($sp)  ; i
                          ld $s1, 8($sp)  ; s
                          daddi $sp, $sp, 16
                          jr $ra
;if(str[i]-48<a2 ) 
;s=s+str[i]-48; 
secondo_if:    slt $t0, $t1, $a2
                          beq $t0, $0, incrementa_i_funzione
                          dadd $s1, $s1, $t1

incrementa_i_funzione: daddi $s0, $s0, 1
                                             j for_funzione

return_s:         move r1, $s1
                          ld $s0, 0($sp) 
                          ld $s1, 8($sp)
                          daddi $sp, $sp, 16
                          jr $ra

#include input_unsigned.s
