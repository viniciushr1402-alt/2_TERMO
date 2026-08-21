const entrada = require('readline-sync');

console.log("Seja bem vindo a Classificação")

const idade_aluno = entrada.questionInt("Quantos anos tem o aluno? ")

if (idade_aluno >= 5 && idade_aluno <= 10) {
    console.log("O aluno é: Infantil")
    
} else if (idade_aluno >= 11 && idade_aluno <= 17) {
    console.log("O aluno é: Juvenil")

} else if (idade_aluno >= 18 && idade_aluno <= 60) {
    console.log("O aluno é: Adulto")

} else if (idade_aluno > 60) {
    console.log("O aluno é: Senior")
} else {
    console.log("O aluno é muito novo nao podera participar")
}