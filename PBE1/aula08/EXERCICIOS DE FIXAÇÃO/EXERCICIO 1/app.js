const readline = require('readline-sync');
const converterDolar = require('./conversor');

const valorDolar = parseFloat(readline.question('Digite o valor em Dolar: '));
const valorReal = converterDolar(valorDolar);

console.log(`O valor em Reais e: R$ ${valorReal.toFixed(2)}`);