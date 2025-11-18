 ;int massimo(char *str, int n) 
;{int i,max; 
;  int tc; 
   
;  max=0; 
;    for(i=0;i<n;i++)    
;    { tc= str[i]-65; 
;   // Verifichiamo se e' una lettera maiuscola  
;   // e se e' maggiore dei precedenti caratteri 
;  if(tc>=max && tc<26 ) 
;         max=tc;       
;    } 
;  return max;   
;}

;main() { 
;  char STRING[16]; 
;  int i, dim, len,max;      
         
;     for(i=0; i<3;i++) 
;     { 
;      printf("Dimensione della stringa \n"); 
;      scanf("%d",&dim); 
;   do{ 
;      printf("Inserisci una stringa di %d caratteri \n",dim); 
;          scanf("%s",STRING); 
;     } while (strlen(STRING)<dim); 
      
;   max= massimo(STRING,dim); 
;   printf("Il valore del massimo carattere e' %d\n",max); 
            
;  }       
;}

.data
STRING: .space 16

m1: .asciiz "Dimensione della stringa \n"
m2: .asciiz "Inserisci una stringa di %d caratteri \n"
m3: .asciiz "Il valore del massimo carattere e' %d\n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;  char STRING[16]; 
;  int i, dim, len,max;      
daddi $s0, $0, 0          
;     for(i=0; i<3;i++) 
for: slti $t0, $s0, 3
       beq $t0, $0, fine_exe
;      printf("Dimensione della stringa \n"); 
       daddi $t0, $0, m1
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;      scanf("%d",&dim); 
       jal input_unsigned
       move $a1, r1
;   do{ 
;      printf("Inserisci una stringa di %d caratteri \n",dim); 
do: sd $a1, p2s5($0) 
       daddi $t0, $0, m2
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;     scanf("%s",STRING);
       daddi $a0, $0, STRING
       sd $a0, ind($0)
       daddi r14, $0, p1s3
       syscall 3 
       move $s1, r1
;     } while (strlen(STRING)<dim); 
do_while_condition: slt $t0, $s1, $a1
                                       bne $t0, $0, do
;   max= massimo(STRING,dim); 
                                       jal massimo
 ;   printf("Il valore del massimo carattere e' %d\n",max);                                       
                                       sd r1, p2s5($0)
                                       daddi $t0, $0, m3
                                       sd $t0, p1s5($0)
                                       daddi r14, $0, p1s5
                                       syscall 5

incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0

 ;int massimo(char *str, int n) 
; $a0 = str, $a1 = n
;{int i,max; 
;  int tc; 
;  max=0; 
massimo: daddi $sp, $sp, -24
                    sd $s0, 0($sp)  ; i
                    sd $s1, 8($sp)  ; max
                    sd $s2, 16($sp) ; tc
                    daddi $s0, $0, 0 ; i = 0
                    daddi $s1, $0, 0  ; max = 0
;    for(i=0;i<n;i++)    
;    { tc= str[i]-65; 
forf:            slt $t0, $s0, $a1
                    beq $t0, $0, return_max
                    
                    dadd $t1, $a0, $s0  ; $t1 = $a0 + $s0 = &str + i
                    lbu $s2, 0($t1)  ; $s2 = str[i] = tc
                    daddi $s2, $s2, -65 ; $s2 = $s2 - 65 = str[i] - 65
;  if(tc>=max && tc<26 ) 
;         max=tc;       
                    slt $t2, $s2, $s1
                    bne $t2, $0, incr_if
                    slti $t2, $s2, 26                    
                    beq $t2, $0, incr_if
                    dadd $s1, $0, $s2 ; $s1 = 0 + $s2 = 0 + tc = max 


incr_if:       daddi $s0, $s0, 1
                    j forf

return_max:  move r1, $s1
                         ld $s0, 0($sp)
                         ld $s1, 8($sp)
                         ld $s2, 16($sp)
                         daddi $sp, $sp, 24
                         jr r31


#include input_unsigned.s
