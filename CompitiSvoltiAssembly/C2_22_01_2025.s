;main() { 
;char minuscole[16], maiuscole[16];   
;int i, a2, r1;      
     
;for(i=0; i<4;i++) 
;  { 
;   printf("Ciclo %d: Inserisci una stringa di sole lettere minuscole\n",i); 
;   scanf("%s",minuscole);  
;   a2=strlen(minuscole); 
;   printf("Inserisci una stringa di sole lettere maiuscole\n"); 
;   scanf("%s",maiuscole); 
;   if(strlen(maiuscole)<a2) 
;        a2=strlen(maiuscole); 
             
;   r1= elabora(minuscole, maiuscole,a2);        
      
;   printf("Conta = %d\n", r1) ; 
  
;  }  
;} 
 
;int elabora(char *mi, char *ma, int a2) 
;{int j,s; 
 
;  s=0;   
   
;  for(j=0;j<a2;j++)  
;   {  
;    if(ma[j] < 65 || ma[j] >= 91) // lettera maiuscola? 
;  continue;  
; else 
;  if (ma[j]+ 32 == mi[j]) // lettera minuscola== lettera maiuscola ?  
;        s++; 
   
;   }  
 
;return s; 
;}

.data
minuscole: .space 16
maiuscole: .space 16

m1: .asciiz "Ciclo %d: Inserisci una stringa di sole lettere minuscole\n"
m2: .asciiz "Inserisci una stringa di sole lettere maiuscole\n"
m3: .asciiz "Conta = %d\n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code 
;char minuscole[16], maiuscole[16];   
;int i, a2, r1;      
daddi $s0, $0, 0
;for(i=0; i<4;i++) 
for: slti $t0, $s0, 4
       beq $t0, $0, fine_exe
;   printf("Ciclo %d: Inserisci una stringa di sole lettere minuscole\n",i); 
      sd $s0, p2s5($0)
      daddi $t1, $0, m1
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;   scanf("%s",minuscole);  
     daddi $a0, $0, minuscole
     sd $a0, ind($0)
     daddi r14, $0, p1s3
     syscall 3
;   a2=strlen(minuscole); 
     move $a2, r1
;   printf("Inserisci una stringa di sole lettere maiuscole\n"); 
      daddi $t1, $0, m2
      sd $t1, p1s5($0)
      daddi r14, $0, p1s5
      syscall 5
;   scanf("%s",maiuscole); 
     daddi $a1, $0, maiuscole
     sd $a1, ind($0)
     daddi r14, $0, p1s3
     syscall 3
     move $s1, r1
;   if(strlen(maiuscole)<a2) 
;        a2=strlen(maiuscole); 
     slt $t1, $s1, $a2
     beq $t1, $0, succ             
     move $a2, $s1
;   r1= elabora(minuscole, maiuscole,a2);             
succ: jal elabora
;   printf("Conta = %d\n", r1) ; 
           sd r1, p2s5($0)
           daddi $t1, $0, m3
           sd $t1, p1s5($0)
           daddi r14, $0, p1s5
           syscall 5

incrementa_i: daddi $s0, $s0, 1
                          j for

fine_exe: syscall 0


;int elabora(char *mi, char *ma, int a2) 
; $a0 = mi, $a1 = ma, $a2 = a2
;{int j,s; 
;  s=0;   
   
;  for(j=0;j<a2;j++)  
;   {  
;    if(ma[j] < 65 || ma[j] >= 91) // lettera maiuscola? 
;  continue;  
; else 
;  if (ma[j]+ 32 == mi[j]) // lettera minuscola== lettera maiuscola ?  
;        s++; 
   
;   }  
 
;return s; 
;}

elabora: daddi $sp, $sp, -16
                sd $s0, 0($sp)  ; j
                sd $s1, 8($sp)  ; s
                daddi $s0, $0, 0
                daddi $s1, $0, 0

forf:        slt $t0, $s0, $a2
                beq $t0, $0, return_s
;    if(ma[j] < 65 || ma[j] >= 91) // lettera maiuscola? 
;  continue;  
                dadd $t1, $s0, $a1
                lbu $t2, 0($t1)
                slti $t3, $t2, 65
                bne $t3, $0, incrementa_if
                slti $t3, $t2, 91
                beq $t3, $0, incrementa_if
; else 
;  if (ma[j]+ 32 == mi[j]) // lettera minuscola== lettera maiuscola ?  
;        s++; 
               dadd $t3, $s0, $a0
               lbu $t4, 0($t3)
               daddi $t2, $t2, 32
               bne $t2, $t4, incrementa_if
               daddi $s1, $s1, 1              

incrementa_if: daddi $s0, $s0, 1
                            j forf

return_s: move r1, $s1
                  ld $s0, 0($sp)
                  ld $s1, 8($sp)
                  daddi $sp, $sp, 16
                  jr $ra
