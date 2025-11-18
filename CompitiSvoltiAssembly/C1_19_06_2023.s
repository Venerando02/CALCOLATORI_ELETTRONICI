;main() { 
;  char STRINGA[8]; 
;  int i,valore;      
;  int num;  
   
; i=0; 
;  while(i<3) 
;  { 
;    printf("Inserisci il numero minimo caratteri da inserire\n"); 
;    scanf("%d",&num); 
;    printf("Inserisci una stringa con almeno %d caratteri\n",num);  
;    scanf("%s",STRINGA); 
      
;    if(strlen(STRINGA)<num) 
; {printf("Stringa di dimensione sbagliata. Fine esecuzione!\n"); 
;  i=3; 
;     } 
 
; else {valore= esegui(STRINGA,num);        
;        printf(" Risultato= %d \n",valore);  
;     i++;  
;     }    
;  } 
;}

.data
STRINGA: .space 8

m1: .asciiz "Inserisci il numero minimo caratteri da inserire\n"
m2: .asciiz "Inserisci una stringa con almeno %d caratteri\n"
m3: .asciiz "Stringa di dimensione sbagliata. Fine esecuzione!\n"
m4: .asciiz " Risultato= %d \n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 8 

.code
;  char STRINGA[8]; 
;  int i,valore;      
;  int num;     
; i=0; 
daddi $s0, $0, 0
;  while(i<3) 
while: slti $t0, $s0, 3
            beq $t0, $0, fine_exe
;    printf("Inserisci il numero minimo caratteri da inserire\n"); 
            daddi $t1, $0, m1
            sd $t1, p1s5($0)
            daddi r14, $0, p1s5
            syscall 5
;    scanf("%d",&num); 
            jal input_unsigned
            move $a1, r1
;    printf("Inserisci una stringa con almeno %d caratteri\n",num);  
            sd $a1, p2s5($0)
            daddi $t1, $0, m2
            sd $t1, p1s5($0)
            daddi r14, $0, p1s5
            syscall 5
;    scanf("%s",STRINGA); 
            daddi $a0, $0, STRINGA
            sd $a0, ind($0)
            daddi r14, $0, p1s3
            syscall 3
            move $s1, r1
;    if(strlen(STRINGA)<num) 
; {printf("Stringa di dimensione sbagliata. Fine esecuzione!\n"); 
;  i=3; 
;     } 
           slt $t1, $s1, $a1
           beq $t1, $0, else
           daddi $t1, $0, m3
           sd $t1, p1s5($0)
           daddi r14, $0, p1s5
           syscall 5
           daddi $s0, $0, 3
           j while

; else {valore= esegui(STRINGA,num);        
;        printf(" Risultato= %d \n",valore);  
;     i++;  
;     }    
else:  jal esegui
           sd r1, p2s5($0)
           daddi $t1, $0, m4
           sd $t1, p1s5($0)
           daddi r14, $0, p1s5
           syscall 5
           daddi $s0, $s0, 1
           j while

fine_exe: syscall 0


;int esegui(char *s, int n) 
;{ int i,t; 
 
;   t=0; 
;   for(i=0;i<n;i++) 
;    t=t+s[i]%4; 
                  
;   return t; 
;} 
 
esegui: daddi $sp, $sp, -16
               sd $s0, 0($sp)  ; i
               sd $s1, 8($sp)  ; t
               daddi $s0, $0, 0  ; i = 0
               daddi $s1, $0, 0  ; t = 0

forf:       slt $t0, $s0, $a1
               beq $t0, $0, return_t
               dadd $t1, $a0, $s0
               lbu $t2, 0($t1)
               daddi $s2, $0, 4
               ddiv $t2, $s2
               mfhi $t3
               dadd $s1, $s1, $t3

incr_if:  daddi $s0, $s0, 1
               j forf

return_t:  move r1, $s1
                  ld $s0, 0($sp)  ; i
                  ld $s1, 8($sp)  ; t
                  daddi $sp, $sp, 16
                  jr $ra

#include input_unsigned.s
