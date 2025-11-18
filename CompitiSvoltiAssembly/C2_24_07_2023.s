 ;main() { 
;  char NUMERI[8]; 
;  int i,valore;      
;  int a0,a1,num;  
   
 
; for(i=0;i<3;i++) 
;  {  
; do{ 
;  printf("%d ) Inserisci una stringa di soli 2 numeri crescenti\n",i); 
;  scanf("%s",NUMERI); 
;  }while (strlen(NUMERI)!=2); 
   
;    printf("Inserisci un numero >0\n",num); 
;    scanf("%d",&num); 
;    a0=NUMERI[0]-48; 
; a1=NUMERI[1]-48; 
;    valore=  calcola(a0,a1,num); 
;  printf("Il risultato e' %d\n",valore); 
  
;  }  
;}

.data
NUMERI: .space 8

m1: .asciiz "%d ) Inserisci una stringa di soli 2 numeri crescenti\n"
m2: .asciiz "Inserisci un numero >0\n"
m3: .asciiz "Il risultato e' %d\n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 8

.code
;  char NUMERI[8]; 
;  int i,valore;      
;  int a0,a1,num;  
daddi $s0, $0, 0 
; for(i=0;i<3;i++) 
for: slti $t0, $s0, 3
       beq $t0, $0, fine_exe
; do{ 
;  printf("%d ) Inserisci una stringa di soli 2 numeri crescenti\n",i); 
do: sd $s0, p2s5($0)
       daddi $t0, $0, m1
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;  scanf("%s",NUMERI); 
       daddi $t1, $0, NUMERI
       sd $t1, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $s1, r1
       daddi $s2, $0, 2
;  }while (strlen(NUMERI)!=2); 
do_while_condition: bne $s1, $s2, do

;    printf("Inserisci un numero >0\n",num); 
     daddi $t0, $0, m2
     sd $t0, p1s5($0)
     daddi r14, $0, p1s5
     syscall 5
;    scanf("%d",&num); 
    jal input_unsigned
    move $a2, r1
;    a0=NUMERI[0]-48;
   daddi $t2, $t1, 0
   lbu $t3, 0($t2)  ; $t3 = NUMERI[0]
   daddi $a0, $t3, -48 ; $a0 = NUMERI[0] - 48
; a1=NUMERI[1]-48;
   lbu $t4, 1($t2)   ; $t4 = NUMERI[1]
   daddi $a1, $t4, -48 ; $a1 = NUMERI[1] - 48
;    valore=  calcola(a0,a1,num); 
;  printf("Il risultato e' %d\n",valore); 
   jal calcola
   sd r1, p2s5($0)
   daddi $t0, $0, m3
   sd $t0, p1s5($0)
   daddi r14, $0, p1s5
   syscall 5

incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0


;int calcola(int a0, int a1, int a2) 
;{ int i,s,t;  
;   t=a1; 
;   s=1; 
;   for(i=0;i<a0;i++) 
;    {s=s*t; 
; t=t-1; 
;    } 
;   s=s/a2;                   
;   return s; 
;} 
calcola: daddi $sp, $sp, -24
               sd $s0, 0($sp) ; i
               sd $s1, 8($sp) ; s
               sd $s2, 16($sp) ; t
               daddi $s0, $0, 0 ; i = 0
               daddi $s1, $0, 1 ; s = 1
               dadd $s2, $0, $a1 ; t = a1

forf:       slt $t0, $s0, $a0
               beq $t0, $0, return_s
               dmult $s1, $s2
               mflo $s1
               daddi $s2, $s2, -1 
              
incr_if: daddi $s0, $s0, 1
              j forf

return_s: ddiv $s1, $a2
                  mflo r1
                  ld $s0, 0($sp) ; i
                  ld $s1, 8($sp) ; s
                  ld $s2, 16($sp) ; t
                  daddi $sp, $sp, 24
                  jr $ra

#include input_unsigned.s
