;int calcola(char *str, int a1, int num) 
;{ int i,s,c; 
;c=0; 
;s=0; 
;for(i=0;i<a1;i++) 
;if(str[i]<58) 
;{s=s+str[i]-48; 
;c++; 
;}  
;if(c==0)   
;return -1; 
;else return s/num;    
;} 

;main() { 
;char STRINGA[32],*a0; 
;int i,a1,num,valore;      
;for(i=0;i<4;i++) 
;{   
;printf("%d Inserisci una stringa con almeno 2 numeri\n",i); 
;scanf("%s",STRINGA); 
;a0= STRINGA; 
;a1=strlen(STRINGA); 
;if(a1>=2) 
;{ 
;printf("%d) Inserisci un numero ad una sola cifra\n",i); 
;scanf("%d",&num); 
;valore=calcola(a0, a1,num); 
;if(valore<0) 
;printf("%d Risultato = %d\n",i, valore); 
;}  
;} 
;}

.data
STRINGA: .space 32

m1: .asciiz "%d Inserisci una stringa con almeno 2 numeri\n"
m2: .asciiz "%d) Inserisci un numero ad una sola cifra\n"
m3: .asciiz "%d Risultato = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 32

.code
;char STRINGA[32],*a0; 
;int i,a1,num,valore;      
daddi $s0, $0, 0 ; i = 0
;for(i=0;i<4;i++) 
for: slti $t0, $s0, 4
        beq $t0, $0, fine_exe
;printf("%d Inserisci una stringa con almeno 2 numeri\n",i); 
        sd $s0, p2s5($0)
        daddi $t0, $0, m1
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;scanf("%s",STRINGA); 
;a0= STRINGA;
;a1=strlen(STRINGA); 
        daddi $a0, $0, STRINGA
        sd $a0, ind($0)
        daddi r14, $0, p1s3
        syscall 3
        move $a1, r1
;if(a1>=2) 
        slti $t0, $a1, 2
        bne $t0, $0, incr_i 
; printf("%d) Inserisci un numero ad una sola cifra\n",i); 
        daddi $t0, $0, m2
        sd $t0, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;scanf("%d",&num); 
       jal input_unsigned
;valore=calcola(a0, a1,num);
       move $a2, r1
       jal calcola      
;if(valore>0)
       move $s1, r1
       slti $t0, $s1, 0
       bne $t0, $0, incr_i
;printf("%d Risultato = %d\n",i, valore);       
       sd $s1, p3s5($0)
       daddi $t0, $0, m3
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5

incr_i: daddi $s0, $s0, 1
             j for

fine_exe: syscall 0

;int calcola(char *str, int a1, int num) 
; $a0 = str, $a1 = a1, $a2 = num
;{ int i,s,c; 
;c=0; 
;s=0; 

calcola: daddi $sp, $sp, -24
               sd $s0, 0($sp) ; i
               sd $s1, 8($sp) ; s
               sd $s2, 16($sp) ; c
               daddi $s0, $0, 0  ; i = 0
               daddi $s1, $0, 0  ; s = 0
               daddi $s2, $0, 0  ; c = 0
;for(i=0;i<a1;i++) 
for_funzione: slt $t0, $s0, $a1
                          beq $t0, $0, if_funzione
;if(str[i]<58) 
                          dadd $t1, $s0, $a0
                          lbu $t2, 0($t1)       ; $t2 = str[i];
                          slti $t0, $t2, 58
                          beq $t0, $0, incr_i_funzione
;s=s+str[i]-48;                          
                          daddi $t2, $t2, -48
                          dadd $s1, $s1, $t2
;c++;   
                          daddi $s2, $s2, 1

incr_i_funzione: daddi $s0, $s0, 1
                               j for_funzione

;return -1; 
if_funzione:        bne $s2, $0, else_funzione
                              daddi r1, $0, -1
                              ld $s0, 0($sp) 
                              ld $s1, 8($sp) 
                              ld $s2, 16($sp)
                              daddi $sp, $sp, 24
                              jr $ra 
 
;else return s/num;                  
else_funzione:  ddiv $s1, $a2
                              mflo r1
                              ld $s0, 0($sp)
                              ld $s1, 8($sp)
                              ld $s2, 16($sp)
                              daddi $sp, $sp, 24
                              jr $ra 


#include input_unsigned.s
