;int confronta(char num, int val) 
;{ int tmp;  
;   if(num<58) 
;      tmp= (num-48+ val)/2; 
;   else tmp = val; 
;  return tmp; 
;} 
 
;main() { 
;  char NUM[8]; 
;  int V[8],i,a;      
;    printf("Inserisci una stringa di soli numeri\n"); 
;    scanf("%s",NUM); 
;    for(i=0;i<strlen(NUM);i++) { 
;     printf("Inserisci un numero\n"); 
;     scanf("%d",&a); 
;    V[i]= confronta(NUM[i],a);        
;     printf(" Valore= %d \n",V[i]);  
;    }   
;}

.data
stack: .space 16
NUM: .space 8
Vv: .space 64

m1: .asciiz "Inserisci una stringa di soli numeri\n"
m2: .asciiz "Inserisci un numero\n"
m3: .asciiz " Valore= %d \n"

p1s5: .space 8
ValV: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 8

.code
; inizializzazione stack
daddi $sp, $0, stack
daddi $sp, $sp, 16
;    printf("Inserisci una stringa di soli numeri\n"); 
daddi $t0, $0, m1
sd $t0, p1s5($0)
daddi r14, $0, p1s5
syscall 5
;    scanf("%s",NUM); 
daddi $t0, $0, NUM
sd $t0, ind($0)
daddi r14, $0, p1s3
syscall 3
move $s0, r1  ; $s0 = strlen(NUM)
daddi $s1, $0, 0  ; $s1 = i = 0
daddi $s2, $0, 0 ; $s2 = i = 0 multiplo di 8
;    for(i=0;i<strlen(NUM);i++) { 
for: slt $t0, $s1, $s0
       beq $t0, $0, fine_esecuzione
;     printf("Inserisci un numero\n"); 
       daddi $t0, $0, m2
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;     scanf("%d",&a); 
       jal input_unsigned
       move $a1, r1
;    V[i] = V + i = V + $s2
;    V[i]= confronta(NUM[i],a);        
      lbu $a0, NUM($s1)
      jal confronta
      sd r1, Vv($s2)
      ld $t1, Vv($s2)
      sd $t1, ValV($0)  
;     printf(" Valore= %d \n",V[i]);  
      daddi $t0, $0, m3
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5

      daddi $s1, $s1, 1
      daddi $s2, $s2, 8
     
      j for

fine_esecuzione: syscall 0

confronta: daddi $sp, $sp, -8
                   sd $s0, 0($sp) ; tmp
                   slti $t0, $a0, 58  ; if(num<58) 
                   beq $t0, $0, else
                   daddi $s1, $a0, -48 ; s1 = num - 48
                   dadd $s1, $s1, $a1 ; (num-48 + val); 
                   daddi $s2, $0, 2  ; $s2 = 2
                   ddiv $s1, $s2  ; (num - 48 + val)/2
                   mflo $s3 ; prendo il quoziente della divisione e lo metto su $s3
                   dadd $s0, $0, $s3 ; copio su tmp il valore di $s3, tmp = valore della divisione
                   move r1, $s0 
                   j reimpostazione_stack

else: move r1, $a1

reimpostazione_stack:      ld $s0, 0($sp)
                                             daddi $sp, $sp, 8
                                             jr r31

#include input_unsigned.s
