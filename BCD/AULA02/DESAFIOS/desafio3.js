const entrada = require('readline-sync');

function Area(largura, comprimento) {
    return largura * comprimento;
}
for (let i = 1; i <= 3; i++) {
    console.log(` Dados do Terreno ${i}`);
  
  const larg = entrada.questionFloat("Digite a largura (em metros): ");
    const comp = entrada.questionFloat("Digite o comprimento (em metros): ");
    const areaTotal = Area(larg, comp);
    console.log(`A area total do Terreno ${i} e: ${areaTotal}m²`);
}