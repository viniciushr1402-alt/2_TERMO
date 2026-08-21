const readline = require('readline-sync');
const { verificarPeso } = require('./funcoesBalança.js');

while (true) {
    try {
        const entrada = readline.question('Digite o peso da peca (ou "sair" para encerrar): ');
        if (entrada.toLowerCase() === 'sair') {
            console.log('Sistema de balança encerrado.');
            break;
        }

        const resultado = verificarPeso(entrada);
        console.log(` ${resultado}`);

    } catch (error) {
        console.log(`ALERTA: ${error.message}`);
    }
}