;main() { 
;  char ST[32]; 
;  int i, num, val;      
          
;     for(i=0; i<4;i++) 
;     { 
;        printf("Inserisci il numero di caratteri da inserire (<32)\n"); 
;        scanf("%d",&num); 
;   printf("Inserisci una stringa di %d numeri \n",num); 
;       scanf("%s",ST); 
;       if(num==strlen(ST)) 
;         { 
;        val= elabora(ST,num); 
;    printf("Il valore medio della stringa e' %d\n", val); 
;  } 
; } 
       
;} 
 
;int elabora(char *a0, int a1) 
;{int s0,numero, t; 
   
;  numero=0; 
;  s0=0;   
;  while(s0<a1) 
;    {  
; t=a0[s0]-48;    
; if(t<0|| t>=10) 
;   s0++; 
; else { 
;   numero += t; 
;   s0++; 
;  }   
;    } 
 
;  return numero/a1;   
;}

.data
ST: .space 32

m1: .asciiz "Inserisci il numero di caratteri da inserire (<32)\n"
m2: .asciiz "Inserisci una stringa di %d numeri \n"
m3: .asciiz "Il valore medio della stringa e' %d\n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 32

.code
;  char ST[32]; 
;  int i, num, val;      
daddi $s0, $0, 0          
;     for(i=0; i<4;i++) 
for: slti $t0, $s0, 4
        beq $t0, $0, fine_exe
;        printf("Inserisci il numero di caratteri da inserire (<32)\n"); 
        daddi $t1, $0, m1
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;        scanf("%d",&num); 
        jal input_unsigned
        move $a1, r1  ; $a1 = num
;   printf("Inserisci una stringa di %d numeri \n",num); 
        sd $a1, p2s5($0)
        daddi $t1, $0, m2
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5
;       scanf("%s",ST); 
        daddi $a0, $0, ST  ; $a0 = ST
        sd $a0, ind($0)
        daddi r14, $0, p1s3
        syscall 3
;       if(num==strlen(ST)) 
        bne r1, $a1, incrementa_i
        jal elabora
        sd r1, p2s5($0)
;    printf("Il valore medio della stringa e' %d\n", val);
        daddi $t1, $0, m3
        sd $t1, p1s5($0)
        daddi r14, $0, p1s5
        syscall 5

incrementa_i: daddi $s0, $s0, 1
                           j for

fine_exe: syscall 0

;int elabora(char *a0, int a1) 
; $a0 = a0, $a1 = a1
;{int s0,numero, t;    
;  numero=0; 
;  s0=0;   

elabora: daddi $sp, $sp, -24
                 sd $s0, 0($sp) ; s0
                 sd $s1, 8($sp) ; numero
                 sd $s2, 16($sp) ; t
                 daddi $s1, $0, 0
                 daddi $s0, $0, 0
;  while(s0<a1) 
while:      slt $t0, $s0, $a1
                  beq $t0, $0, return_numero_a1
; t=a0[s0]-48;  
                  dadd $t1, $a0, $s0
                  lbu $s2, 0($t1)  ; $s2 = a0[s0] = t
                  daddi $s2, $s2, -48 ; $s2 = a0[s0] - 48
; if(t<0|| t>=10) 
; s0++;
if_1:          slti $t2, $s2, 0
                  bne $t2, $0, incrementa_s0
                  slti $t2, $s2, 10
                  beq $t2, $0, incrementa_s0
; else { 
;   numero += t; 
;   s0++; 
;  }   
else:         dadd $s1, $s1, $s2
                  daddi $s0, $s0, 1 
                  j while 

incrementa_s0: daddi $s0, $s0, 1
                              j while

return_numero_a1: ddiv $s1, $a1
                                      mflo r1
                                      ld $s0, 0($sp)
                                      ld $s1, 8($sp)
                                      ld $s2, 16($sp)
                                      daddi $sp, $sp, 24 
                                      jr $ra

 
#include input_unsigned.s
