;main() { 
;  char STRINGA[16]; 
;  int i, len,ris;      
     
      
;     for(i=0; i<3;) 
;     { 
;   printf("Inserisci una Password con almeno 8 caratteri contenente \n"); 
;   printf("almeno un numero e un carattere tra # e $  \n"); 
;        scanf("%s",STRINGA); 
;        len=strlen(STRINGA); 
;        if(len>=8) 
;   { 
;     ris= controlla(STRINGA,len); 
;     if(ris<2) 
;   printf("Password %d-esima non corretta\n",i); 
;     else i++;  
;   } 
;     } 
;}

.data
STRINGA: .space 16

m1: .asciiz "Inserisci una Password con almeno 8 caratteri contenente \n"
m2: .asciiz "almeno un numero e un carattere tra # e $  \n"
m3: .asciiz "Password %d-esima non corretta\n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code
;  char STRINGA[16]; 
;  int i, len,ris;      
daddi $s0, $0, 0           
;     for(i=0; i<3;) 
for: slti $t0, $s0, 3
       beq $t0, $0, fine_exe
;   printf("Inserisci una Password con almeno 8 caratteri contenente \n"); 
;   printf("almeno un numero e un carattere tra # e $  \n"); 
       daddi $t0, $0, m1
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
       daddi $t0, $0, m2
       sd $t0, p1s5($0)
       daddi r14, $0, p1s5
       syscall 5
;        scanf("%s",STRINGA); 
;        len=strlen(STRINGA); 
      daddi $a0, $0, STRINGA
      sd $a0, ind($0)
      daddi r14, $0, p1s3
      syscall 3
      move $a1, r1
;        if(len>=8) 
      slti $t0, $a1, 8
      bne $t0, $0, incrementa_i
;     ris= controlla(STRINGA,len); 
      jal controlla
;     if(ris<2) 
      slti $t0, r1, 2
      beq $t0, $0, incrementa_i
;   printf("Password %d-esima non corretta\n",i); 
      sd $s0, p2s5($0)
      daddi $t0, $0, m3
      sd $t0, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5

incrementa_i: daddi $s0, $s0, 1
                          j for

fine_exe: syscall 0


;int controlla(char *st, int d) 
; $a0 = st, $a1 = d
;{int i,speciale,numero; 
;  speciale=0; 
;  numero=0;      
;  for(i=0;i<d;i++) 
;    {  if(st[i]==35 || st[i]==36) 
;        speciale=1; 
;   else 
;       if(st[i]>47 && st[i]<=57)   
;         numero=1; 
; } 
 
;  return numero+speciale;   
;}  

controlla: daddi $sp, $sp, -24
                  sd $s0, 0($sp)  ; i
                  sd $s1, 8($sp)  ; speciale
                  sd $s2, 16($sp)  ; numero
                  daddi $s0, $0, 0
                  daddi $s1, $0, 0
                  daddi $s2, $0, 0

forf:          slt $t0, $s0, $a1
                  beq $t0, $0, return_numero_speciale
;    {  if(st[i]==35 || st[i]==36) 
                  dadd $t1, $a0, $s0
                  lbu $t2, 0($t1)
                  daddi $s3, $0, 35
                  daddi $s4, $0, 36
                  beq $t2, $s3, imp_speciale
                  beq $t2, $s4, imp_speciale
                  j if_2
;        speciale=1; 
imp_speciale: daddi $s1, $0, 1                           
;       if(st[i]>47 && st[i]<=57)   
;         numero=1; 
if_2: daddi $s5, $0, 47
         daddi $s6, $0, 57
         slt $t3, $s5, $t2
         beq $t3, $0, incr_if
         slt $t3, $s6, $t2
         bne $t3, $0, incr_if
         daddi $s2, $0, 1

incr_if:     daddi $s0, $s0, 1
                  j forf

return_numero_speciale: dadd r1, $s1, $s2
                                                ld $s0, 0($sp) 
                                                ld $s1, 8($sp)  
                                                ld $s2, 16($sp) 
                                                daddi $sp, $sp, 24
                                                jr $ra
