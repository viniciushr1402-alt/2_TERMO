const readline = require('readline-sync');
const pecasDefeituosas = [];
const quantidade = readline.question('Quantas pecas com defeito foram encontradas? ');
for (let i = 0; i < quantidade; i++) {
    const numeroSerie = readline.question(`Digite o numero de serie da peca ${i + 1}: `);
    pecasDefeituosas.push(numeroSerie);
}
let listaSeries = '';
for (const serie of pecasDefeituosas) {
    if (listaSeries === '') {
        listaSeries = serie;
    } else {
        listaSeries += ', ' + serie;
    }
}
console.log(`Total de pecas: ${pecasDefeituosas.length} - Numeros de serie: ${listaSeries}`);