// PROJETO DO ALUNO - complete as funções abaixo.
// Execute com: npm start
const fs = require('node:fs');
const caminho = require('node:path');
const ARQUIVO = caminho.join(__dirname, 'maquinas.json');

function carregarMaquinas() {
  // TODO 1: ler ARQUIVO com fs.readFileSync(ARQUIVO, 'utf8').
  // TODO 2: converter o texto JSON em array com JSON.parse(...).
  // TODO 3: retornar o array.
  throw new Error('Implementar carregarMaquinas');
}

function listarMaquinas(maquinas) {
  // TODO 4: percorrer com forEach e apresentar id, nome e status.
  throw new Error('Implementar listarMaquinas');
}

function buscarPorId(maquinas, id) {
  // TODO 5: encontrar com find(). O ID recebido deve ser número.
  throw new Error('Implementar buscarPorId');
}

function filtrarPorStatus(maquinas, status) {
  // TODO 6: retornar um novo array com filter().
  throw new Error('Implementar filtrarPorStatus');
}

function filtrarPorSetor(maquinas, setor) {
  // DESAFIO: retornar máquinas do setor informado.
  throw new Error('Implementar filtrarPorSetor');
}

function executar() {
  // TODO 7: chamar carregarMaquinas, listarMaquinas e fazer consultas.
  // Exemplos a testar: id 3, id 99, status 'manutencao'.
  console.log('Sistema de consultas industriais - CRUD READ');
}

if (require.main === module) executar();
module.exports = { carregarMaquinas, listarMaquinas, buscarPorId, filtrarPorStatus, filtrarPorSetor };
