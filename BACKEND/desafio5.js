const entrada = require('readline-sync');

console.log(" Descubra sua renda mensal")

const nome = entrada.question("Digite seu nome: ")
const Renda = entrada.questionInt("Digite a sua Renda Mensal: ")
const sujo = entrada.keyInYNStrict("O seu nome esta sujo? ")

if (Renda >= 2000 && sujo === false) {
    console.log(`\n Parabéns ${nome}, seu emprestimo foi aprovado`)
} else {
    console.log(`\n Que tristeza ${nome}, seu emprestimo foi negado`)
