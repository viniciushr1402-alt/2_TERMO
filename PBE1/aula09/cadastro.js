const fs = require('fs');

// Criamos a lista com 4 funcionários diretamente (substitua pelos nomes que quiser)
const funcionarios = [
    { id: 1, nome: "Ana Silva", idade: 28, funcao: "Analista" },
    { id: 2, nome: "Bruno Souza", idade: 35, funcao: "Desenvolvedor" },
    { id: 3, nome: "Carla Dias", idade: 30, funcao: "Analista" },
    { id: 4, nome: "Daniel Lima", idade: 40, funcao: "Gerente" }
];

// Converte para JSON e salva no arquivo
const json = JSON.stringify(funcionarios, null, 2);
fs.writeFileSync('funcionarios.json', json, 'utf8');

console.log("Funcionarios cadastrados e salvos com sucesso!");