; COMPITO T2C1 13_01_2020
;  int processa(char * str, int d) {
; if(str[d] - 48 < d) return d;
; else return str[d] - 48;
; }
;
; main() {
; char STR[16];
; int num, ris;
; printf("Inserire una stringa ");
; scanf("%s", STR);
; do {
; printf("Inserisci un numero minore di %d\n", strlen(STR));
; scanf("%d", $num);
; if(num >= strlen(STR)) printf("Numero troppo grande\n");
; } while(num >= strlen(STR));  
; ris = processa(STR, num);
; printf("ris = %d\n", ris);
; }

.data
STR: .space 16

mes1: .asciiz "Inserire una stringa "
mes2: .asciiz "Inserisci un numero minore di %d\n"
mes3: .asciiz "Numero troppo grande\n"
mes4: .asciiz "ris = %d\n"

p1sys5: .space 8
val: .space 8 ; corrisponde al valore di r1 nel caso di mes2 e ris nel caso di mes4

p1sys3: .word 0
indsys3: .space 8
dim3: .word 16 

.code 
; printf("Inserire una stringa ");
daddi $t0, $0, mes1
sd $t0, p1sys5($0)
daddi r14, $0, p1sys5
syscall 5
; scanf("%s", STR);
daddi $t0, $0, STR
sd $t0, indsys3($0)
daddi r14, $0, p1sys3
syscall 3
move $s0, r1 ; $s0 = strlen(STR);
; do {
; printf("Inserisci un numero minore di %d\n", strlen(STR));
do: sd $s0, val($0)
       daddi $t0, $0, mes2 
       sd $t0, p1sys5($0)
       daddi r14, $0, p1sys5
       syscall 5
; scanf("%d", $num);
       jal input_unsigned
       move $s1, r1 ; $s1 = num;
; if(num >= strlen(STR)) 
; printf("Numero troppo grande\n");
; } while(num >= strlen(STR));  
; verifichiamo se num è minore di strlen(STR), se la condizione è vera saltiamo a processa
; altrimenti stampiamo il messaggio e saltiamo a do
       slt $t0, $s1, $s0
       bne $t0, $0, esegui_proc
       
; condizione falsa
; printf("Numero troppo grande\n");
       daddi $t0, $0, mes3
       sd $t0, p1sys5($0)
       daddi r14, $0, p1sys5
       syscall 5
       j do
esegui_proc: daddi $a0, $0, STR
                        move $a1, $s1
                        jal processa

                        sd r1, val($0)
                        daddi $t0, $0, mes4
                        sd $t0, p1sys5($0)
                        daddi r14, $0, p1sys5
                        syscall 5
                        syscall 0
; $a0 = str, $a1 = d

processa: dadd $t0, $a0, $a1 ; $t0 = &str[d]
                  lbu $t1, 0($t0)         ; $t1 = str[d]
                  daddi $t1, $t1, -48
                  slt $t2, $t1, $a1  ; $t2 = 1 se str[d] - 48 < d
                  beq $t2, $0, return_falso
                  move r1, $a1 ; r1 = d
                  jr $ra

return_falso: move r1, $t1 ; r1 = str[d] - 48
                       jr $ra

                  
#include input_unsigned.s
