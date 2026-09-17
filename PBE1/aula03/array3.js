const entrada = require("readline-sync")
const notas = [];

const quantidade = entrada.questionInt(
    "Quantas notas deseja cadastrar? "
);

for(let i = 0;i < quantidade; i++) {
    let nota = entrada.questionFloat(
        `Digite a nota ${ + 1}: `

    );

    notas.push(nota);

}

console.log("Notas cadstradas: ")
console.log(notas);

console.log(`Quantidadede notas: ${notas.length}`)