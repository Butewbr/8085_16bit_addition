; bernardo_pandolfi_costa_addition.asm
;
; Title: 16 bit addition program for 8085
;
; Author: Bernardo Pandolfi Costa (19207646)
;
; Date: 25-Oct-2022
;
; Atividade:
;       1. Assuma que os números (em hexadecimal) são dados em complemento de 2.
;               * Em decimal, isso quer dizer que os números estão na faixa entre -32768 e 32767.
;       2. Os 8 LSB do primeiro número estão no endereço 2050H e os 8 MSB estão no endereço 2051H.
;       3. Já os 8 LSB do segundo número estão no endereço 2052H e os 8 MSB no endereço 2053H.
;       4. Os 8 LSB do resultado devem ser salvos no endereço 205BH e os 8 MSB no endereço 205CH. Considere sempre o valor em hexadecimal.
;       5. Indicador de overflow: No endereço 205AH deverá ser salvo um indicador de overflow:
;               a) Se *não* ocorrer nenhum overflow, então, no endereço, deverá ser salvo o valor 00H.
;               b) Se ocorrer um overflow positivo, deverá ser salvo o valor 01H no endereço.
;               c) Se ocorrer um overflow negativo, o valor 10H deverá ser salvo.
;               * Um overflow positivo ocorre quando a soma de dois números positivos resulta em um valor negativo.
;               * Um overflow negativo ocorre quando a soma de dois números negativos resulta em um valor positivo.
; 
; Resumo dos passos:
;       1. Ler os valores dados nos endereços dados.
;       2. Fazer a soma dos valores.
;       3. Verificar se ambos os valores são negativos, positivos ou de sinais diferentes.
;       4. Registrar os resultados nos endereços requisitados.


.org 0000H              ; código começa em 0000H para ser mais fácil de achar

        LHLD 2050H      ; vai ler os valores nos endereços 2050H e 2051H, colocando-os nos registradores L e H, respectivamente
        XCHG            ; troca os valores dos pares HL e DE, de modo que agora os valores de entrada estarão nos registradores D e E
        LHLD 2052H      ; vai ler os valores nos endereços 2052H e 2053H, colocando-os nos registradores L e H, respectivamente
        MOV C, L        ; passa os bits de L para C 
        MOV B, H        ; passa os bits de H para B
        DAD D           ; DAD faz uma dupla adição (16 bits), com o par indicado (nesse caso par DE) com o par HL e armazena o resultado no par HL
        MVI C, 00H      ; C vai carregar o valor do carry, então, inicializamos o registrador em 0
        ; JNC reg         ; se não tem carry, já registra direto

; VERIFICAÇÃO DE DUPLO POSITIVO / DUPLO NEGATIVO
        MVI A, 00H      ; zeramos o acumulador
        MOV A, D        ; colocamos o valor de D no acumulador
        RAL             ; move o valor do acumulador para a esquerda, colocando o bit mais significativo no CARRY
        JNC pos1        ; se o carry for 0, skippa
        JMP neg1        ; vai pro passo de primeiro é negativo

; primeiro input é negativo
neg1:   MVI A, 00H      ; zeramos o acumulador
        MOV A, B        ; coloca o valor de B no acumulador
        RAL             ; move o valor do acumulador para a esquerda, colocando o bit mais significativo no carry
        JNC dif          ; se o carry for 0, os um dos valores é negativo e um positivo
        JMP dbneg       ; se for negativo vai pro passo de dois negativos

pos1:   MVI A, 00H      ; zeramos o acumulador
        MOV A, B        ; coloca o valor de B no acumulador
        RAL             ; move o valor do acumulador para a esquerda, colocando o bit mais significativo no carry
        JNC dbpos       ; se o carry for 0, os dois valores são positivos
        JMP dif         ; se o carry for 1, os dois valores tem sinais diferentes

; os dois são negativos
dbneg:  MVI C, 10H      ; colocamos C com o overflow de duplo negativo
        JMP reg         ; pulamos para a instrução de registro

; os dois são positivos:
; só precisamos colocar 01H se o primeiro dígito da resposta for 1 (o que faz o número ficar negativo)
dbpos:  MVI A, 00H      ; zeramos o acumulador
        MOV A, H        ; colocamos o valor do resultado no acumulador
        RAL             ; movemos o valor do acumulador pra esquerda, se o MSB for 1, vai ter carry
        JNC reg         ; se não tem carry (o MSB é 0), pode registrar o resultado com 00H
        MVI C, 01H      ; se tem carry, precisamos colocar o 01 pra não ser mais negativo
        JMP reg         ; pulamos para a instrução de registro

dif:    MVI C, 00H      ; colocamos C com o overflow de diferentes 
        JMP reg         ; pulamos para a instrução de registro

reg:    SHLD 205BH      ; registra o resultado nos endereços 205BH e 205CH
        MOV A, C        ; movemos o valor do carry ao acumulador
        STA 205AH       ; armazenamos o resultado do carry na coordenada especificada
        STC             ; liga a flag carry
        CMC             ; substitui a flag carry pelo complemento (zera)
        HLT             ; finalizamos o programa