const entrada = require('readline-sync')

console.log("CALCULO")

const valor_total = entrada.questionFloat("Informe o valor da sua comanda")
const desconto = valor_total - (valor_total * 0.10)
if (valor_total >= 100){


    console.log(`\n O valor da sua comanda foi de ${desconto} `);
} else {
    console.log(`\ Sinto muito, ${nome}. Seu credito foi NEGADO, pela sua idade ${dataNascimento}`);
}