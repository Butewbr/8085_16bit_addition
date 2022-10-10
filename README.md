# 16 Bit addition for 8085
Programa de adição de dois números de 16 bits com complemento de 2 em 8085.

Este programa foi feito para uma tarefa da disciplina Organização e Arquitetura de Computadores I. Segue a tarefa:

## Tarefa 2
1. Assuma que os números (em *hexadecimal*) são dados em complemento de 2.
    * Em decimal, isso quer dizer que os números estão na faixa entre -32768 e 32767.
2. Os 8 LSB do primeiro número estão no endereço 2050H e os 8 MSB estão no endereço 2051H.
3. Já os 8 LSB do segundo número estão no endereço 2052H e os 8 MSB no endereço 2053H.
    * Não é necessário nenhuma instrução para escrever nesses <ins>endereços</ins>, apenas instruções de <ins>leitura</ins>.
4. Os 8 LSB do resultado devem ser salvos no endereço 205BH e os 8 MSB no endereço 205CH. Considere sempre o valor em hexadecimal.
5. Indicador de *overflow*: No endereço 205AH deverá ser salvo um indicador de overflow:<br>
    a) Se **não** ocorrer nenhum overflow, então, no endereço, deverá ser salvo o valor 00H.<br>
    b) Se ocorrer um *overflow positivo*, deverá ser salvo o valor 01H no endereço.<br>
    c) Se ocorrer um *overflow negativo*, o valor 10H deverá ser salvo.<br>
    * Um overflow positivo ocorre quando a soma de dois números positivos resulta em um valor negativo.
    * Um overflow negativo ocorre quando a soma de dois números negativos resulta em um valor positivo.
 
## Resumo dos passos:
1. Ler os valores dados nos endereços dados.
2. Fazer a soma dos valores.
3. Verificar se ambos os valores são negativos, positivos ou de sinais diferentes.\\
    3.1. Indicação do overflow baseado na resposta dos sinais.
4. Registrar os resultados nos endereços requisitados.