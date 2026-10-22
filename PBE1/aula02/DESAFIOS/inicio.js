const entrada = require('readline-sync')

console.log("---SISTEMA DE ANALISE DE CREDITO---")

// coleta de dados

const nome = entrada.question("Nome do Cliente: ");
const idade = entrada.questionInt("Nome do Cliente: ");
const renda = entrada.questionFloat("Nome do Cliente: ");
const teImovel = entrada.KeyInYNStrict("Nome do Cliente: ");

// A Logica Combinada
// (idade >=18) é obrigatorio
// (renda >= 2500 || telemovel === true)um dois tem que ser venda

if (idade >= 18 && (renda >=2500 || temImovel === true)) {
    console.log('\nPARABENS, ${nome}! Seu credito foi aprovado!');
} else {
    console.log(`\ Sinto muito, ${nome}. Seu credito foi NEGADO`);
}