const entrada = require('readline-sync');
console.log("CONTROLE DE ACESSO AO LABORATORIO");

const idade = entrada.questionInt("Qual a idade do aluno? ");
const autorizacao = entrada.question("Possui autorizacao? : ");
const acompanhadoProfessor = entrada.question("Esta acompanhado por professor?: ");
const suspenso = entrada.question("O aluno esta suspenso?: ");

const temAutorizacao = (autorizacao === "S" || autorizacao === "s");
const comProfessor = (acompanhadoProfessor === "S" || acompanhadoProfessor === "s");
const naoEstaSuspenso = (suspenso === "N" || suspenso === "n");



if (naoEstaSuspenso && ((idade >= 16 && temAutorizacao) || comProfessor)) {
    console.log("ACESSO LIBERADO");
} else {
    console.log("ACESSO NEGADO");
}