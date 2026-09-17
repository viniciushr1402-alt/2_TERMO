const entrada = require('readline-sync');

const valorTotal = entrada.questionFloat("Digite o valor total do produto: ");
const totalParcelas = entrada.questionInt("Digite a quantidade de parcelas (minimo 12): ");

if (totalParcelas >= 1 && totalParcelas <= 12) {
    const valorParcela = valorTotal / totalParcelas;
    for (let i = 1; i <= totalParcelas; i++) {
    
        console.log(`Parcela ${i}: R$ ${valorParcela.toFixed(2)}`);
    }
} else {
    console.log("Quantidade de parcelas invalida, Escolha um numero de 1 a 12.");
}