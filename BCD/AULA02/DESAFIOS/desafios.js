const entrada = require('readline-sync')

console.log("---SISTEMA DE VOTAÇÃO---")


const nome = entrada.question("Nome do Individuo: ");
 const dataNascimento = entrada.questionInt("Qual sua data de nascimento?: ");

 idade = (2026 - dataNascimento)
if (dataNascimento >= 16) {
    console.log(`\nPARABENS, ${nome}. ! Seu voto foi aprovado! sua data de nasximento e maior ${dataNascimento}`);
} else {
    console.log(`\ Sinto muito, ${nome}. Seu credito foi NEGADO, pela sua idade ${dataNascimento}`);
}