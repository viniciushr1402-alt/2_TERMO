const entrada = require('readline-sync')
const idade = entrada.questionInt("Qual sua Idade? ");

if (idade >= 18) {
    console.log("Acesso liberado! Divirta-se.");
} else {
    console.log("Acesso negado. Vá para a casa estudar Node.js ")
}

