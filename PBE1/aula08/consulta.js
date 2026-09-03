const fs = require('fs');
const entrada = require('readline-sync');

console.log("=== SISTEMA DE CONSULTA DE ESTOQUE === \n");

try {
    const dadosTexto = fs.readFileSync ('estoque.json', 'utf-8');
    const produtos = JSON.parse(dadosTexto);

    const termoBusca = entrada.question ("Digite o nome do produto para buscar:");
    const resultado = produtos.find(p => toLowerCase () === termoBusca.toLowerCase());
    if (resultado) {
        console.log("\n PRODUTO ENCONTRADADO");
        console,log(`ID: ${resultado.id}`);
        console.log(`Nome: ${resultado.nome}`);
        console.log(`Quantidade em estoque: ${resultado.qtd}`);
    }else {
        console.log("\n Sinto muito. Produto não cadastrado no sitema");
    }
} catch(erro) {
    console.log("Erro ao acessar o banco de dados: "+ erro.message);
}
