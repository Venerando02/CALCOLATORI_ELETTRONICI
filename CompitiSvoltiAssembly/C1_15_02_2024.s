; int calcola_ripetizioni(char *s, int p) 
;{int j,rip; 
; char c; 
  
;  rip=0; 
;  c=s[p]; 
;  for(j=p-1;j>=0;j--) 
;    if(s[j]==c) 
;      rip++; 
       
;  return rip;   
;}  
 
 
;main() { 
;  char ST[16]; 
;  int i, p, ris;      
     
;     for(i=0; i<4;i++) 
;     { 
;  printf("Inserisci una stringa\n"); 
;      scanf("%s",ST); 
         
;  do{ 
;      printf("Inserisci un numero minore di %d\n",strlen(ST)); 
;       scanf("%d",&p); 
;  } while (p>=strlen(ST)); 
    
;      ris= calcola_ripetizioni(ST,p);        
         
;     printf("%d - Num. ripetizioni = %d\n", i, ris) ; 
      
        
;     }  
;}

.data
ST: .space 16

m1: .asciiz "Inserisci una stringa\n"
m2: .asciiz "Inserisci un numero minore di %d\n"
m3: .asciiz "%d - Num. ripetizioni = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;  char ST[16]; 
;  int i, p, ris;      
daddi $s0, $0, 0 ; i = 0     
;     for(i=0; i<4;i++) 
for: slti $t0, $s0, 4
       beq $t0, $0, fine_exe
;  printf("Inserisci una stringa\n"); 
       daddi $t1, $0, m1
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;      scanf("%s",ST); 
       daddi $a0, $0, ST
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $s1, r1
;  do{ 
;      printf("Inserisci un numero minore di %d\n",strlen(ST)); 
do:  sd $s1, p2s5($0)
        daddi $t1, $0, m2
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;       scanf("%d",&p); 
        jal input_unsigned
        move $a1, r1
;  } while (p>=strlen(ST)); 
do_while_condition: slt $t1, $a1, $s1
                                       beq $t1, $0, do
        jal calcola_ripetizioni
;     printf("%d - Num. ripetizioni = %d\n", i, ris) ;
        sd $s0, p2s5($0)
        sd r1, p3s5($0)
        daddi $t1, $0, m3
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5

incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0

; int calcola_ripetizioni(char *s, int p) 
;{int j,rip; 
; char c; 
;  rip=0; 
;  c=s[p]; 
;  for(j=p-1;j>=0;j--) 
;    if(s[j]==c) 
;      rip++;       
;  return rip;   
;}  
; $a0 = s, $a1 = p
calcola_ripetizioni: daddi $sp, $sp, -24
                                   sd $s0, 0($sp)  ; j
                                   sd $s1, 8($sp)  ; rip
                                   sd $s2, 16($sp) ; c
                                   daddi $s1, $0, 0  ; rip = 0
                                   dadd $t0, $a0, $a1
                                   lbu $s2, 0($t0) ; c = s[p];
                                   daddi $s0, $a1, -1    ; j= p-1

forf:                            slti $t1, $s0, 0
                                    bne $t1, $0, return_rip
;    if(s[j]==c) 
;      rip++;       
                                   dadd $t2, $a0, $s0
                                   lbu $t3, 0($t2)
                                   bne $t3, $s2, decr_if
                                   daddi $s1, $s1, 1

decr_if:                      daddi $s0, $s0, -1
                                    j forf

return_rip:                move r1, $s1
                                    ld $s0, 0($sp)  ; j
                                    ld $s1, 8($sp)  ; rip
                                    ld $s2, 16($sp) ; c
                                    daddi $sp, $sp, 24
                                    jr $ra


#include input_unsigned.s
