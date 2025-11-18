;int processa(char *a0, char *a1) 
;{int j,c; 
 
;  c=0; 
;  j=0;   
;  while (a0[j]!=0 && a1[j]!=0) 
;   { 
; if(a0[j] == a1[j])  
;  c++; 
; j++; 
;}  
 
;return c; 
;} 
 
;main() { 
;  char ST1[16], ST2[16]; 
;  int i, ris;      
     
;     for(i=0; i<4;i++) 
;     { 
;   printf("Inserisci una stringa\n"); 
;       scanf("%s",ST1); 
         
;   printf("Inserisci una stringa\n"); 
;       scanf("%s",ST2); 
 
;       ris= processa(ST1,ST2);        
        
  
;  printf("%d – Ris = %d\n", i, ris) ;    
;     }  
;} 

.data
ST1: .space 16
ST2: .space 16

m1: .asciiz "Inserisci una stringa\n"
m2: .asciiz "%d – Ris = %d\n"

p1s5: .space 8
p2s5: .space 8

p1s3: .word 0
ind: .space 8
dim: .word 16

.code 
;  char ST1[16], ST2[16]; 
;  int i, ris;      
daddi $s0, $0, 0 ; i = 0
for: slti $t0, $s0, 4
        beq $t0, $0, fine_exe
