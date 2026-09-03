const fs = require('fs');

console.log("=== SISTEMA DE ALERTA DE MANUTENÇÃO ===\n");

// Dados das máquinas declarados diretamente no código
const maquinas = [
  { "id": 1, "nome": "Torno CNC", "horasUso": 1200 },
  { "id": 2, "nome": "Fresadora", "horasUso": 800 },
  { "id": 3, "nome": "Prensa Hidraulica", "horasUso": 1500 },
  { "id": 4, "nome": "Corte a Laser", "horasUso": 500 }
];

try {
    // Filtra as máquinas com mais de 1000 horas de uso
    const maquinasEmPerigo = maquinas.filter(m => m.horasUso > 1000);

    // Exibe os nomes no terminal
    if (maquinasEmPerigo.length > 0) {
        console.log("MÁQUINAS EM PERIGO (Mais de 1000h de uso):\n");

        // Substituto do forEach: loop for...of convencional
        for (const maquina of maquinasEmPerigo) {
            console.log(`- ${maquina.nome} (${maquina.horasUso} horas de uso)`);
        }

        // Salva a nova lista no arquivo 'manutencao_urgente.json'
        const dadosParaSalvar = JSON.stringify(maquinasEmPerigo, null, 2);
        fs.writeFileSync('manutencao_urgente.json', dadosParaSalvar, 'utf-8');

        console.log("\nLista de alertas salva em 'manutencao_urgente.json' com sucesso!");

    } else {
        console.log(" Nenhuma máquina necessita de manutenção preventiva no momento.");
    }

} catch (erro) {
    console.log("Erro ao processar os dados: " + erro.message);
}
