const entrada = require('readline-sync');

const nome = entrada.question("qual seu nome? ")
const idade = entrada.questionInt("Qual sua Idade? ");
const contribuicao = entrada.questionFloat("Quanto tempo de contribuição? ")

if (idade >= 65 &&(contribuicao >= 30 )) {

    console.log(`O trabalhador ${nome} ja pode se aposentar`);
} else {
    console.log(`O trabalhador ${nome} ainda não pode se aposentar`);
}
