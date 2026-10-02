const readline = require('readline-sync');
const calculos = require('./calculosvendas');
const nome = readline.question('Nome do cliente: ');
const preco = readline.questionFloat('Preco do produto: ');
const qtd = readline.questionInt('Quantidade: ');
const total = calculos.calcularTotal(preco, qtd);
const cupom = calculos.GeraCupom(nome, total);

console.log(cupom);