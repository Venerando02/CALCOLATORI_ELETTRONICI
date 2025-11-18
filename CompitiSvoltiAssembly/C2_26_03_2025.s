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
            daddi $t1, $0, m1
            sd $t1, p1s5($0)
            daddi r14, $0, p1s5
            syscall 5
;      scanf("%s",ST1);  
            daddi $a0, $0, ST1
            sd $a0, ind($0)
            daddi r14, $0, p1s3
            syscall 3
            move $a2, r1
;      do{     
;   printf("Inserisci una stringa di uguale lunghezza\n"); 
;      scanf("%s",ST2); 
do:      daddi $t1, $0, m2
            sd $t1, p1s5($0)
            daddi r14, $0, p1s5
            syscall 5

            daddi $a1, $0, ST2
            sd $a1, ind($0)
            daddi r14, $0, p1s3
            syscall 3
            move $s1, r1
;      } while (strlen(ST1)!=strlen(ST2)); 
do_while_condition: bne $a2, $s1, do
            
            jal processa
;   printf("Ciclo %d ->  Ris = %d\n", i, ris); 
            sd $s0, p2s5($0)
            sd r1, p3s5($0)
            daddi $t1, $0, m3
            sd $t1, p1s5($0)
            daddi r14, $0, p1s5
            syscall 5
;   i++;
incrementa_i: daddi $s0, $s0, 1
                           j while

fine_exe: syscall 0


;int processa(char *st0, char *st1, int n) 
; $a0 = st0, $a1 = st1, $a2 = n
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
processa: daddi $sp, $sp, -16
                    sd $s0, 0($sp) ; i
                    sd $s1, 8($sp) ; c
                    daddi $s0, $0, 0
                    daddi $s1, $0, 0

forf:  slt $t0, $s0, $a2
          beq $t0, $0, return_c
          dadd $t1, $a0, $s0
          lbu $t2, 0($t1)
          dadd $t3, $a1, $s0
          lbu $t4, 0($t4)
          slt $t5, $t2, $t4
          beq $t5, $0, else_if_funzione  
          daddi $s1, $s1, -1 ; c--
          j incr_funzione

else_if_funzione: slt $t5, $t4, $t2
                                 beq $t5, $0, incr_funzione
                                 daddi $s1, $s1, 1

incr_funzione: daddi $s0, $s0, 1
                            j forf

return_c: move r1, $s1
                  ld $s0, 0($sp)
                  ld $s1, 8($sp)
                  daddi $sp, $sp, 16
                  jr $ra
