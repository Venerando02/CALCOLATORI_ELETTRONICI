; int calcola(char *a0, char *a1, int a2) 
;{int i,c; 
 
;  c=0;   
;  for(i=0;i<a2;i++)  
;   {  
;     if(a1[i] < 58)  
;         c=c+a1[i]-48; 
;     else c=c+a0[i]-48;   
;   }  
 
;return c; 
;} 
 
;main() { 
;  char STA[24],STB[24]; 
;  char *a0,*a1; 
;  int i, a2, val;      
     
;     for(i=0; i<4;i++) 
;     { 
;  printf("Inserisci la prima stringa di soli numeri\n"); 
;      scanf("%s",STA);  
;      a2=strlen(STA); 
;      do{ 
;    printf("Inserisci la seconda stringa con almeno %d caratteri\n", a2); 
;         scanf("%s",STB); 
;      }while(strlen(STB)<strlen(STA)); 
       
;      a0=STA; 
; a1=STB;   
;      val= calcola(a0,a1,a2); 
; if(val>0)      
;    printf("%d:  Risultato = %d\n", i, val); 
;     }        
;} 

.data
STA: .space 24
STB: .space 24

m1: .asciiz "Inserisci la prima stringa di soli numeri\n"
m2: .asciiz "Inserisci la seconda stringa con almeno %d caratteri\n"
m3: .asciiz "%d:  Risultato = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 24

.code
;  char STA[24],STB[24]; 
;  char *a0,*a1; 
;  int i, a2, val;      
daddi $s0, $0, 0     
;     for(i=0; i<4;i++) 
for: slti $t0, $s0, 4
       beq $t0, $0, fine_exe
;  printf("Inserisci la prima stringa di soli numeri\n"); 
       daddi $t1, $0, m1
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;      scanf("%s",STA);  
;      a2=strlen(STA); 
       daddi $a0, $0, STA
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $a2, r1
;      do{ 
;    printf("Inserisci la seconda stringa con almeno %d caratteri\n", a2); 
;         scanf("%s",STB); 
;      }while(strlen(STB)<strlen(STA)); 
do:  sd $a2, p2s5($0)
        daddi $t1, $0, m2
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
        daddi $a1, $0, STB
        sd $a1, ind($0)
        daddi r14, $0, p1s3
        syscall 3
        move $s1, r1

do_while_condition: slt $t0, $s1, $a2
                                       bne $t0, $0, do
         
        jal calcola
        slt $t1, $0, r1
        beq $t1, $0,  incrementa_i
       
        sd $s0, p2s5($0)
        sd r1, p3s5($0)
        daddi $t1, $0, m3
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
        
incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0

; int calcola(char *a0, char *a1, int a2) 
;{int i,c;  
;  c=0;   
;  for(i=0;i<a2;i++)  
;   {  
;     if(a1[i] < 58)  
;         c=c+a1[i]-48; 
;     else c=c+a0[i]-48;   
;   }  
 
;return c; 
;} 

calcola: daddi $sp, $sp, -16
               sd $s0, 0($sp)  ; i
               sd $s1, 8($sp)  ; c
               daddi $s0, $0, 0
               daddi $s1, $0, 0

forf:       slt $t0, $s0, $a2
               beq $t0, $0, return_c
;     if(a1[i] < 58)  
;         c=c+a1[i]-48; 
;     else c=c+a0[i]-48;   
               dadd $t1, $a1, $s0
               lbu $t2, 0($t1)
               slti $t3, $t2, 58
               beq $t3, $0, elsef
               daddi $t4, $t2, -48
               dadd $s1, $s1, $t4

elsef:     dadd $t5, $a0, $s0
               lbu $t6, 0($t5)
               daddi $t6, $t6, -48
               dadd $s1, $s1, $t6

incrementa_if: daddi $s0, $s0, 1
                            j forf

return_c: move r1, $s1
                  ld $s0, 0($sp)  ; i
                  ld $s1, 8($sp)  ; c
                  daddi $sp, $s0, 16
                  jr $ra
