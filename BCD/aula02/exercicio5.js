// const entrada = require('readline-sync');

// function calcularDesconto(precoOriginal) {
//     return precoOriginal * 0.85;
// }

// const estoque = [
//     { nome: "Monitor", preco: 800 },
//     { nome: "Teclado", preco: 150 },
//     { nome: "Mouse", preco: 80 }
// ];

// console.log("=== TABELA DE PRECOS COM OBJETOS (15% OFF) ===");

// for (let i = 0; i < estoque.length; i++) {

//     let precoComDesconto = calcularDesconto(estoque[i].preco);

//     console.log(`${estoque[i].nome}:`);
//     console.log(`  De: R$ ${estoque[i].preco.toFixed(2)}`);
//     console.log(`  Por: R$ ${precoComDesconto.toFixed(2)}\n`);
// 

const entrada = require('readline-sync');

const valorTotal = entrada.questionFloat("Digite o valor total do produto: ");
const totalParcelas = entrada.questionInt("Digite a quantidade de parcelas (maximo 12): ");

if (totalParcelas >= 1 && totalParcelas <= 12) {
    const valorParcela = valorTotal / totalParcelas;
    
    for (let i = 1; i <= totalParcelas; i++) {
        // .toFixed(2) garante duas casas decimais para o valor em dinheiro
        console.log(`Parcela ${i}: R$ ${valorParcela.toFixed(2)}`);
    }
} else {
    console.log("Quantidade de parcelas invalida! Escolha um numero de 1 a 12.");
}

const entrada = require('readline-sync');

// Definicao da funcao que calcula a area
function calcularArea(largura, comprimento) {
    return largura * comprimento;
}

// Loop no programa principal para pedir os dados de 3 terrenos
for (let i = 1; i <= 3; i++) {
    console.log(`\n--- DADOS DO TERRENO ${i} ---`);
    const larg = entrada.questionFloat("Digite a largura (em metros): ");
    const comp = entrada.questionFloat("Digite o comprimento (em metros): ");
    
    const areaTotal = calcularArea(larg, comp);
    console.log(`A area total do Terreno ${i} e: ${areaTotal}m²`);
}

const entrada = require('readline-sync');

// Criacao do Array de Objetos com os filmes cadastrados
const cinema = [
    { titulo: "Rei Leao (Livre)", classificacao: 0 },
    { titulo: "Batman (14 anos)", classificacao: 14 },
    { titulo: "Deadpool (18 anos)", classificacao: 18 }
];

const idadeUsuario = entrada.questionInt("Qual a sua idade? ");

console.log("\nFilmes liberados para voce:");
let nenhumFilmeEncontrado = true;

// Loop para percorrer a lista de filmes e validar a idade
for (let i = 0; i < cinema.length; i++) {
    if (idadeUsuario >= cinema[i].classificacao) {
        console.log(`- ${cinema[i].titulo}`);
        nenhumFilmeEncontrado = false;
    }
}

if (nenhumFilmeEncontrado) {
    console.log("Nenhum filme disponivel para a sua idade.");
}
