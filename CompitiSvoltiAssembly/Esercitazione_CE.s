; Esercitazione
; 
; int elabora(char a0, int a1)
; { int t = a0-48;
;   if(t < a1) return t;
;   else return a1;
; }
; 
; main() {
; char STRINGA[16];
; int A[16], i, n;
; printf("Inserire una stringa\n");
; scanf("%s", STRINGA);
; for(i = 0; i < strlen(STRINGA); i++)
; {
;   printf("Inserisci un numero (0 termina l'esecuzione)\n");
;   scanf("%d", &n);
;   if(n != 0)
;   {
;       A[i] = elabora(STRINGA[i], n);
;       printf("A[%d] = %d", i, A[i]);
;   }
;   else {
;   printf("Hai scelto di terminare l'esecuzione\n");
;    break;
;   }
; }

.data
STRINGA: .space 16
Aa: .space 128

m1: .asciiz "Inserire una stringa\n"
m2: .asciiz "Inserisci un numero (0 termina l'esecuzione)\n"
m3: .asciiz "A[%d] = %d"
m4: .asciiz "Hai scelto di terminare l'esecuzione\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
; char STRINGA[16];
; int A[16], i, n;
; printf("Inserire una stringa\n");
daddi $t0, $0, m1
sd $t0, p1s5($0)
daddi r14, $0, p1s5
syscall 5

; scanf("%s", STRINGA);
daddi $t0, $0, STRINGA
sd $t0, ind($0)
daddi r14, $0, p1s3
syscall 3

move $s0, r1 ; $s0 = strlen(STRINGA);
daddi $s1, $0, 0 ; $s1 mi serve per la Stringa ed aumenta di 1
daddi $s2, $0, 0 ; $s2 mi serve per A[i] ed aumenta di 8
; for(i = 0; i < strlen(STRINGA); i++)
for: slt $t1, $s1, $s0 
       beq $t1, $0, fine_exe
;   printf("Inserisci un numero (0 termina l'esecuzione)\n");
       daddi $t1, $0, m2
       sd $t1, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;   scanf("%d", &n);
      jal input_unsigned
      move $a1, r1 ; $a1 = n
;   if(n != 0)
      beq $a1, $0, else
;       A[i] = elabora(STRINGA[i], n);
      dadd $t1, $s1, $t0
      lbu $a0, 0($t1) ; $a0 = STRINGA[i]
      jal elabora
      sd r1, Aa($s2) 
;       printf("A[%d] = %d", i, A[i]);
      sd $s1, p2s5($0)
      sd r1, p3s5($0)
      daddi $t1, $0, m3
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
      j incr_i

;   printf("Hai scelto di terminare l'esecuzione\n");
;    break;
else:  daddi $t1, $0, m4
           sd $t1, p1s5($0)
           daddi r14, $0, p1s5
           syscall 5
           j fine_exe
      
incr_i:      daddi $s1, $s1, 1  ; i++ per STRINGA
                 daddi $s2, $s2, 8  ; i++ per A
                 j for

fine_exe: syscall 0

; int elabora(char a0, int a1)
; $a0 = a0, $a1 = a1
; { int t = a0-48;
;   if(t < a1) return t;
;   else return a1;
; }
elabora: daddi $sp, $sp, -8
                 sd $s0, 0($sp) ; t
                 daddi $s0, $a0, -48 ; t = a0-48
                 slt $t0, $s0, $a1
                 beq $t0, $0, else_funzione
                 move r1, $s0
                 ld $s0, 0($sp)
                 daddi $sp, $sp, 8
                 jr $ra

else_funzione: move r1, $a1
                            ld $s0, 0($sp)
                            daddi $sp, $sp, 8
                            jr $ra

#include input_unsigned.s
