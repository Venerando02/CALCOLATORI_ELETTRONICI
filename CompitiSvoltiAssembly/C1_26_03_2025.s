;int processa(char *st0, char *st1, int n) 
;{int i,c; 
;  c=0;   
;  for(i=0;i<n;i++)  
;   {  
;     if(st0[i]<st1[i])  
;    c--; 
;     else if (st1[i]<st0[i]) 
;      c++;   
;   }  
;return c; 
;}
;main() { 
;  char *a0, *a1, ST1[16],ST2[16]; 
;  int i, a2, ris;      
     
;     i=0;  
;  while(i<3) 
;     {       
;   printf("Inserisci la prima stringa \n"); 
;      scanf("%s",ST1);        
;      do{ 
;   printf("Inserisci una stringa di uguale lunghezza\n"); 
;      scanf("%s",ST2); 
;      } while (strlen(ST1)!=strlen(ST2));         
;   a0=ST1; 
;   a1=ST2; 
;   a2=strlen(ST1); 
;   ris= processa(a0,a1,a2); 
;   printf("Ciclo %d ->  Ris = %d\n", i, ris); 
;   i++;  
;   }       
;} 

.data
ST1: .space 16
ST2: .space 16

m1: .asciiz "Inserisci la prima stringa \n"
m2: .asciiz "Inserisci una stringa di uguale lunghezza\n"
m3: .asciiz "Ciclo %d ->  Ris = %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;  char *a0, *a1, ST1[16],ST2[16]; 
;  int i, a2, ris;           
;     i=0;  
daddi $s0, $0, 0
;  while(i<3) 
while: slti $t0, $s0, 3
            beq $t0, $0, fine_exe
;   printf("Inserisci la prima stringa \n"); 
            daddi $t0, $0, m1
            sd $t0, p1s5($0)
            daddi r14, $0, p1s5
            syscall 5
;      scanf("%s",ST1);        
            daddi $a0, $0, ST1
            sd $a0, ind($0)
            daddi r14, $0, p1s3
            syscall 3
            move $a2, r1  ; $a2 = strlen(ST1);
;      do{ 
;   printf("Inserisci una stringa di uguale lunghezza\n"); 
do:      daddi $t0, $0, m2
            sd $t0, p1s5($0)
            daddi r14, $0, p1s5
            syscall 5 
;      scanf("%s",ST2); 
            daddi $a1, $0, ST2
            sd $a0, ind($0)
            daddi r14, $0, p1s3
            syscall 3
            move $s1, r1  ; $s2 = strlen(ST2)
do_while_condition: bne $a2, $s1, do
;   ris= processa(a0,a1,a2);
            jal processa
;   printf("Ciclo %d ->  Ris = %d\n", i, ris); 
            sd $s0, p2s5($0)
            sd r1, p3s5($0) 
             daddi $t0, $0, m3
            sd $t0, p1s5($0)
            daddi r14, $0, p1s5
            syscall 5      
;   i++;  
           daddi $s0, $s0, 1
           j while

fine_exe: syscall 0

;int processa(char *st0, char *st1, int n) 
; $a0 = st0, $a1 = st1, $a2 = n
;{int i,c; 
;  c=0;   
processa: daddi $sp, $sp, -16
                    sd $s0, 0($sp) ; i 
                    sd $s1, 8($sp) ; c
                    daddi $s0, $0, 0  ; i = 0
                    daddi $s1, $0, 0  ; c = 0
;  for(i=0;i<n;i++)  
for_funzione: slt $t0, $s0, $a2
                          beq $t0, $0, return_c
;     if(st0[i]<st1[i])  
;     c--;
                          dadd $t0, $s0, $a0
                          lbu $t1, 0($t0)  ; $t1 = st0[i]
                          dadd $t2, $s0, $a1
                          lbu $t3, 0($t2)  ; $t3 = st1[i]
                          slt $t4, $t1, $t3
                          beq $t4, $0, else_if
                          daddi $s1, $s1, -1
;     else if (st1[i]<st0[i]) 
;      c++;  
else_if:             slt $t4, $t3, $t1
                           beq $t4, $0,  incr_i_f
                           daddi $s1, $s1, 1

incr_i_f:           daddi $s0, $s0, 1
                          j for_funzione

return_c:   move r1, $s1
                    ld $s0, 0($sp) ; i 
                    ld $s1, 8($sp) 
                    daddi $sp, $sp, 16
                    jr $ra
