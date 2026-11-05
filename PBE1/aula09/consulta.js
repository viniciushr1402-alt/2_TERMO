const fs = require('fs');

// Ler e converter o arquivo JSON
const dadosArquivo = fs.readFileSync('funcionarios.json', 'utf8');
const funcionarios = JSON.parse(dadosArquivo);

console.log('--- Lista de Todos os Funcionários ---');
console.log(funcionarios);

// Função de busca por ID
function buscarPorId(id) {
    return funcionarios.find(pessoa => pessoa.id === id);
}

// Função de busca por Nome (ignorando letras maiúsculas/minúsculas)
function buscarPorNome(nome) {
    return funcionarios.find(pessoa => pessoa.nome.toLowerCase() === nome.toLowerCase());
}

// Função de filtro por Função
function filtrarPorFuncao(funcao) {
    return funcionarios.filter(pessoa => pessoa.funcao.toLowerCase() === funcao.toLowerCase());
}

// --- Testes solicitados no roteiro ---
console.log('\n--- Testando Consultas ---');

// Teste ID 2
console.log('Busca por ID 2:');
console.log(buscarPorId(2));

// Teste ID 99 (Não encontrado)
console.log('Busca por ID 99:');
const resultado99 = buscarPorId(99);
if (resultado99) {
    console.log(resultado99);
} else {
    console.log('Funcionário não encontrado.');
}

// Teste Nome (mude 'NomeFicticio' para 'Ana Silva', por exemplo)
console.log('Busca por Nome:');
console.log(buscarPorNome('Ana Silva'));

// Teste Filtro por Função (mude 'FuncaoCompartilhada' para 'Analista', que tem duas pessoas)
console.log('Filtro por Função:');
console.log(filtrarPorFuncao('Analista'));