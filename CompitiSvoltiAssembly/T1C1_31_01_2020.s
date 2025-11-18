; COMPITO T2C2 13_01_2020
; int proc(char * s, int l, int num)
; { int i, somma;
;   somma = 0;
;  for(i = 0; i<l; i++)
;  if(s[i] - 48 < num)
;  somma = somma + s[i] - 48;
;  return somma;
; }
;
; main() {
; char STRING[3][32];
; int N, i, num;
; for(i = 0; i<3; i++)
; { printf("Inserire una stringa con almeno 2 caratteri");
;  scanf("%s", STRING[i]);
;  printf("Inserisci un numero\n");
;  scanf("%d", &num);
; N = proc(STRING[i], strlen(STRING[i], num);
; printf("N = %d\n", N);
; }
; }

.data
STR: .space 96
stack: .space 32

p5: .space 8
N: .space 8

m1: .asciiz "Inserire una stringa con almeno 2 caratteri"
m2: .asciiz "Inserisci un numero\n"
m3: .asciiz "N = %d\n"

p3: .word 0
ind: .space 8
dim: .word 32

.code 
daddi $sp, $0, stack
daddi $sp, $sp, 32
daddi $s0, $0, 0 ; i = 0 il registro $s0 deve essere multiplo di 32
for: slti $t0, $s0, 96
       beq $t0, $0, fine_esecuzione  
; { printf("Inserire una stringa con almeno 2 caratteri");      
       daddi $t0, $0, m1
       sd $t0, p5($0)
       daddi r14, $0, p5
       syscall 5
;  scanf("%s", STRING[i]); STRING[i] è l'indirizzo della stringa i-esima , STRING[i] = STRING + i*32 = STRING + $s0
       daddi $a0, $s0, STR ; a0 = STRING[i];
       sd $a0, ind($0)
       daddi r14, $0, p3
       syscall 3
       move $a1, r1  ; a1 = strlen(STR[i])
;  printf("Inserisci un numero\n");       
       daddi $t0, $0, m2
       sd $t0, p5($0)
       daddi r14, $0, p5
       syscall 5
;  scanf("%d", &num);
       jal input_unsigned
       move $a2, r1 ; $a2 = num
       jal proc 
; printf("N = %d\n", N);
       sd r1, N($0)
       daddi $t0, $0, m3
       sd $t0, p5($0)
       daddi r14, $0, p5
       syscall 5
; i++
       daddi $s0, $s0, 32
       j for

; int proc(char * s, int l, int num)
; $a0 = s, $a1 = l, $a2 = num
; { int i, somma;
;  somma = 0;
;  for(i = 0; i<l; i++)
;  if(s[i] - 48 < num)
;  somma = somma + s[i] - 48;
;  return somma;
; }
proc: daddi $sp, $sp, -16
           sd $s0, 0($sp) ; somma
           sd $s1, 8($sp) ; i
           daddi $s0, $s0, 0 ; somma = 0
           daddi $s1, $s1, 0 ; i = 0
 for2:  slt $t0, $s1, $a1    
           beq $t0, $0, return
;  if(s[i] - 48 < num)
             ; &s[i] = s + i = $a0 + $s1
            dadd $t0, $a0, $s1 ; t0 è l'indirizzo di s[i]
            lbu $t1, 0($t0)  ; $t1 = s[i]
            daddi $t1, $t1, -48
            slt $t2, $t1, $a2
            beq $t2, $0, incr_i
            
;  somma = somma + s[i] - 48;
            dadd $s0, $s0, $t1            

incr_i:  daddi $s1, $s1, 1
             j for2

return: move r1, $s0
             ld $s0, 0($sp) ; somma
             ld $s1, 8($sp) ; i
            daddi $sp, $sp, 16
             jr $ra

fine_esecuzione: syscall 0

#include input_unsigned.s
