const entrada = require('readline-sync');
const industria = require('./calculoEnergia');

console.log('=== PAINEL INDUSTRIAL ===');

const nomeMaquina = entrada.question('Nome da maquina: ');
const potencia = entrada.questionInt('Potencia da maquina (Watts): ');
const horas = entrada.questionInt('Horas de uso no mes: ');
const precoKwh = entrada.questionFloat('Preco do kWh (R$): ');

const totalKwh = industria.calcularKwh(potencia, horas);
const custo2 = industria.calcularCusto(totalKwh, precoKwh);
const classificacao = industria.classConsumo(totalKwh);

console.log('\n--- RELATÓRIO ---');
console.log(`Máquina: ${nomeMaquina.toUpperCase()}`);
console.log(`Consumo Total: ${totalKwh.toFixed(2)} kWh`);
console.log(`Custo Estimado: R$ ${custo2.toFixed(2)}`);
console.log(`Status de Consumo: ${classificacao}`);
console.log('--------------------------------');
