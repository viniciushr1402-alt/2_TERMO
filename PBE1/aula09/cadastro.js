const fs = require('fs');

const funcionarios = [
    { id: 1, nome: "Ana Silva", idade: 28, funcao: "Analista" },
    { id: 2, nome: "Bruno Souza", idade: 35, funcao: "Desenvolvedor" },
    { id: 3, nome: "Carla Dias", idade: 30, funcao: "Analista" },
    { id: 4, nome: "Daniel Lima", idade: 40, funcao: "Gerente" }
];

const json = JSON.stringify(funcionarios, null, 2);
fs.writeFileSync('funcionarios.json', json, 'utf8');

console.log("Funcionarios cadastrados e salvos com sucesso!");