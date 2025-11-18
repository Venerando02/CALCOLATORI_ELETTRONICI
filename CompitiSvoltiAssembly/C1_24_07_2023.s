;main() { 
;  char NUMERI[32]; 
;  int i,valore;      
;  int elem,num,dim;  
   
;  do{ 
;  printf("Inserisci una stringa di soli numeri con almeno numero 2 caratteri\n"); 
;  scanf("%s",NUMERI); 
;  dim=strlen(NUMERI); 
;  }while (dim<2); 
   
; for(i=0;i<dim;) 
;  { elem=NUMERI[i]-48;  
;    printf("%d) Inserisci un numero minore di %d\n",i,elem); 
;    scanf("%d",&num); 
;    if(num<elem) 
;   { 
;   valore=  calcola(elem,num); 
;   printf("Il risultato e’ %d\n",valore); 
;   i++;   
;    } 
;  }  
;}

.data
NUMERI: .space 32

m1: .asciiz "Inserisci una stringa di soli numeri con almeno numero 2 caratteri\n"
m2: .asciiz "%d) Inserisci un numero minore di %d\n"
m3: .asciiz "Il risultato e’ %d\n"

p1s5: .space 8
p2s5: .space 8
p3s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 32

.code
 ;  char NUMERI[32]; 
;  int i,valore;      
;  int elem,num,dim;  
daddi $s0, $0, 0 ; i = 0
;  do{ 
;  printf("Inserisci una stringa di soli numeri con almeno numero 2 caratteri\n"); 
;  scanf("%s",NUMERI); 
;  dim=strlen(NUMERI); 
;  }while (dim<2); 
do: daddi $t0, $0, m1
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5

       daddi $t1, $0, NUMERI  ; $t1 = NUMERI
       sd $t1, ind($0)
       daddi r14, $0, p1s3
       syscall 3
       move $s1, r1

do_while_condition: slti $t0, $s1, 2
                                       bne $t0, $0, do

for: slt $t0, $s0, $s1  ; i < dim
       beq $t0, $0, fine_exe
;  { elem=NUMERI[i]-48;  
;    printf("%d) Inserisci un numero minore di %d\n",i,elem); 
      dadd $t2, $t1, $s0
      lbu $t3, 0($t2)  ; $t3 = NUMERI[i]
      daddi $a0, $t3, -48 ; $a0 = $t3 - 48 = NUMERI[i] - 48 = elem
;  { elem=NUMERI[i]-48; 
;    printf("%d) Inserisci un numero minore di %d\n",i,elem);
      sd $s0, p2s5($0)
      sd $a0, p3s5($0)
      daddi $t0, $0, m2
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;    scanf("%d",&num); 
      jal input_unsigned
      move $a1, r1
;    if(num<elem) 
      slt $t0, $a1, $a0
      beq $t0, $0, for
;   valore=  calcola(elem,num);
      jal calcola      
;   printf("Il risultato e’ %d\n",valore); 
      sd r1, p2s5($0)
      daddi $t0, $0, m3
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;   i++;   
incrementa_i:  daddi $s0, $s0, 1
                            j for
       
fine_exe: syscall 0

;int calcola(int a0, int a1) 
;{ int i,s,t; 
 
;   t=a0; 
;   s=0; 
;   for(i=0;i<a1;i++) 
;    {s=s+t; 
; t=t-1; 
;    } 
                  
;   return s; 
;}
calcola: daddi $sp, $sp, -24
               sd $s0, 0($sp)  ; i
               sd $s1, 8($sp)   ; s
               sd $s2, 16($sp)  ; t
               daddi $s0, $0, 0 ; i = 0
               dadd $s2, $0, $a0 ; t = a0
               daddi $s1, $0, 0 ; s = 0

forf:       slt $t0, $s0, $a1
               beq $t0, $0, return_s
               dadd $s1, $s1, $s2  ; $s1 = $s1 + $s2 = s + t = s;
               daddi $s2, $s2, -1  ; $s2 = $s2 -1 = t = t-1;

incr_if:  daddi $s0, $s0, 1
                j forf

return_s: move r1, $s1
                  ld $s0, 0($sp)  ; i
                  ld $s1, 8($sp)   ; s
                  ld $s2, 16($sp)  ; t
                  daddi $sp, $sp, 24
                  jr $ra

#include input_unsigned.s
