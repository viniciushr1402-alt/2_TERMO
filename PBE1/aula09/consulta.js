const fs = require('fs');

const dadosArquivo = fs.readFileSync('funcionarios.json', 'utf8');
const funcionarios = JSON.parse(dadosArquivo);

console.log('--- Lista de Todos os Funcionários ---');
console.log(funcionarios);
function buscarPorId(id) {
    return funcionarios.find(pessoa => pessoa.id === id);
}
function buscarPorNome(nome) {
    return funcionarios.find(pessoa => pessoa.nome.toLowerCase() === nome.toLowerCase());
}


function filtrarPorFuncao(funcao) {
    return funcionarios.filter(pessoa => pessoa.funcao.toLowerCase() === funcao.toLowerCase());
}


console.log('Teste de  Consultas ');

console.log('Busca por ID 2:');
console.log(buscarPorId(2));

console.log('Busca por ID 99:');
const resultado99 = buscarPorId(99);
if (resultado99) {
    console.log(resultado99);
} else {
    console.log('Funcionário não encontrado.');
}

console.log('Busca por Nome:');
console.log(buscarPorNome('Ana Silva'));


console.log('Filtro por Função:');
console.log(filtrarPorFuncao('Analista'));