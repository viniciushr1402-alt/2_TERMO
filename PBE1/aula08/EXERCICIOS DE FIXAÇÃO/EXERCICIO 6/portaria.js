const readline = require('readline-sync');
const listaVisitantes = [];
while (true) {
  const resposta = readline.question('Deseja cadastrar um visitante? (s/n): ').toLowerCase();
  if (resposta === 'n') break;
  if (resposta === 's') {
    const nome = readline.question('Nome: ');
    const empresa = readline.question('Empresa: ');
    listaVisitantes.push({ nome, empresa });
  } else {
    console.log('Opcao invalida!');
  }
}
console.log(`\n--- Relatorio de Visitantes (${listaVisitantes.length}) ---`);
listaVisitantes.forEach((v, i) => {
  console.log(`${i + 1}. ${v.nome} - ${v.empresa}`);
});