const entrada = require('readline-sync');
const oficina = require('./funcoesOficina');

console.log("=== SISTEMA DE GESTAO DE OFICINA ===");

const peca = entrada.questionFloat("Preco da peca: ");
const horas = entrada.questionInt("Horas de servicos: ");
const tempoUso = entrada.questionInt("Meses desde o ultimo conserto: ");

const statusGarantia = oficina.verificarGarantia(tempoUso);
const total = oficina.calcularOrcamento(peca, horas);


const totalComDesconto = oficina.comDesconto(total);

console.log("\n --- RELATORIO FINAL ---");
console.log(`Orcamento: R$ ${total.toFixed(2)}`);
console.log(`Orcamento com desconto (5%): R$ ${totalComDesconto.toFixed(2)}`);
console.log(`Status da garantia: ${statusGarantia}`);
console.log("---------------------------------");