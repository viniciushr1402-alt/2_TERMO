const cinema = [
    { titulo: "Rei Leao ´[Livre]", classificacao: 0 },
    { titulo: "Batman [14 anos]", classificacao: 14 },
    { titulo: "Deadpool [18 anos]", classificacao: 18 }
];
const idadeUsuario = entrada.questionInt("Qual a sua idade? ");
console.log("\nFilmes disponiveis para voce:");
let nenhumFilmeEncontrado = true;
for (let i = 0; i < cinema.length; i++) {
    if (idadeUsuario >= cinema[i].classificacao) {
        console.log(`${cinema[i].titulo}`);
        nenhumFilmeEncontrado = false;
    }
}
if (nenhumFilmeEncontrado) {
    console.log("Nenhum filme disponivel para a sua idade.");
}
